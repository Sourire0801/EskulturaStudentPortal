-- ====================================================================
-- ESKULTURA: CREATE OR UPDATE ADMINISTRATOR ACCOUNT
-- Email: whitesilver2005@gmail.com
-- Password: admin12345
-- Role: admin
-- Run this script directly in your Supabase Dashboard > SQL Editor
-- ====================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DO $$
DECLARE
  v_user_id UUID;
  v_email TEXT := 'whitesilver2005@gmail.com';
  v_password TEXT := 'admin12345';
  v_encrypted_pw TEXT;
BEGIN
  -- 1. Generate encrypted password with bcrypt
  v_encrypted_pw := crypt(v_password, gen_salt('bf'));

  -- 2. Check if user already exists in auth.users
  SELECT id INTO v_user_id FROM auth.users WHERE LOWER(email) = LOWER(v_email);

  IF v_user_id IS NULL THEN
    v_user_id := gen_random_uuid();

    -- Create user in auth.users
    INSERT INTO auth.users (
      instance_id,
      id,
      aud,
      role,
      email,
      encrypted_password,
      email_confirmed_at,
      raw_app_meta_data,
      raw_user_meta_data,
      created_at,
      updated_at,
      confirmation_token,
      email_change,
      email_change_token_new,
      recovery_token
    ) VALUES (
      '00000000-0000-0000-0000-000000000000',
      v_user_id,
      'authenticated',
      'authenticated',
      v_email,
      v_encrypted_pw,
      NOW(),
      '{"provider": "email", "providers": ["email"]}'::jsonb,
      '{"role": "admin"}'::jsonb,
      NOW(),
      NOW(),
      '',
      '',
      '',
      ''
    );

    -- Create identity record
    IF NOT EXISTS (SELECT 1 FROM auth.identities WHERE user_id = v_user_id AND provider = 'email') THEN
      INSERT INTO auth.identities (
        id,
        user_id,
        identity_data,
        provider,
        provider_id,
        last_sign_in_at,
        created_at,
        updated_at
      ) VALUES (
        gen_random_uuid(),
        v_user_id,
        jsonb_build_object('sub', v_user_id::text, 'email', v_email),
        'email',
        v_email,
        NOW(),
        NOW(),
        NOW()
      );
    END IF;

  ELSE
    -- If user already exists, update password and mark confirmed
    UPDATE auth.users
    SET encrypted_password = v_encrypted_pw,
        email_confirmed_at = COALESCE(email_confirmed_at, NOW()),
        raw_user_meta_data = COALESCE(raw_user_meta_data, '{}'::jsonb) || '{"role": "admin"}'::jsonb,
        updated_at = NOW()
    WHERE id = v_user_id;
  END IF;

  -- 3. Create or update profile in public.profiles as admin
  INSERT INTO public.profiles (id, email, role, updated_at)
  VALUES (v_user_id, v_email, 'admin', NOW())
  ON CONFLICT (id) DO UPDATE
  SET role = 'admin',
      email = EXCLUDED.email,
      updated_at = NOW();

END $$;
