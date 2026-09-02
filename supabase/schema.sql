-- ====================================================================
-- ESKULTURA STUDENT REGISTRATION AND MEMBERSHIP DATA ENTRY SYSTEM
-- COMPLETE SUPABASE POSTGRESQL SCHEMA & ROW LEVEL SECURITY (RLS)
-- ====================================================================

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. ENUMS & DOMAINS (Optional / Handled via CHECK constraints)

-- 3. PROFILES TABLE (Linked directly to auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'student' CHECK (role IN ('student', 'admin')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 4. ACADEMIC PROGRAMS TABLE
CREATE TABLE IF NOT EXISTS public.programs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 5. ESKULTURA UNITS TABLE
CREATE TABLE IF NOT EXISTS public.eskultura_units (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 6. STUDENT PROFILES TABLE
CREATE TABLE IF NOT EXISTS public.student_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE REFERENCES public.profiles(id) ON DELETE CASCADE,
    email TEXT,
    
    -- Personal Information
    surname TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_initial TEXT NOT NULL,
    student_number TEXT UNIQUE NOT NULL,
    program_id UUID REFERENCES public.programs(id) ON DELETE RESTRICT,
    year_level TEXT NOT NULL CHECK (year_level IN ('First Year', 'Second Year', 'Third Year', 'Fourth Year')),
    gender TEXT NOT NULL CHECK (gender IN ('Male', 'Female', 'Prefer not to say')),
    date_of_birth DATE NOT NULL,
    
    -- Contact Information
    complete_address TEXT NOT NULL,
    contact_number TEXT NOT NULL,
    facebook_profile TEXT NOT NULL,
    
    -- Membership Information
    achievements TEXT NOT NULL DEFAULT 'NONE',
    eskultura_unit_id UUID REFERENCES public.eskultura_units(id) ON DELETE RESTRICT,
    
    -- Documents / URLs
    photo_url TEXT,
    signature_url TEXT,
    
    -- Status
    status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'submitted', 'archived')),
    
    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 7. INDEXES FOR HIGH-PERFORMANCE SEARCH & FILTERING
CREATE INDEX IF NOT EXISTS idx_student_profiles_user_id ON public.student_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_student_profiles_student_number ON public.student_profiles(student_number);
CREATE INDEX IF NOT EXISTS idx_student_profiles_program_id ON public.student_profiles(program_id);
CREATE INDEX IF NOT EXISTS idx_student_profiles_unit_id ON public.student_profiles(eskultura_unit_id);
CREATE INDEX IF NOT EXISTS idx_student_profiles_status ON public.student_profiles(status);
CREATE INDEX IF NOT EXISTS idx_student_profiles_year_level ON public.student_profiles(year_level);
CREATE INDEX IF NOT EXISTS idx_student_profiles_gender ON public.student_profiles(gender);
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);

-- 8. HELPER SECURITY DEFINER FUNCTION FOR ADMIN CHECK
-- (Avoids infinite recursion in RLS policies)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
$$;

-- 9. TRIGGER: AUTO-UPDATE updated_at TIMESTAMP
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_profiles_updated_at ON public.profiles;
CREATE TRIGGER set_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();

DROP TRIGGER IF EXISTS set_student_profiles_updated_at ON public.student_profiles;
CREATE TRIGGER set_student_profiles_updated_at
  BEFORE UPDATE ON public.student_profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_updated_at();

-- 10. TRIGGER: AUTO-CONFIRM USER EMAIL (Bypasses email verification)
CREATE OR REPLACE FUNCTION public.auto_confirm_user()
RETURNS TRIGGER AS $$
BEGIN
  NEW.email_confirmed_at = COALESCE(NEW.email_confirmed_at, NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_before_insert ON auth.users;
CREATE TRIGGER on_auth_user_before_insert
  BEFORE INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.auto_confirm_user();

-- 11. TRIGGER: AUTO-CREATE PROFILE ON AUTH.USERS SIGNUP
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
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
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- 11. ENABLE ROW LEVEL SECURITY (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.programs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.eskultura_units ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_profiles ENABLE ROW LEVEL SECURITY;

-- 12. RLS POLICIES FOR PROFILES
DROP POLICY IF EXISTS "Users can view own profile or admins view all" ON public.profiles;
CREATE POLICY "Users can view own profile or admins view all"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id OR public.is_admin());

DROP POLICY IF EXISTS "Users can update own profile or admins update all" ON public.profiles;
CREATE POLICY "Users can update own profile or admins update all"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id OR public.is_admin());

DROP POLICY IF EXISTS "Users can insert own profile or admins insert all" ON public.profiles;
CREATE POLICY "Users can insert own profile or admins insert all"
  ON public.profiles FOR INSERT
  WITH CHECK (auth.uid() = id OR public.is_admin());

-- 13. RLS POLICIES FOR PROGRAMS
DROP POLICY IF EXISTS "Anyone can view active programs or admin view all" ON public.programs;
CREATE POLICY "Anyone can view active programs or admin view all"
  ON public.programs FOR SELECT
  USING (is_active = true OR public.is_admin());

