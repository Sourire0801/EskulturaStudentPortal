-- ====================================================================
-- FIX: STUDENT NUMBER UNIQUENESS, CLAIMING & VALIDATION FUNCTIONS
-- Run this script in Supabase SQL Editor to resolve unique constraint errors
-- ====================================================================

-- 1. UPDATE handle_new_user TRIGGER
-- Auto-links imported member profiles when a user signs up with the same email
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  -- Insert or update user role profile
  INSERT INTO public.profiles (id, email, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.email, ''),
    CASE 
      WHEN LOWER(NEW.email) = 'whitesilver2005@gmail.com' THEN 'admin'
      ELSE COALESCE(NEW.raw_user_meta_data->>'role', 'student')
    END
  )
  ON CONFLICT (id) DO UPDATE
  SET email = EXCLUDED.email,
      role = CASE 
        WHEN LOWER(EXCLUDED.email) = 'whitesilver2005@gmail.com' THEN 'admin'
        ELSE public.profiles.role
      END;

  -- If an unclaimed imported student profile exists with matching email, link it!
  IF NEW.email IS NOT NULL AND TRIM(NEW.email) != '' THEN
    UPDATE public.student_profiles
    SET user_id = NEW.id
    WHERE LOWER(TRIM(COALESCE(email, ''))) = LOWER(TRIM(NEW.email))
      AND user_id IS NULL;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Re-apply trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();


-- 2. RPC: CHECK IF STUDENT NUMBER IS AVAILABLE (Bypasses RLS safely)
CREATE OR REPLACE FUNCTION public.check_student_number_available(
  p_student_number TEXT,
  p_user_id UUID DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_clean_sn TEXT;
  v_existing RECORD;
BEGIN
  v_clean_sn := TRIM(COALESCE(p_student_number, ''));

  IF v_clean_sn = '' THEN
    RETURN jsonb_build_object('available', true);
  END IF;

  SELECT id, user_id, email, status INTO v_existing
  FROM public.student_profiles
  WHERE LOWER(TRIM(student_number)) = LOWER(v_clean_sn)
  LIMIT 1;

  -- Case 1: Student number not found anywhere in table -> Available
  IF v_existing IS NULL THEN
    RETURN jsonb_build_object('available', true);
  END IF;

  -- Case 2: Belongs to the caller (own record) -> Available
  IF p_user_id IS NOT NULL AND v_existing.user_id = p_user_id THEN
    RETURN jsonb_build_object('available', true, 'is_own', true);
  END IF;

  -- Case 3: Unclaimed imported record (user_id IS NULL) -> Available to claim!
  IF v_existing.user_id IS NULL THEN
    RETURN jsonb_build_object(
      'available', true,
      'is_claimable', true,
      'record_id', v_existing.id
    );
  END IF;

  -- Case 4: Already registered by another user account
  RETURN jsonb_build_object(
    'available', false,
    'message', 'This student number is already registered to another account.'
  );
END;
$$;


-- 3. RPC: SAVE OR CLAIM STUDENT PROFILE (Safe Upsert & Claiming)
CREATE OR REPLACE FUNCTION public.save_or_claim_student_profile(
  p_user_id UUID,
  p_payload JSONB,
  p_status TEXT DEFAULT 'submitted'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_clean_sn TEXT;
  v_existing_by_user RECORD;
  v_existing_by_sn RECORD;
  v_target_id UUID;
  v_result RECORD;
  v_user_email TEXT;
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  -- Verify caller is authorized
  IF auth.uid() IS NULL OR (auth.uid() != p_user_id AND NOT public.is_admin()) THEN
    RAISE EXCEPTION 'Unauthorized operation';
  END IF;

  v_clean_sn := TRIM(COALESCE(p_payload->>'student_number', ''));
  
  IF v_clean_sn = '' THEN
    RAISE EXCEPTION 'Student number is required';
  END IF;

  -- Parse UUIDs safely
  IF p_payload->>'program_id' IS NOT NULL AND TRIM(p_payload->>'program_id') != '' THEN
    v_prog_id := (p_payload->>'program_id')::UUID;
  ELSE
    v_prog_id := NULL;
  END IF;

  IF p_payload->>'eskultura_unit_id' IS NOT NULL AND TRIM(p_payload->>'eskultura_unit_id') != '' THEN
    v_unit_id := (p_payload->>'eskultura_unit_id')::UUID;
  ELSE
    v_unit_id := NULL;
  END IF;

  -- Get user email from auth
  SELECT email INTO v_user_email FROM auth.users WHERE id = p_user_id;

  -- 1. Check if user already has a student profile
  SELECT * INTO v_existing_by_user
  FROM public.student_profiles
  WHERE user_id = p_user_id
  LIMIT 1;

  -- 2. Check if student number exists anywhere in table
  SELECT * INTO v_existing_by_sn
  FROM public.student_profiles
  WHERE LOWER(TRIM(student_number)) = LOWER(v_clean_sn)
  LIMIT 1;

  -- 3. If student number belongs to another user
  IF v_existing_by_sn IS NOT NULL 
     AND v_existing_by_sn.user_id IS NOT NULL 
     AND v_existing_by_sn.user_id != p_user_id THEN
    RAISE EXCEPTION 'This student number is already registered by another student.';
  END IF;

  -- 4. Determine target record ID to update
  IF v_existing_by_user IS NOT NULL THEN
    v_target_id := v_existing_by_user.id;
    -- If an unclaimed imported record also existed with this SN, delete it to prevent unique collision
    IF v_existing_by_sn IS NOT NULL 
       AND v_existing_by_sn.user_id IS NULL 
       AND v_existing_by_sn.id != v_target_id THEN
      DELETE FROM public.student_profiles WHERE id = v_existing_by_sn.id;
    END IF;
  ELSIF v_existing_by_sn IS NOT NULL AND v_existing_by_sn.user_id IS NULL THEN
    -- Claim the imported record
    v_target_id := v_existing_by_sn.id;
  ELSE
    v_target_id := NULL;
  END IF;

  -- 5. Perform Update or Insert
  IF v_target_id IS NOT NULL THEN
    UPDATE public.student_profiles
    SET
      user_id = p_user_id,
      email = COALESCE(v_user_email, email),
      surname = TRIM(p_payload->>'surname'),
      first_name = TRIM(p_payload->>'first_name'),
      middle_initial = UPPER(TRIM(COALESCE(p_payload->>'middle_initial', ''))),
      student_number = v_clean_sn,
      program_id = v_prog_id,
      year_level = p_payload->>'year_level',
      gender = p_payload->>'gender',
      date_of_birth = (p_payload->>'date_of_birth')::DATE,
      complete_address = TRIM(p_payload->>'complete_address'),
      contact_number = TRIM(p_payload->>'contact_number'),
      facebook_profile = TRIM(p_payload->>'facebook_profile'),
      achievements = COALESCE(NULLIF(TRIM(p_payload->>'achievements'), ''), 'NONE'),
      eskultura_unit_id = v_unit_id,
      photo_url = p_payload->>'photo_url',
      signature_url = p_payload->>'signature_url',
      status = p_status,
      updated_at = timezone('utc'::text, now())
    WHERE id = v_target_id
    RETURNING * INTO v_result;
  ELSE
    INSERT INTO public.student_profiles (
      user_id,
      email,
      surname,
      first_name,
      middle_initial,
      student_number,
      program_id,
      year_level,
      gender,
      date_of_birth,
      complete_address,
      contact_number,
      facebook_profile,
      achievements,
      eskultura_unit_id,
      photo_url,
      signature_url,
      status
    )
    VALUES (
      p_user_id,
      v_user_email,
      TRIM(p_payload->>'surname'),
      TRIM(p_payload->>'first_name'),
      UPPER(TRIM(COALESCE(p_payload->>'middle_initial', ''))),
      v_clean_sn,
      v_prog_id,
      p_payload->>'year_level',
      p_payload->>'gender',
      (p_payload->>'date_of_birth')::DATE,
      TRIM(p_payload->>'complete_address'),
      TRIM(p_payload->>'contact_number'),
      TRIM(p_payload->>'facebook_profile'),
      COALESCE(NULLIF(TRIM(p_payload->>'achievements'), ''), 'NONE'),
      v_unit_id,
      p_payload->>'photo_url',
      p_payload->>'signature_url',
      p_status
    )
    RETURNING * INTO v_result;
  END IF;

  RETURN to_jsonb(v_result);
END;
$$;

-- Grant execute permissions to authenticated users
GRANT EXECUTE ON FUNCTION public.check_student_number_available(TEXT, UUID) TO authenticated, anon;
GRANT EXECUTE ON FUNCTION public.save_or_claim_student_profile(UUID, JSONB, TEXT) TO authenticated;