DROP POLICY IF EXISTS "Admins can insert programs" ON public.programs;
CREATE POLICY "Admins can insert programs"
  ON public.programs FOR INSERT
  WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Admins can update programs" ON public.programs;
CREATE POLICY "Admins can update programs"
  ON public.programs FOR UPDATE
  USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete programs" ON public.programs;
CREATE POLICY "Admins can delete programs"
  ON public.programs FOR DELETE
  USING (public.is_admin());

-- 14. RLS POLICIES FOR ESKULTURA UNITS
DROP POLICY IF EXISTS "Anyone can view active units or admin view all" ON public.eskultura_units;
CREATE POLICY "Anyone can view active units or admin view all"
  ON public.eskultura_units FOR SELECT
  USING (is_active = true OR public.is_admin());

DROP POLICY IF EXISTS "Admins can insert units" ON public.eskultura_units;
CREATE POLICY "Admins can insert units"
  ON public.eskultura_units FOR INSERT
  WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Admins can update units" ON public.eskultura_units;
CREATE POLICY "Admins can update units"
  ON public.eskultura_units FOR UPDATE
  USING (public.is_admin());

DROP POLICY IF EXISTS "Admins can delete units" ON public.eskultura_units;
CREATE POLICY "Admins can delete units"
  ON public.eskultura_units FOR DELETE
  USING (public.is_admin());

-- 15. RLS POLICIES FOR STUDENT PROFILES
DROP POLICY IF EXISTS "Students can view own profile or admin view all" ON public.student_profiles;
CREATE POLICY "Students can view own profile or admin view all"
  ON public.student_profiles FOR SELECT
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "Students can insert own profile or admin insert" ON public.student_profiles;
CREATE POLICY "Students can insert own profile or admin insert"
  ON public.student_profiles FOR INSERT
  WITH CHECK (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "Students can update own profile or admin update all" ON public.student_profiles;
CREATE POLICY "Students can update own profile or admin update all"
  ON public.student_profiles FOR UPDATE
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "Admins can delete student profiles" ON public.student_profiles;
CREATE POLICY "Admins can delete student profiles"
  ON public.student_profiles FOR DELETE
  USING (public.is_admin());

-- 16. STORAGE BUCKETS CONFIGURATION (Run in Supabase SQL editor)
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('student-photos', 'student-photos', true),
  ('student-signatures', 'student-signatures', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Storage RLS Policies for student-photos
DROP POLICY IF EXISTS "Allow authenticated users to upload their own photo" ON storage.objects;
CREATE POLICY "Allow authenticated users to upload their own photo"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'student-photos' AND (storage.foldername(name))[1] = auth.uid()::text OR public.is_admin());

DROP POLICY IF EXISTS "Allow authenticated users to update their own photo" ON storage.objects;
CREATE POLICY "Allow authenticated users to update their own photo"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'student-photos' AND (storage.foldername(name))[1] = auth.uid()::text OR public.is_admin());

DROP POLICY IF EXISTS "Allow reading photos" ON storage.objects;
CREATE POLICY "Allow reading photos"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'student-photos');

-- Storage RLS Policies for student-signatures
DROP POLICY IF EXISTS "Allow authenticated users to upload their own signature" ON storage.objects;
CREATE POLICY "Allow authenticated users to upload their own signature"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'student-signatures' AND (storage.foldername(name))[1] = auth.uid()::text OR public.is_admin());

DROP POLICY IF EXISTS "Allow authenticated users to update their own signature" ON storage.objects;
CREATE POLICY "Allow authenticated users to update their own signature"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (bucket_id = 'student-signatures' AND (storage.foldername(name))[1] = auth.uid()::text OR public.is_admin());

DROP POLICY IF EXISTS "Allow reading signatures" ON storage.objects;
CREATE POLICY "Allow reading signatures"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'student-signatures');

-- 17. INITIAL SEED DATA
INSERT INTO public.programs (name, is_active)
VALUES
  ('BS Information Technology', true),
  ('BS Computer Science', true),
  ('BS Information Systems', true),
  ('BS Entertainment and Multimedia Computing', true),
  ('BS Electronics Engineering', true),
  ('Bachelor of Fine Arts', true),
  ('BA Communication', true)
ON CONFLICT (name) DO NOTHING;

INSERT INTO public.eskultura_units (name, is_active)
VALUES
  ('HIMIG ESKULTURA', true),
  ('TEATRO ESKULTURA', true),
  ('RITMO ESKULTURA', true),
  ('LIKHA ESKULTURA', true),
  ('KATHA ESKULTURA', true)
ON CONFLICT (name) DO NOTHING;

-- ====================================================================
-- HELPER: PROMOTE A USER TO ADMIN (Run in Supabase SQL editor)
-- ====================================================================
-- UPDATE public.profiles
-- SET role = 'admin'
-- WHERE LOWER(email) IN ('whitesilver2005@gmail.com', 'jpempalmado2005@gmail.com');
