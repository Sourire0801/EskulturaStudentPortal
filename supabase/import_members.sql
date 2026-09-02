-- ====================================================================
-- AUTOMATED BULK IMPORT OF 89 ESKULTURA MEMBERS FROM EXCEL
-- ====================================================================

-- Step 1: Ensure student_profiles allows imported members without requiring pre-registered auth accounts
ALTER TABLE public.student_profiles ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE public.student_profiles ADD COLUMN IF NOT EXISTS email TEXT;

-- Step 2: Insert distinct ESKULTURA Units
INSERT INTO public.eskultura_units (name, is_active) VALUES ('HIMIG ESKULTURA', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.eskultura_units (name, is_active) VALUES ('TEATRO ESKULTURA', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.eskultura_units (name, is_active) VALUES ('RITMO ESKULTURA', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.eskultura_units (name, is_active) VALUES ('LIKHA ESKULTURA', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.eskultura_units (name, is_active) VALUES ('KATHA ESKULTURA', true) ON CONFLICT (name) DO NOTHING;

-- Step 3: Insert distinct Programs
INSERT INTO public.programs (name, is_active) VALUES ('BSED SocStud 3 C', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BS PSYCHOLOGY', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Secondary Education Major in Social Studies', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bsed Filipino', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED- Social Studies', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('CBAA BSBS FM - 2A', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BACHELOR OF SCIENCE IN INFORMATION AND TECHNOLOGY MAJOR IN WEB AND MOBILE APPLICATION DEVELOPMENT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BACHELOR OF SCIENCE IN HOSPITALITY MANAGEMENT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA FINANCIAL MANAGEMENT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA MAJOR IN MARKETING', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSAMG', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Tourism management', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BPED', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSHM', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED-FILIPINO', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSIT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSFisheries', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of science in fisheries', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of technology and livelihood education', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSFT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSC', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSTM', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA - FM', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED MATH', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BACHELOR OF SCIENCE IN TOURISM MANAGEMENT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BTLED', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Science in Nutrition and Dietetics', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('College of Teacher Education', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSEd English', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('COLLEGE OF TEACHER EDUCATION', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Physical Education', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSHM 1-A', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSCS', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BS in Tourism Management', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Secondary education major in English (BSED)', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSND', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA MM', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('CTE-BPED', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Science in Psychology', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bs Psychology', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED ENGLISH 3B', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BS Psychology', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('CTE', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Science in Computer Science', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA MARKETING MANAGEMENT', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Tourism Management', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BPED - Bachelor of Physical Education', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSF', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED - Filipino', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED Social Studies', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSEd', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA-FM', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED-FIL', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BTVTED', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Science in Accountancy', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BS Nutrition and Dietetics', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED Science', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED MAJOR IN FILIPINO', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSED Major in Social Studies', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Secondary Education major in Science', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('CCJE', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Secondary Education major in English', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSed English', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('CTE BPED ll - A', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('Bachelor of Science in Information Technology', true) ON CONFLICT (name) DO NOTHING;
INSERT INTO public.programs (name, is_active) VALUES ('BSBA - 1B - M.M.', true) ON CONFLICT (name) DO NOTHING;

-- Step 4: Insert Members into student_profiles


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED SocStud 3 C' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'maryramilledeang@gmail.com',
    'Ilagan',
    'Mary Ramille',
    'D',
    '0423-4651',
    v_prog_id,
    'Third Year',
    'Female',
    '2004-06-10',
    'Kanluran St, Bayog, Los Baños, Laguna',
    '09300797566',
    'https://www.facebook.com/share/1ErtPCdQds/',
    'Glee Club member (2017-2019)
Radio Drama 2nd Place - English Week (2017)
LTCATO Christmas Chorale Competition - Second Place (2024)
Biñan National Chorale Festival - (2025)
Intercampus under the Choral competition - Second Place (2025)',
    v_unit_id,
    'https://drive.google.com/open?id=1IuMp__EQger003QNpe_MfKxOJczI_XqG',
    'https://drive.google.com/open?id=1U2YIuiSJbUBaN9TcI79lnWwECD2zvapu',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS PSYCHOLOGY' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jahnaquilaquil@gmail.com',
    'QUILAQUIL',
    'JAHNA ALEIA',
    'P',
    '0425-0208',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-05-26',
    'BRGY. MALINTA, LOS BAÑOS, LAGUNA 4030',
    '09942584604',
    'Jahna Aleia Quilaquil',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1iaf534Ls3CbAB8u1JLhfc0pllRaEId35',
    'https://drive.google.com/open?id=1bZIVx8B4qLfVz-sYPOheNQ6hLs2yXLbL',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Secondary Education Major in Social Studies' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'dwightjersonsayong@gmail.com',
    'SAYONG',
    'Dwight Jerson',
    '',
    '0423-4040',
    v_prog_id,
    'Fourth Year',
    'Male',
    '1999-11-07',
    '584 Sanggumay St. Brgy Looc Calamba City, Laguna',
    '09503776337',
    'https://www.facebook.com/dwight.jerson.sayong.esguerra',
    'Leadership and Service award',
    v_unit_id,
    'https://drive.google.com/open?id=1mQCzd1S7mWhHRyDm8E3APZjoqze-jpbm',
    'https://drive.google.com/open?id=1iVqfx6Qv5wCJNl5_kXW6RoVOo_s7r2zD',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bsed Filipino' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'eabatayda@gmail.com',
    'Aira',
    'Batayda Elaiza',
    '',
    '0423-4171',
    v_prog_id,
    'Fourth Year',
    'Female',
    '1999-06-14',
    'Brgy Dila Bay laguna',
    '09484498519',
    'https://www.facebook.com/share/14ovoRBXRDg/?mibextid=wwXIfr',
    '3rd place short and sweet play
2nd place short and sweet play',
    v_unit_id,
    'https://drive.google.com/open?id=1jL7OboJKXzsa5Cpfbc4sTExDBEQJ-EaF',
    'https://drive.google.com/open?id=1vrxSIA6AX9PmrFS5XDdCOW50V71A36pg',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED- Social Studies' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'renaaragon11@gmail.com',
    'ARAGON',
    'Renalyn',
    'L',
    '0423-4430',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2004-11-10',
    'Purok 3 Salangbato Dila Bay, Laguna',
    '09123993821',
    'https://www.facebook.com/share/19UqDrGFNf/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1x3FBuNJLtIrs6vbQGOFygmFI3VZLtaLg',
    'https://drive.google.com/open?id=1ABxJiHxp1OMUEy9VprDw3Lp6odC8NG4B',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED- Social Studies' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'renaaragon11@gmail.com',
    'ARAGON',
    'Renalyn',
    'L',
    '0423-4430',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2004-11-10',
    'Purok 3 Salangbato Dila Bay, Laguna',
    '09123993821',
    'https://www.facebook.com/share/19UqDrGFNf/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1rosI2ievY57rqfkoBstRFPfyJYa23kuq',
    'https://drive.google.com/open?id=1gF2NX6Gw7z_jQvCm8_6vOwl2r2eXdumB',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'CBAA BSBS FM - 2A' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'borjakyleadrian12@gmail.com',
    'Borja',
    'Kyle Adrian',
    '',
    '0425-0122',
    v_prog_id,
    'Second Year',
    'Male',
    '2008-01-01',
    '064 Purok 2 Bucal Calmba City Laguna',
    '09277316115',
    'Kyle Borj',
    'N',
    v_unit_id,
    'https://drive.google.com/open?id=1Ki68h5c1SyGW9XNdQtOhPNWuyeJof3_G',
    'https://drive.google.com/open?id=1iBtOj12Yz3tz_-L6SkF0nEwwHGyWpOei',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BACHELOR OF SCIENCE IN INFORMATION AND TECHNOLOGY MAJOR IN WEB AND MOBILE APPLICATION DEVELOPMENT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jpempalmado2005@gmail.com',
    'EMPALMADO',
    'JOHN PAUL',
    'C',
    '0423-4197',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2005-07-31',
    'Blk 16 Lot 13 Bay Garden Homes, Santo Domingo, Bay, Laguna',
    '0945 995 3360',
    'https://www.facebook.com/share/1FA1661t7h/',
    '3rd Place Campus - Wide Pop Solo 2024-2025
Bronze Diploma - Biñan National Chorale Festival ( HIMIG ESKULTURA )
2nd Place LTCATO Christmas Chorale Competition ( HIMIG ESKULTURA )',
    v_unit_id,
    'https://drive.google.com/open?id=1oAhCUHGhaLuv_ZuVRyLJuoTaHu36zdm8',
    'https://drive.google.com/open?id=1ktU_fU8KHjv4duQCQJgaEBzAf5gs-2Yd',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BACHELOR OF SCIENCE IN HOSPITALITY MANAGEMENT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'horigueivan18@gmail.com',
    'Horigue',
    'Justine Ivan',
    'E',
    '0424-0515',
    v_prog_id,
    'Third Year',
    'Male',
    '2005-10-17',
    '4056, tagpuan St. Bayog, Los Baños, Laguna',
    '09625433036',
    'https://www.facebook.com/share/1CTWb83i5T/',
    '1st Year: Contemporary Dance Competition in Rizal State University 4th Runner Up
2nd Year: Contemporary Dance Competition in Romblon State University 4th Runner Up',
    v_unit_id,
    'https://drive.google.com/open?id=1IvrBsxpB8KKFbZJnH2iKqC6OxTEiUJMk',
    'https://drive.google.com/open?id=17QDX6CLE9H42E5wbjd6dQN0gQTKQG-GT',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA FINANCIAL MANAGEMENT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'carljohnmacasinag@gmail.com',
    'MACASINAG',
    'CARL JOHN',
    'G',
    '0424-1114',
    v_prog_id,
    'Third Year',
    'Male',
    '2005-12-12',
    'Brgy. Batong Malake Sitio Sta. Fe Purok 6 Los Baños Laguna',
    '09914810730',
    'https://www.facebook.com/share/1BpKdC1oHB/',
    '1st Place in Charcoal Rendering Competition',
    v_unit_id,
    'https://drive.google.com/open?id=1lX-dGLqlDMgNa58Vio-oqgqHyWd04O4R',
    'https://drive.google.com/open?id=18uqQikHUXzq90kb-gcq_-BiPqv5jWMq9',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA MAJOR IN MARKETING' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'tkathleenbelle@gmail.com',
    'TUSI',
    'KATHLEEN BELLE',
    'Y',
    '0424-0132',
    v_prog_id,
    'Third Year',
    'Female',
    '2005-11-07',
    'PUROK 3, MALINTA LOS BAÑOS LAGUNA',
    '09553661572',
    'https://www.facebook.com/belle.tusi',
    'RITMO - Most Punctual, Most Consistent Member, Leadership Award, Potential Junior Coach Award, Most Improved, Complete Attendance, and Most Disciplined Member.',
    v_unit_id,
    '',
    '',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSAMG' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'teemomercado@gmail.com',
    'Mercado',
    'Espiritu IV Canda',
    '',
    '0423-3558',
    v_prog_id,
    'Third Year',
    'Male',
    '2005-02-21',
    'BGH, Sto.Domingo, Bay, Laguna',
    '09944971190',
    'https://www.facebook.com/espiritumercado.mercado',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1dGAyQpW3XoT_AGuNNzCybaZvL8u4W4LY',
    'https://drive.google.com/open?id=15TZXyEKrBYUIlgg5erHsmlU3Grszb3Nz',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Tourism management' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'gabrielnoelfmagtangob@gmail.com',
    'Magtangob',
    'Gabriel noel',
    'F',
    '0425-0285',
    v_prog_id,
    'Second Year',
    'Prefer not to say',
    '2007-02-24',
    '12969, sitio SAMPAGUITA, mayondon, Los baños, laguna',
    '09675614155',
    'https://www.facebook.com/gabriel.fajarito.magtangob.2025?mibextid=ZbWKwL',
    'Anilag champion 2026',
    v_unit_id,
    '',
    '',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BPED' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'gioandreiroxas@gmail.com',
    'RUAYA',
    'ROXAS GIO ANDREI',
    '',
    '0426-0717',
    v_prog_id,
    'First Year',
    'Male',
    '2007-11-25',
    'Purok4 Pansol Calamba Laguna',
    '09976411580',
    'https://www.facebook.com/share/1PTCDHL3S3/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1ibS-hIWOp7HkcUC-Fkbfg81qu7ptNbB2',
    'https://drive.google.com/open?id=1lv5j8iLsITHkLSYYFc5re-z4W4TJ4Vam',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'elsantiago2208@gmail.com',
    'Rizaga',
    'Santiago El-unardo',
    '',
    '0424-0097',
    v_prog_id,
    'Third Year',
    'Male',
    '2005-01-01',
    'Purok 6 Pansol Calamba City',
    '09482741390',
    'https://www.facebook.com/share/18pZUYymxb/?mibextid=wwXIfr',
    '4th place in STRASUC CUP 2024 and 2025- Contemporary category',
    v_unit_id,
    'https://drive.google.com/open?id=1fgy27ldfUF-KriPUN2HCzAuMwBj2uXTJ',
    'https://drive.google.com/open?id=1eRovCnCdxkhoGKe0UF5fThjp-qnTinEJ',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED-FILIPINO' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'adordionisioryza@gmail.com',
    'MARIANO',
    'Ryza Mae',
    'A',
    '0424-0396',
    v_prog_id,
    'Third Year',
    'Female',
    '2005-03-12',
    '11535, Apolinario Street Mayondon, Los Baños Laguna',
    '09773060499',
    'https://www.facebook.com/share/1C4zLnbHrh/',
    'Academic Achiever (SHS)',
    v_unit_id,
    'https://drive.google.com/open?id=1SgPRC_Xvfd5REtAcQCysO0PZWoaswrkV',
    'https://drive.google.com/open?id=15yJWMUcxz1V8ixEaTjqfqIbupYOF4ojW',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSIT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'justinetayam8@gmail.com',
    'Tayam',
    'Vivas Allan Justine',
    '',
    '0426-0075',
    v_prog_id,
    'First Year',
    'Male',
    '2007-09-09',
    '400 Timugan, Los baños, laguna',
    '09750223504',
    'https://www.facebook.com/share/1LG6yPudY2/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1yb3-kZIVGcf_c_KMMDgrZCjfm0fvUDCP',
    '',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSFisheries' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'malabananjohnpatrick64@gmail.com',
    'E.',
    'Malabanan Patrick',
    '',
    '0425-0223',
    v_prog_id,
    'Second Year',
    'Male',
    '2006-05-22',
    'Tuntungin Putho Purok 3 2286 nayon Los Baños Laguna',
    '09485981043',
    'https://www.facebook.com/share/19SoWdmBr1/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1-Eao7SEk5YgPpqwguyanwFY3Rxb4tJ-p',
    'https://drive.google.com/open?id=1NmwFBdLo8MoJW3CQnqbfeMmTOHkIcBYq',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of science in fisheries' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jeuskent2000@gmail.com',
    'Aquino',
    'Jeus Kent',
    'M',
    '0425-0371',
    v_prog_id,
    'Second Year',
    'Male',
    '2007-08-04',
    'Brgy Calo, Bay, Laguna',
    '09935079333',
    'https://www.facebook.com/share/19NUBYjDY6/',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1fZWNRLXa96zna8FZARq22_lM8Jf57iZS',
    'https://drive.google.com/open?id=10l5lOQ5CqQHj9QgkhAnYfWiaAj6RAf4i',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of technology and livelihood education' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'daniellajhanev@gmail.com',
    'Valentino',
    'Daniella Jhane Mendoza.',
    '',
    '0425-0846',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-10-08',
    '0253, Silangan Street Bayog Los Baños Laguna',
    '09631980126',
    'https://www.facebook.com/djmvhshdjdkdnfnd',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1-DIvI7BpaVM-cjTtYYSR58DDArwDsLM5',
    'https://drive.google.com/open?id=1FErNA7ccRaRrSXMtcpaAqGOYXHmDVRAB',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSFT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'johnpatrickmila427@gmail.com',
    'Mila',
    'JohnPatrick',
    'A',
    '0426-0738',
    v_prog_id,
    'First Year',
    'Male',
    '2007-01-01',
    'Sitio Pag-asa San Antonio Los baños laguna',
    '09562510326',
    'PatrickMila',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1LOdNM78FDNH3JcTGbUBkv8tcZ3E1cUNj',
    'https://drive.google.com/open?id=1ZN5z3BHJhyJlGqzS14Ibd3JAiLqVIlK7',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSC' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'charlobonapos13@gmail.com',
    'BONAPOS',
    'CHARLO',
    'M',
    '0425-0231',
    v_prog_id,
    'Second Year',
    'Male',
    '2005-07-12',
    'Barangay bambang purok 5 los baños laguna',
    '09939349811',
    'Charlo Manzanares Bonapos',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1GfgSWq11W1x-LgMKtkltINWkR_YOMb3M',
    'https://drive.google.com/open?id=1gr6Cg5bJPzfD8vg_p8DXyrKOJaR_DbsJ',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSTM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'roselalliyahcamille1018@gmail.com',
    'ROSEL',
    'ALLIYAH CAMILLE',
    'P',
    '0426-0488',
    v_prog_id,
    'First Year',
    'Female',
    '2008-08-29',
    '9013, Purok 5, Bambang, Los Baños, Laguna',
    '09651974823',
    'https://www.facebook.com/share/1Ba73mYEMa/?mibextid=wwXIfr',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1Bng_mQ_pDPziSqQjQUbAJISlH-gn_E33',
    'https://drive.google.com/open?id=1Kk_pmALG3rh4Amx5RmviBRJrF98ImPHM',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA - FM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'pauleenlajarca19@gmail.com',
    'Lajarca',
    'Pauleen Angela',
    'M',
    '0426-0319',
    v_prog_id,
    'First Year',
    'Female',
    '2008-01-18',
    '12477 J.Aquino St. Brgy Mayondon',
    '09626792392',
    'https://www.facebook.com/share/18zvAVpw55/?mibextid=wwXIfr',
    '• Best in Poster Design — 2021–2022
• Mathematics Achiever — 90 Average',
    v_unit_id,
    'https://drive.google.com/open?id=1t4NknuZj4czj1LuW8nKUXqGQe9Bkhl8N',
    'https://drive.google.com/open?id=1I3pVkdwXDhDpzn5vc3kWBpg91QsL1559',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED MATH' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'michaeldavesg@gmail.com',
    'Garcia',
    'Michael Dave',
    'S',
    '0424-0218',
    v_prog_id,
    'Third Year',
    'Male',
    '2005-12-22',
    '10854 Simon St. Mayondon Los Baños Laguna',
    '09241250085',
    'https://www.facebook.com/share/19Ko8wAJNs/?mibextid=wwXIfr',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=19Ti6XjvOP9p8-QvtVw-cYKvv6VEkKCtf',
    'https://drive.google.com/open?id=14IGiVP557rdBVCo2rdz1WuNThysWZiqu',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BACHELOR OF SCIENCE IN TOURISM MANAGEMENT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'inoakio60@gmail.com',
    'ALARCIO',
    'CHRISTIAN LHARZ',
    'C',
    '0426-0278',
    v_prog_id,
    'First Year',
    'Male',
    '2008-06-22',
    'Brgy. Mayondon, Los Baños, Laguna',
    '09455726405',
    'https://www.facebook.com/share/1MHvQiBCiV/',
    'Junior High
‎- Poem making/ Oratorical speech Champion
‎-Best Male Actor
‎-Best Director of the year
‎- Vice President of Yes-o (23-24) 
‎- Grade 7 to 10 WITH HONORS
‎- Vice President of Filipino Club
‎
‎𝗚𝗥𝗔𝗗𝗘 𝟭𝟭
‎– Synchronyx elected President (S.Y. 2024 – 2025) 
‎- Oratorical Speech Champion
‎- Mr. Los Baños Señior High School Career Guidance 2025
‎
‎𝗚𝗥𝗔𝗗𝗘 𝟭𝟮
‎– Synchronyx Vice President (S.Y. 2025 – 2026) 
‎– Bañamos Cultural Show (Performance)
‎– PHSA CONTEMPORARY PERFORMANCE Banamos cultural show (2024) 
‎- Contemporary performance Banamos Cultural show (2025) 
‎- GRADE 11 AND 12 WITH HONORS
‎ 
‎Outside the School
‎-Member of 2026 LB Anilag Batch Champion Sayawit Anilag Festival
‎- Semi Finalists of PSDFI (Philippine Dancesport Federation) in Manila
‎- Member of 2025 Banamos champion from Brgy. Mayondon
‎- Member of I.S.D.T ( Indak Sining Dance Troupe) One Malinta Indakan sa Lansangan Champion 2026
‎- Member of GKDC (Gilas at Kilos dance company) 3d runner up from DALAKTIK FESTIVAL (2024 to 2025) 
‎- Member of Arts Zone Dance Studio (Dancesport) 
‎- IloIlo Governors Cup performer of Anyo Arnis
‎- Member of Los Baños Arnis Team
‎- Silver medalist of Laguna''s Governors Cup 2023',
    v_unit_id,
    'https://drive.google.com/open?id=1GzsytDT6J5y3TRS-FIfShbi8KPM8jJSl',
    'https://drive.google.com/open?id=1_0cx_cq6PIoGYlv_IDSwzZ0LzrrJ1ipa',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA - FM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'pauleenlajarca19@gmail.com',
    'Lajarca',
    'Pauleen Angela',
    'M',
    '0426-0319',
    v_prog_id,
    'First Year',
    'Female',
    '2008-01-18',
    '12477 J. Aquino St. Brgy Mayondon',
    '09626792392',
    'https://www.facebook.com/share/18zvAVpw55/?mibextid=wwXIfr',
    '• Best in Poster Design — 2021–2022
• Mathematics Achiever — 90 Average',
    v_unit_id,
    'https://drive.google.com/open?id=1OmhkBdTf8xPP9EZ3qzO4uG6k_8QeGfzP',
    'https://drive.google.com/open?id=1p4zfWDxK4CqHk42Er0TdeYnf5yNRqqLp',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BTLED' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'gbeverlyn7@gmail.com',
    'C.',
    'Garcia Beverlyn',
    '',
    '04250178',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-06-24',
    'Brgy. Bayog dulong silangan los baños laguna',
    '0924 519 0525',
    'https://www.facebook.com/garciabeverlyn.25?mibextid=ZbWKwL',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1p5k3ZZP-GHd52GS81K6NODpxTY1je7Fv',
    'https://drive.google.com/open?id=12SVuc377YY8wpWnx_hRL973k048mUuoc',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Science in Nutrition and Dietetics' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jennaliciareyes@gmail.com',
    'Reyes',
    'Jennalicia Shaina',
    '',
    '0424-0789',
    v_prog_id,
    'Second Year',
    'Female',
    '2005-09-20',
    '330, Purok 5, Brgy.VI-E, San Pablo City, Laguna',
    '09561450362',
    'https://www.facebook.com/share/19L1LeJ7mj/?mibextid=wwXIfr',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1ehKwha42DTOpGWNMHfGjpXfc_O4Lc9l6',
    'https://drive.google.com/open?id=1Ns_-6YDWWF_9hi3WVEEQOcHAcjWtFqMi',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSIT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jhianpaule20@gmail.com',
    'Paule',
    'Jhian Ricail',
    'T',
    '0426-0136',
    v_prog_id,
    'First Year',
    'Male',
    '2007-11-12',
    'BLK 34 Lot 4 Phase 1, Villa de Calamba, BRGY. Lamesa Calamba City, Laguna',
    '09069248201',
    'https://www.facebook.com/share/1C4Znzroce/?mibextid=wwXIfr',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1RhcqaNGJODhZlpEE_CSiKvcsMQnPSied',
    'https://drive.google.com/open?id=1oNECLAHHUxM0IIhvLdU8d4mJcfEALh4b',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'College of Teacher Education' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jhuztinekyleh@gmail.com',
    'Hugo',
    'Jhuztine Kyle',
    'G',
    '0425-0789',
    v_prog_id,
    'Second Year',
    'Male',
    '2007-05-18',
    'Villa de Calamba Calamba Laguna Blk 88 Lot 10 Phs 4',
    '09566537186',
    'https://www.facebook.com/share/1D3FT9ehVd/',
    'STRASUC Contemporary 4th place, 2 Extension certificate of appreciations, paskuhan concert certificate award, International Youth Day Certificate, Sunset at the Park Opening, 1st Year representative 
(1st year) , MR.& MS Valentine''s day 1st runner up, Head leader of the parol making contest (Champion) , choreographer of Indak Ka piyu (3rd Runner up) , palarong Lahi (champion)',
    v_unit_id,
    'https://drive.google.com/open?id=1tp3C5Oh7K3SsDyiyhfmJVtHmiG7-EMPp',
    'https://drive.google.com/open?id=1H_EM1VJSd5plG-qE7t9opuPox7YEBQe7',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSEd English' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'orfanocollen22@gmail.com',
    'ORFANO',
    'COLLEN',
    'C',
    '0424-0214',
    v_prog_id,
    'Third Year',
    'Female',
    '2005-11-21',
    'J. Aquino Street, Mayondon, Los Baños, Laguna',
    '09663748779',
    'N/A',
    'N/A',
    v_unit_id,
    'https://drive.google.com/open?id=11eV5dLHg6Ka4KwQJmGWuwEXwgYr-2_Et',
    'https://drive.google.com/open?id=1x1hj_EJ2k0JTOAkNMZ0uKRN3BTx1vJt9',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'COLLEGE OF TEACHER EDUCATION' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'michellelabarnes549@gmail.com',
    'GAMAO',
    'LABARNES MICHELLE',
    '',
    '0425-0644',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-12-11',
    'Purok 3 Brgy Mayondon Los Baños laguna',
    '09126132832',
    'https://www.facebook.com/share/1F3fP23z4u/?mibextid=wwXIfr',
    'Poster making champion,nail art champion',
    v_unit_id,
    'https://drive.google.com/open?id=1evWvU3mYLqYDZ1vbPO1U8CIYulneKGKP',
    'https://drive.google.com/open?id=1PQvvQDOzyUL_zphYiKjk2ZAei5Ynkj9K',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Physical Education' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'miguelmortera484@gmail.com',
    'Mortera',
    'Miguel',
    'N',
    '0426-0499',
    v_prog_id,
    'First Year',
    'Male',
    '2008-09-11',
    '742, Purok 2, Ilang-Ilang Street, Barangay Bambang, Los Baños, Laguna',
    '09679846760',
    'https://www.facebook.com/share/1L4Y1H4eC6/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1Mu_CgYGDET5-BcvhH-irrqH4CHtoZsTu',
    'https://drive.google.com/open?id=1dO2XmubIBEENS4yFIKdesIOkZuZTkbYe',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM 1-A' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'aicacollado2@gmail.com',
    'Collado',
    'Aica',
    'S',
    '0426-0250',
    v_prog_id,
    'First Year',
    'Female',
    '2008-10-27',
    'Brgy. Tagumpay Bay, Laguna',
    '09460693150',
    'Aica collado',
    '2nd place in poster making 2023
3rd place at CMDI cup mural painting
3rd place in poster making 2024
Members of Special program in the arts major in visual arts.
Members at Trace Arts guild. 
3rd place at mural painting in nutrition month 
3rd place at buwan ng wika poster making',
    v_unit_id,
    'https://drive.google.com/open?id=1J8OGnamSp2rqPmJFxAp4XLAE6hii9oi4',
    'https://drive.google.com/open?id=1s1msizbyQj9rbEUDJaXrEkwtGYvCBczL',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSCS' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'magatmichael52@gmail.com',
    'ASEMBRADO',
    'MAGAT MICHAEL REINER',
    '',
    '0422-0722',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2002-09-08',
    '748 Purok 3B , BRGY MALINTA, LOS BAÑOS, LAGUNA',
    '09356238870',
    'https://www.facebook.com/share/19BWoPo8Ff/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1II1zig-YwZiuXennZeWKYhcwaElslDr8',
    'https://drive.google.com/open?id=1tgvCo5AAoBvSzDbIu5unffMBjZ0g-CeL',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS in Tourism Management' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jeanellenathalyvelasco@gmail.com',
    'Velasco',
    'Jeanelle Nathaly',
    'C',
    '0426-0253',
    v_prog_id,
    'First Year',
    'Female',
    '2008-09-30',
    '#10060 Mt.Data St. Umali Subd. Batong Malake, Los Baños, Laguna',
    '09927066492',
    'https://www.facebook.com/share/1FB5wDbbZn/',
    'Bañamos TikTok shower parade 2023 champion',
    v_unit_id,
    'https://drive.google.com/open?id=1gM0hThgpQCOdYyvhVsVISSeXx6CLVDMZ',
    'https://drive.google.com/open?id=1SLEPo3bw9K1gFRTdgSsJ0hhUj0X7aFHg',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'sernadillaprincess597@gmail.com',
    'Sernadilla',
    'Princess',
    'F',
    '0425-0574',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-02-20',
    'Sitio Maligaya Purok 4 Brgy San Antonio Los baños Laguna',
    '9535781917',
    'https://www.facebook.com/share/1EGSdroADZ/',
    'Collage 
- 2nd place - U wide interschool competion
- Ensembles/alumni in Hintayan LIKHA Elbi Music and Arts Festival
- part of short and sweet play as lenlen in LIKHA Elbi Music and Arts Festival

G12 
- Academic Achiever ✨
- Special Award for Service (Oustanding Performance in music) 🏅
- 1st Place in Festival Dance - ABM 1 Reverence
- 1st Place in Women''s Basketball (Sport fest) - ABM Strand 
- Part of ensemble in Bayang liwanag isang Musical
- Likhayag Choir Member since G11 and G12

G11
- With honors ✨
- Champion in Bigsayawit - ABM 1 Reverence 🏆
- One of participants in Sabayang pagbigkas outside school competition (CMDI) 
- Part of ensemble in i doo bidoo bidoo Musical Play',
    v_unit_id,
    'https://drive.google.com/open?id=116qVBLw-orekOquZWaOch2n4EQVqDSZq',
    'https://drive.google.com/open?id=1q0wkQPdU9J3h2oMcyalxjmF3Jkk-ifGi',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Secondary education major in English (BSED)' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'princeleonida89@gmail.com',
    'Morales',
    'Prince kyle',
    'Leonida',
    '0426-0548',
    v_prog_id,
    'First Year',
    'Prefer not to say',
    '2008-04-01',
    'Malinta, Antique St 130, Los Baños Laguna',
    '09056711966',
    'https://www.facebook.com/profile.php?id=61588919494519',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1bhiwZlfh9dqcDvkPpQ6e6IOY_MLzSF-M',
    'https://drive.google.com/open?id=1aCg5bzBkn8h88rfxOrIjH6I6Nv3nCfjh',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSND' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'dunadelacruz4@gmail.com',
    'L.',
    'Dela Cruz Donna Marie',
    '',
    '211075',
    v_prog_id,
    'First Year',
    'Female',
    '2008-07-07',
    'barangay Bambang purok 2',
    '09924042801',
    'https://www.facebook.com/donna.lacho.96',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1BA-u9E5I0-OYn2yihPTSBCzXaGrze9SC',
    'https://drive.google.com/open?id=1fqjT0VMzSZFhLkKF1UplfPNAnwqGKO84',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA MM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'ariel.castillo@lspu.edu.ph',
    'CASTILLO',
    'ARIEL',
    'B',
    '0424-0171',
    v_prog_id,
    'Third Year',
    'Male',
    '2006-09-20',
    '0910, Sitio Sampaguita, Barangay San Antonio, Los Baños, Laguna',
    '09935653635',
    'https://www.facebook.com/arl.0606',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=106zFiQKOUDQ9Ysmj_g64Nhf_IZqQ_bce',
    'https://drive.google.com/open?id=1iJwbzqEWKUOr8hPuv7SA02Mpo30TTf2T',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'CTE-BPED' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'aleinngs@gmail.com',
    'Santiago',
    'Aleinn Geiyrald',
    'A',
    '0426-0600',
    v_prog_id,
    'First Year',
    'Male',
    '2008-10-04',
    'Maitim, Bay, Laguna',
    '09927292908',
    'https://www.facebook.com/share/1KWC5sjKmz/',
    'DFOT BSK 2024, 2025, 2026 - CHAMP
RFOT BSK 2025 - 6TH PLACE
RFOT BSK 2026 - 4TH PLACE',
    v_unit_id,
    'https://drive.google.com/open?id=18uJpDX8RqQt2YUp66r9pvq5oGbdiFLpu',
    'https://drive.google.com/open?id=1t9x4gK3cJawrmKtImHE4U2nbuWtyxVvz',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Science in Psychology' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'iohannamagnoliajs@gmail.com',
    'SANTOS',
    'IOHANNA MAGNOLIA',
    'J',
    '0426-0064',
    v_prog_id,
    'First Year',
    'Female',
    '2008-03-17',
    '543 Purok 5 Brgy. Bambang, Los Baños, Laguna',
    '09663770618',
    'https://www.facebook.com/share/1F1X64zE4y/',
    'N/A',
    v_unit_id,
    'https://drive.google.com/open?id=1Wyq5bB60T1RWfFpWphXOY2yvgtHagcjZ',
    'https://drive.google.com/open?id=16o_M3q2NNZs1C1WAiqe-pqsgsBY3zC-p',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bs Psychology' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'ramosjez68@gmail.com',
    'Ramos',
    'Jezee Claine',
    '',
    '0426-0350',
    v_prog_id,
    'First Year',
    'Male',
    '2007-12-25',
    'Brgy. Bayog, Los Baños, Laguna',
    '09918657074',
    'https://www.facebook.com/jezeeclainerm',
    'Grade 12 - With Honors, Best in Research Paper
Grade 11- With Honors',
    v_unit_id,
    'https://drive.google.com/open?id=1T2IIsdw9lhRYnuvgxCCz5AqF8KfaOkny',
    'https://drive.google.com/open?id=1OcpUR4bqrNielIqRv5FIFuEO0WWqP9wA',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED ENGLISH 3B' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'limjohnanthony0514@gmail.com',
    'LIM',
    'JOHN ANTHONY',
    'D',
    '0423-4406',
    v_prog_id,
    'Third Year',
    'Prefer not to say',
    '2005-05-13',
    'Sitio Pag-asa, Brgy. San Antonio, Los Baños, Laguna',
    '09630059053',
    'N/A',
    'Biñan National Chorale Festival Qualifier and Finalist
LTCATO 2nd Runner-Up',
    v_unit_id,
    'https://drive.google.com/open?id=1_2zeTcaq0nYMRS-a2X4bYuBrPCyji1y7',
    'https://drive.google.com/open?id=1Q1L6tNK5xdiu16UGzjUDmurEZXMAkef6',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS Psychology' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'corona.mrf@gmail.com',
    'Corona',
    'Marie Racquel Faye',
    'P',
    '0426-0105',
    v_prog_id,
    'First Year',
    'Female',
    '2008-10-03',
    '449 Aquino Street, Timugan, Los Baños, Laguna',
    '09760146842',
    'https://www.facebook.com/share/1CKCwpET8m/?mibextid=wwXIfr',
    'With High Honors',
    v_unit_id,
    'https://drive.google.com/open?id=1eQtTpBDMBw--52dehQQ-irQ-gG0ACRDa',
    'https://drive.google.com/open?id=1zFY9dKvW1Zs_O8tS9z91sQefm7qrgHot',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'CTE' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jelainebien16@gmail.com',
    'Bien',
    'Jelaine',
    'R',
    '0425-0854',
    v_prog_id,
    'Second Year',
    'Female',
    '2004-11-02',
    'Barangay Maitim Bay Laguna',
    '09557545989',
    'https://www.facebook.com/share/14rZdc7JepF/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1xpOSjugmImPjzhgbZc5SRoRw5846TIpV',
    'https://drive.google.com/open?id=1PFw1hV3j5YLQ-nPmndsRzviMuHeYSfTC',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Science in Computer Science' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'pleonahpunzalan.angeles@gmail.com',
    'Angeles',
    'Princess Leonah',
    'P',
    '0426-0189',
    v_prog_id,
    'First Year',
    'Female',
    '2008-05-05',
    'Brgy. Sto. Domingo, Bay, Laguna',
    '09626852406',
    'https://www.facebook.com/rieogel',
    '* With Honor Awardee
* Theatre Club Awardee
* Photojournalism Awardee',
    v_unit_id,
    'https://drive.google.com/open?id=1RIgoWiB-LBPKY6tTLlKemZIZk3sg8Dhd',
    'https://drive.google.com/open?id=1w9v0Lhz0Q2vGvlCyHHPNVILqC8Z5y8VJ',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS PSYCHOLOGY' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'zairinejhoyzavalla@gmail.com',
    'ZAVALLA',
    'ZAIRINE JHOY',
    'A',
    '0426-0333',
    v_prog_id,
    'First Year',
    'Female',
    '2008-01-01',
    'Sitio Silangan, Lecheria, Calamba City, Laguna',
    '09649553623',
    'https://www.facebook.com/zvjzz',
    'G1-G6 - WITH HONORS

JUNIOR HIGH SCHOOL-
-WITH HIGH HONORS
-JOURNALIST OF THE YEAR (CLUSTER MEET 1ST PLACER - BALITANG ISPORTS) -
-ATHLETE OF THE YEAR (CLUSTER & INTER-CLUSTER VOLLEYBALL GIRLS 1ST PLACER, CITY MEET QUALIFIER), 
-BATCH OVERALL RANK #4

SENIOR HIGH SCHOOL
- WITH HIGH HONORS
-HOUSEKEEPING NC II PASSER, 
-DISTINGUISHED OFFICER AWARD
-ARTS AWARDEE 
-PRESIDENT OF HUMSS STRAND  (''25-''26
-SUPREME STUDENT GOVERNMENT - CO-CHAIRWOMAN, 2025-2026
-BEST IN TOUR GUIDE (JOSE RIZAL MUSEUM EXHIBIT WORKSHOP) 

THEATER-RELATED:
-THEATER AUDITION QUALIFIER IN  LCBA PERFORMING ARTS
-THEATER SCRIPTWRITER, DIRECTOR, & MAIN CHARACTER (GRADE 11 - CPAR) 
-CHRISTMAS EVENT PERFORMANCE MUSICAL THEATER MAIN CHARACTER & SCRIPTWRITER

OUTSIDE ACHIEVEMENTS:
BARANGGAY LECHERIA LIVE SPOKEN POKEN POETRY - 1ST PLACE',
    v_unit_id,
    'https://drive.google.com/open?id=1GaW-owpbhcIzTZTOs2iEZffV4AYWTGjM',
    'https://drive.google.com/open?id=1abCNmYsOHpsc_DnRF6sVlW1nKLLZZPxK',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA MM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'raizafaitharquiolatamparong@gmail.com',
    'Arquiola',
    'Tamparong Raizafaith',
    '',
    '4026-0139',
    v_prog_id,
    'First Year',
    'Female',
    '2007-04-27',
    '202 Dapdap St. Bucal Calamba Laguna',
    '09673718912',
    'https://www.facebook.com/share/1GTJ8xwQE3/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1ON13pCkwFejIBRUQ7eBnIwMSaxVezR3Y',
    'https://drive.google.com/open?id=1DdK2bNIBa2qun4hIR50XY4pt13df9gpT',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSFT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'lianroxan2@gmail.com',
    'Butial',
    'Renz',
    'R',
    '0426-0875',
    v_prog_id,
    'First Year',
    'Male',
    '2008-06-25',
    '179 Villegas st. Baybayin Los Baños Laguna',
    '09454731207',
    'https://www.facebook.com/share/18F2nd4P58/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1ZZJzN_COUX5BuHOl98Cl-kM8o7xnbp77',
    'https://drive.google.com/open?id=1aMHjtJFDTaIyI32Si7ebEWBF0IWHNDvN',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSFT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'genombrog.yoha@gmail.com',
    'OMBROG',
    'GEN GWYNETH',
    'F',
    '0426-0755',
    v_prog_id,
    'First Year',
    'Female',
    '2007-12-05',
    'Dangka st., Mayondon, Los Baños, Laguna',
    '09667797377',
    'https://www.facebook.com/share/1BofgdAyXf/',
    'Champion of the Flower and Garden Show: Dish Garden Contest during the 24th Bañamos Festival (2025), Commissioned by the DENR 4-A CALABARZON to create a Mural painting during the Mural Painting Contest (2025), Participated in the Canvas & Cabernet painting event hosted by La Galaria (2025), Participated in a Theatrical Show for a project as the villain (shs, 2025), Participated in the English Broadcasting Team (shs, 2025)',
    v_unit_id,
    'https://drive.google.com/open?id=1DIS4r8MVu3OoCLqZMGwijSTXIw2HeB4X',
    'https://drive.google.com/open?id=1Efve8dwlLDo2wk-Tw5EmpWKO9sd89bxr',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA MARKETING MANAGEMENT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jen.gregsz29@gmail.com',
    'TAGANNA',
    'GREGORIO JENEL',
    '',
    '0426-0623',
    v_prog_id,
    'First Year',
    'Female',
    '2007-06-28',
    '106 MALINTA LOS BAÑOS LAGUNA',
    '09504658467',
    'https://www.facebook.com/share/1JZ4Xz9cRG/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1a-4naHYHzM0z1WhtWNjDbwRbhMt2GEWn',
    'https://drive.google.com/open?id=1rpbwGj6t1Y__ggFny2mf3RoisaZxrWE3',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Tourism Management' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'KATHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'analyndelante08@gmail.com',
    'Delante',
    'Analyn',
    'C',
    '0426-0317',
    v_prog_id,
    'First Year',
    'Female',
    '2008-04-21',
    'P6 BRGY. Milagrosa, Calamba, Laguna',
    '9301735076',
    'https://www.facebook.com/analyn.delante.08',
    'Grade 12 – With High Honor
                 – Rank 3 Overall Grade 12
                 – Performing Arts Award
                 – Service Award
– Unang pwesto sa Paggawa ng Tula 2025
– Unang pwesto Spoken Poetry 2025
– 2nd Dama Female sportfest (2025)
– 1st Sudoku SportsFest (2025)
Grade 11 – With Honors
                 – Rank 4 Overall Grade 11 
                 – Performing Arts Awards
                 – Leadership Award 
                 – Best in Oral Communication
– Best in komunikasyon at Pananaliksik
– Ikalawang Pwesto sa Paggawa ng tula
–2nd Sudoku Science fair (2024)
		Grade 10 – With Honors
		Grade 9 – With Honors
		Grade 8 – Achievers 
		Grade 7 – Achievers',
    v_unit_id,
    'https://drive.google.com/open?id=1MX-qiToNVZAyVoRHVyrEt6KCsKN_pV80',
    'https://drive.google.com/open?id=12hBPvgu6st1sBDnrUc4bsrOU7P4BVfpH',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSIT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'chxsezyd@gmail.com',
    'ROYENA',
    'ZYRILE DAVID PANDINUELA',
    '',
    '0426-0746',
    v_prog_id,
    'First Year',
    'Male',
    '2008-09-29',
    'Purok 5, Brgy. Malinta, Los Baños, Laguna',
    '09770241158',
    'Zyrile David Royena',
    'Art club 2nd place
Municipality of Los Baños national 2nd place
CCAPRISA 2nd placer poster making contest',
    v_unit_id,
    'https://drive.google.com/open?id=1KCgId1gIUHtlGAGWbilqvwHd3s_neraK',
    'https://drive.google.com/open?id=1rqGCFcAYTVLY8hl4vK62O4yZY_5zgSEW',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BPED - Bachelor of Physical Education' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'kyleharveypizon@gmail.com',
    'Pizon',
    'Kyle Harvey',
    'C',
    '0426-0561',
    v_prog_id,
    'First Year',
    'Male',
    '2008-11-08',
    'Daangbakal, Maitim, Bay, Laguna',
    '09750233937',
    'Kyle Harvey Pizon',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1zKMRIWt-Pku_9lRd1qfAW_9mndZVC57q',
    'https://drive.google.com/open?id=1Uq4ZW2Hn39MVjzC6APD373gt_RlFrQbV',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'tandangmyleen@gmail.com',
    'Tandang',
    'Myleen',
    'B',
    '0426-0197',
    v_prog_id,
    'First Year',
    'Female',
    '2008-01-12',
    'Andis Balut, Brgy. Mayondon, Los Baños, Laguna',
    '09620598197',
    'https://www.facebook.com/share/1Snhw4hQae/',
    '🔖 Kinder 
• top 2 in class 

🔖 Elem - Junior High School 
• consistent honor student
• grade 8: first place in essay making contest
• grade 10: first place in slogan making contest

🔖 Grade 11 
• with honors 
• classroom president
• student council: strand representative
• journalism: aspirant member/filipino radio broadcasting 
• intrams: overall team captain 

🔖 Grade 12
• with high honors
• classroom vice president
• subject excellence: best in food and beverage services',
    v_unit_id,
    'https://drive.google.com/open?id=1dVGVd_NfDultEr6D4Fnzj1jQxDTx2TnF',
    'https://drive.google.com/open?id=1Y9wS6nMGdbzSBGWyr9WXLEypmWz8uCVW',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSF' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'cabralanikaaa@gmail.com',
    'CABRAL',
    'ANIKA REI',
    'A',
    '0425-0299',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-11-13',
    '4039, TAGPUAN ST. BAYOG, LOS BAÑOS, LAGUNA',
    '09109962829',
    'https://www.facebook.com/share/1BrcebKT5a/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1aqkI4jpnG1mL6uYRcd6uTQVjGPBM948v',
    'https://drive.google.com/open?id=1IVcE2kemdzN_uvevQ1To6N6kc07ldUrg',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'cassandravperena@gmail.com',
    'Pereña',
    'Cassandra Monique',
    'V',
    '0426-0208',
    v_prog_id,
    'First Year',
    'Female',
    '2008-09-22',
    'B26 L11 VILLA DE CALAMBA SUBDIVISION BRGY. LA MESA, CALAMBA CITY, LAGUNA',
    '09205587366',
    'https://www.facebook.com/cxsyy',
    'Consistent High Honor Student (SHS), Performing Arts Member - Theater Arts Audition Passer (SHS), Student Leader (President, Secretary, and Representative position; SHS), 2nd place in Cheerdance Competition (SHS), Distinguished Officer Awardee',
    v_unit_id,
    'https://drive.google.com/open?id=1pKrBspr4VixOCLffCGvML9hy5e7Af5WC',
    'https://drive.google.com/open?id=1L9YxMfEuKMrbEjBEBS4xS_MoH1rUVPjq',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'mm.afalla08@gmail.com',
    'AFALLA',
    'MARY MICHELLE',
    'D',
    '0426-0288',
    v_prog_id,
    'First Year',
    'Female',
    '2007-11-07',
    '1599 Lalakay Los baños Laguna',
    '09675136518',
    'https://www.facebook.com/marymichelle.afalla/',
    '-Junior High School Completer - With Honors (S.Y. 2023-2024)
-Maintained good academic standing in Senior High School (2024-2026)
 -𝙋𝙖𝙧𝙩𝙞𝙘𝙞𝙥𝙖𝙩𝙚𝙙 on DILG IV-A Short Film Making Contest 2025 (BKD x SSOCSCIE) | Division of Laguna | S.Y. 2025-2026
-Recognize 𝙈𝙤𝙨𝙩 𝙊𝙪𝙩𝙨𝙩𝙖𝙣𝙙𝙞𝙣𝙜 𝙊𝙧𝙜𝙖𝙣𝙞𝙯𝙖𝙩𝙞𝙤𝙣 (BKD) 𝙤𝙛 𝙩𝙝𝙚 𝙔𝙚𝙖𝙧 for school year (2025-2026)
-Certification on Technical Working Group at BKD First Orientation | "The Barkada Factor: -The Power of Positive Friendship - Turning Your Barkada Into a Support System, Not a Trap." | (S.Y 2025-2026)
-Achieved a good attendance record, demonstrating reliability and punctuality (S.Y 2025-2026)',
    v_unit_id,
    'https://drive.google.com/open?id=1ZfCOx0mutez4xoCfLnwaL-eCHpzqABw6',
    'https://drive.google.com/open?id=1mZ4GQxPd7DWq1L-A6oaowBpJiskk8I0R',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'ralphjacobrelleve123@gmail.com',
    'Relleve',
    'Ralph Jacob Labador',
    '',
    '0426-0295',
    v_prog_id,
    'First Year',
    'Male',
    '2007-12-17',
    'San Antoñio Laguna  , bangkal street, Ramos compound',
    '09276045315',
    'https://www.facebook.com/share/1Hi9u2vnAa/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1KBMHmqkBFlif6xkH15LM6C44OossJIFR',
    'https://drive.google.com/open?id=1vmr0IkrZ5e3m64HXRgdhcQlALm6TFotO',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED - Filipino' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'KATHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    '3p.erospadilla@gmail.com',
    'PADILLA',
    'ELDOUS',
    'O',
    '0425-0767',
    v_prog_id,
    'Second Year',
    'Male',
    '2007-02-10',
    '#1361 Sitio. Maligaya, Brgy. Paciano Rizal, Calamba City, Laguna',
    '0994 966 1504',
    'https://www.facebook.com/eldous.padilla',
    '𝑳𝒆𝒂𝒅𝒆𝒓𝒔𝒉𝒊𝒑
‎★ T.A.N.G.L.A.W. 2025; Lakan
‎★ T.A.N.G.L.A.W. 2026; Pangulo
‎★ CTE-SC 2026; VP for Publication and Materials
‎★ ROTC BATCH SANDIGAN; Secretary
‎
‎𝑨𝒘𝒂𝒓𝒅𝒔
‎★ T.A.N.G.L.A.W. - Mr. AmBASAdor 2026
‎★ CTE Year-End Party 2025; What do you meme? competition - 3rd placer
‎★ CTE Year-End Party 2025; Game 1 -  Champion
‎★ Works and Life of Rizal Stage Play - Best Supporting Actor
‎★ Works and Life of Rizal Stage Play - Best Stageplay
‎★ GAWAD TANGLAW; Natatanging kahusayan sa larangan ng lider-estudyante
‎★ GAWAD TANGLAW; Natatanging kahusayan sa larangan ng serbisyong pang-organisasyon at departamento
‎★ GAWAD TANGLAW; Aktibong Mag-aaral
‎
‎𝑬𝒙𝒕𝒓𝒂-𝒄𝒖𝒓𝒓𝒊𝒄𝒖𝒍𝒂𝒓 𝑨𝒄𝒕𝒊𝒗𝒊𝒕𝒊𝒆𝒔 
‎★ ROTC Day, Master of Ceremony - Certificate of Appreciation
‎★ ROTC Day - Overall 4th placer
‎★ ROTC; Pinning of Ranks of Advance ROTC Cadet Officers and opening collar for Cadet Officer Candidate Course, Master of Ceremony - Certificate of Appreciation
‎★ Prof Ed 1 Culminating Activity Seminar; Filipino Representative - Certificate of Appreciation and Participation
‎★ Ka-Peeryu Webinar; The Navigator Vibe: The Power of Emotional Intelligence for Student Leaders - Certificate of Participation
‎★ Kabataan Kontra Droga Seminar -  Certificate of Participation
‎★ Gawad Parangal ( Ka-Piyu ) - Certificate of Appreciation
‎★ GAWAD TANGLAW: SIKLAB - Tagapagdaloy ng Programa
‎★ TANGLAW: Buwan ng Wika - Tagapagdaloy ng Programa
‎★ SIKLAB: May pinaka natatanging kasuotan
‎',
    v_unit_id,
    'https://drive.google.com/open?id=1kGSshj3mnHYb0VoAI2iauGWM-twAsBRs',
    'https://drive.google.com/open?id=1tz5rLb0pnypsxD_vqVRlm9vz6oXg_2XP',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED Social Studies' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jamesbryanalimpuyo15@gmail.com',
    'ALIMPUYO',
    'JAMES BRYAN',
    'B',
    '0426-0570',
    v_prog_id,
    'First Year',
    'Male',
    '2008-06-14',
    'M.H Del Pilar St. Brgy.4 Calamba, Laguna',
    '0994-744-5569',
    'https://www.facebook.com/share/1HhJsLCspD/',
    'Awards:
Agung ng Lahi 2022 - Best Designer
Agung ng Lahi 2023 - Best in Painting
Agung ng Lahi 2025 - Production Bronze Awardee
Agung ng Lahi 2026 - Gawad para sa produksyon 
Agung ng Lahi 2026 - Alay Siklab Awardee
Buwan ng Wika 2025 - Mural Painting 2nd Place

Achievement:
LikKuHay Exhibit 2024 - "Bubbles of the Past" Sold
LikKuHay Exhibit 2025 - "Kabataan" Top 6 Artwork
LikKuHay Exhibit 2026 - " The Pond of Rebirth"',
    v_unit_id,
    'https://drive.google.com/open?id=1W2WkxInRwzUL3kdD5TkiKHJkdezEP2wd',
    'https://drive.google.com/open?id=19bnSdH-iWUznLwlTFwxtRdMkzWmj4njT',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSEd' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'rmaycahinde@gmail.com',
    'Cahinde',
    'Rhose May',
    'C',
    '0426-1131',
    v_prog_id,
    'First Year',
    'Female',
    '2007-09-11',
    'Tadlac Los Baños Laguna',
    '09850606205',
    'https://www.facebook.com/share/1ENYvnhd96/',
    '• Consistent Honor Student from Elementary to Senior High School
• Consistent Classroom President from Grade 1 to Grade 5; served as Classroom Vice President in Grade 11 and Classroom P.I.O. in Grade 12
• Service Awarded as P.I.O. Officer of the Barkada Kontra Droga (BKD) Club (A.Y. 2023–2024)
• 2024 Cluster Festival of Talents – Oratorical Composition and Presentation in Araling Panlipunan Champion 
• 2024 Division Festival of Talents – Oratorical Composition and Presentation in Araling Panlipunan 3rd Placer 
• Division Federation of Supreme Secondary Learner Government (SSLG) Series of Activities – 3-Minute Short Film Making Competition Champion 
• Interschool Mathematics and Science Quiz Bee (Group Category) 2nd Placer
• Cluster Level BIGSAYWIT (Bigkas, Sayaw, Awit) Champion (A.Y. 2018-2019)
• 2016 Nutrition Month Dance Presentation 1st Placer (A.Y. 2016–2017)
• Best Reporter in TLE (A.Y. 2022-2023)',
    v_unit_id,
    'https://drive.google.com/open?id=1e9MJ9DbAfmwG9RysTGxzifTKwzhyWUhT',
    'https://drive.google.com/open?id=1C3bGiUkEz3-EI6Sa-q4w85ydFiEoC3KB',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA-FM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'bambamarielle44@gmail.com',
    'Bamba',
    'Marielle',
    'E',
    '0423-3971',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2005-08-18',
    'Kanluran St., Brgy. Bayog',
    '09705500577',
    'https://www.facebook.com/share/1H7k5SHVng/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1jdeaf_Q8UOOBQqTAOvARSR8WIlOxM8cp',
    'https://drive.google.com/open?id=1EhGHc82tRJ0ET4ZZFSL9bShKTNqBzxdM',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED-FIL' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'sbellezapullon@gmail.com',
    'PULLON',
    'SAMANTHA BELLEZA',
    '',
    '0425-0820',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-04-15',
    '9836 KANLAON ST. BRGY. BATONG MALAKE',
    '09772951553',
    'https://www.facebook.com/share/1DJstFAihf/',
    'Best Dancer (Femme and Hip-hop)',
    v_unit_id,
    'https://drive.google.com/open?id=1_DcFRAdvlygR1ZBnaUCEStWzOON1rgxL',
    'https://drive.google.com/open?id=1RcESF7dlfZEYVNHvzV1RE4eylP0T38Ln',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BTVTED' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'lj.gandollas14@gmail.com',
    'C.',
    'Gandollas Lloyd Jonmuelle',
    '',
    '0423-4444',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2005-02-24',
    '507 Brgy. Calo Bay Laguna',
    '09929560660',
    'https://www.facebook.com/share/1HQTx6SSAd/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=142b-7E7MQ3dsRIhjOveWcw73oT2FbhEg',
    'https://drive.google.com/open?id=1itDFb3DRu2K5-wNKhmcpjVKBYrSv1bZP',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSIT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'besadarius31@gmail.com',
    'Besa',
    'Darius Gabrielle',
    'E',
    '0426-0688',
    v_prog_id,
    'First Year',
    'Male',
    '2008-10-31',
    '0078 Silangan St. Bayog, Los Baños, Laguna',
    '(0924) 439 2483',
    'https://www.facebook.com/share/1CRo1NX4KM/?mibextid=wwXIfr',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1eQIcNZF8dFk4Poqd9uErowPerrFlRyU8',
    'https://drive.google.com/open?id=11HR7lUxDoeZcTQJvWI0Rz_kic0NbHZcl',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSHM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'josephpalmones00@gmail.com',
    'PALMONES',
    'JOSEPH',
    'P',
    '0423-3134',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2000-12-06',
    '352 Sitio Ibaba Brgy Sto Domingo Bay Laguna',
    '09205061654',
    'https://www.facebook.com/share/1BDvkktHoX/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=19vBirg0mEL0OeM8F7rIiJp9HRyHh7Oxk',
    'https://drive.google.com/open?id=1xrkJ_RjMstW7i_mvqWP8pzDhTuhyqkov',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA - FM' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'pauleenlajarca19@gmail.com',
    'Lajarca',
    'Pauleen Angela',
    'M',
    '0426-0319',
    v_prog_id,
    'First Year',
    'Female',
    '2008-01-18',
    '12477 St. Brgy, Mayondon Los Baños Laguna',
    '09626792392',
    'https://www.facebook.com/share/1BvaFLuAxi/?mibextid=wwXIfr',
    'Grade 7 – With Honors
3rd Place, Poster Making
Grade 8 With High Honors
5th Place, Poster Making
Grade 9 – With Honors
Grade 10 – With Honors
Mathematics Achiever (90 General Average)
Grade 12 – With Honors',
    v_unit_id,
    'https://drive.google.com/open?id=185XZ36E64YT4m04pTEVoDOGXosjBlIn3',
    'https://drive.google.com/open?id=1k0QRKRMGu4WH7UFN71TwQxZfM2XN3h2Q',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSIT' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'darzellapitan@gmail.com',
    'Lapitan',
    'Darzel Marie',
    'H',
    '0425-0567',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-09-16',
    '6654 San Antonio Los Baños Laguna',
    '09942829965',
    'https://www.facebook.com/share/1CHmedJVJs/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1ZARCZ4ZN9ZtPtcndTKUSQCAIcBnxI1dK',
    'https://drive.google.com/open?id=1-J_NAwhYo3hFZ3fIhzkVURkQwhQf5yJI',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Science in Accountancy' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'johnerdeljvillasor@gmail.com',
    'Villasor',
    'John Erdel J.',
    '',
    '0423-4648',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2002-07-24',
    'Purok 7, Banlic, Calamba City, Laguna',
    '09303664294',
    'https://www.facebook.com/del.villasor?mibextid=ZbWKwL',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1wkh62MBxYp_u3UxW8fTIMQaxkV1J5wj7',
    'https://drive.google.com/open?id=1M_a30JUATUwnEj2d4zj9uVq7y3SnNBh3',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS Nutrition and Dietetics' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'mannytambor1@gmail.com',
    'Tambor',
    'Manny Jr.',
    'D',
    '0426-0932',
    v_prog_id,
    'First Year',
    'Prefer not to say',
    '2007-11-18',
    'Purok 2 Bagong Nayon, Brngy. Anos Los Baños Laguna',
    '09972600420',
    'https://www.facebook.com/manny.tambor.5',
    'Best Perfomer in Performing Arts',
    v_unit_id,
    'https://drive.google.com/open?id=1DTh4xDAHYxhl3GIuc3-Tt0yF6YIlhoqo',
    'https://drive.google.com/open?id=1aUoMifa674Bs7bI7e2uvMOGGhjwEfeFx',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'miguelerrolmalabanan@gmail.com',
    'Malabanan',
    'Miguel Errol Braga',
    '',
    '0426-0625',
    v_prog_id,
    'First Year',
    'Male',
    '2008-03-10',
    'Paciano Rizal Bay, Laguna',
    '09910126081',
    'https://www.facebook.com/miguelerrol.malabanan',
    'Best Actor (for playing "Basilio" in a musical play) 2022
Best musical play 2022 
1st place in traditional dance 2022 (waray-waray)
Best director ("El Filibusterismo" musical film) 2023
3rd place in traditional dance 2024 (bilaskugay)
3rd place in modern dance 2025',
    v_unit_id,
    'https://drive.google.com/open?id=1Qp5C71G1tfiGfSjn-DUHRlN9QCs42Pyp',
    'https://drive.google.com/open?id=1fNDVlS32Rv3Tbw-rEPiXcN4C8noTnzjH',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'chloevenicecortejo@gmail.com',
    'Cortejo',
    'Chloe Venice',
    'A',
    '0425-0470',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-07-12',
    '4087 Tagpuan St. Bayog. Los Baños, Laguna.',
    '09198048554',
    'https://www.facebook.com/share/1LjBb1dGD2/?mibextid=wwXIfr',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1F-qyyLroD3QG9Y66j31jKhRDGxCTqPO1',
    'https://drive.google.com/open?id=1gqtJvpBda8syBOGq9_atJN8Qh_VIHBWm',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED Science' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'joanemontemayor204@gmail.com',
    'MONTEMAYOR',
    'JOANE ASHLEY MARIBEL',
    'O',
    '0425-0077',
    v_prog_id,
    'Second Year',
    'Female',
    '2006-08-30',
    '132 Sitio Sampaloc Maahas Los Baños Laguna',
    '09933649392',
    'https://www.facebook.com/joane.montemayor.58',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1EeRyaRIm7Z_Ii3KKLePM_5mT1cFacnDr',
    'https://drive.google.com/open?id=1FaJNS8o5ACGlKwyBk_FjdyrbrlG-RIkR',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED MAJOR IN FILIPINO' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'trishatonga9@gmail.com',
    'TONGA',
    'TRISHA',
    'A',
    '0425-0799',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-02-20',
    'PUROK 5, S. ANGELES ST. MAYONDON LOS BAÑOS LAGUNA',
    '09858841951',
    'https://www.facebook.com/share/1L1RW72CD1/',
    'GRADE 11:
•With Honors
GRADE 12:
•With High Honors 
•Best in Work Immersion (UP main library)
•1st YEAR COLLEGE:
•Radio Drama (U-WIDE) - (Ikalawang Puwesto)
•Malikahaing Pagbasa (Kampeon/Ikaunang Puwesto)
•Ambassadress (Ikalawang Puwesto)
2nd YEAR COLLEGE:
•Spoken Poetry (Ikalawang Puwesto) (BUWAN NG WIKA) 
•Natatanging Kahusayan sa Larangan ng Serbisyong Pang-Organisasyon at Departamento (GAWAD TANGLAW)
•Natatanging Kahusayan sa Larangan ng Sining (Teatro) (GAWAD TANGLAW)',
    v_unit_id,
    'https://drive.google.com/open?id=1wIyY5W7EXJjNIXSV72ohjaxjsbxWpwu-',
    'https://drive.google.com/open?id=1RG87RjPjxgawDZFR5aRmrue-rwnRDiiD',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSED Major in Social Studies' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'yangagerald98@gmail.com',
    'YANGA',
    'GERALD',
    'C',
    '0424-0025',
    v_prog_id,
    'Third Year',
    'Male',
    '1993-09-22',
    'St.Francis Subdivision, Barangay Bayog, Los Baños, Laguna',
    '09911464966',
    'https://www.facebook.com/profile.php?id=61592153913312',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1COMzfnl5tFiK6V6WuFgGhJw8nqZpQfEG',
    'https://drive.google.com/open?id=1VAm1NNkep3BaRhs4d-r3XWw3TQL82Dx1',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Secondary Education major in Science' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'micaybalasa@gmail.com',
    'Balasa',
    'Maria Alexandra Ysabella',
    'M',
    '0425-0484',
    v_prog_id,
    'First Year',
    'Female',
    '2007-10-09',
    'Blk 2 Lot 29 Saint Joseph Village Phase 1 Southville 5, Brgy. Timbao, Biñan City, Laguna',
    '0908 754 7318',
    'https://www.facebook.com/mariaalexandraysabella.balasa',
    'none',
    v_unit_id,
    'https://drive.google.com/open?id=1lKZqewt-WQbHpb5iOhvb4_0Y8em8Qxu2',
    'https://drive.google.com/open?id=1Cbh36NT1yFJMS9RLp1PXGvlLz__Mw0rv',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'CCJE' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'bernardf288@gmail.com',
    'Flores',
    'Bernard',
    'N',
    '0425-0308',
    v_prog_id,
    'Second Year',
    'Male',
    '2006-11-27',
    'BRGY, San Antonio Purok5 Sitio Pag-Asa',
    '09639544208',
    'https://www.facebook.com/share/1BsdEvhuVC/?mibextid=wwXIfr',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=1YqtxWAN6UW9mrLv2IH5MfYKxWci6v1T4',
    'https://drive.google.com/open?id=1g2ZrbZJ22w3N9sM5t0IMA0D5W3NCEqk_',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Physical Education' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'olicsalazar@gmail.com',
    'Salazar',
    'Justene',
    'A',
    '0423-4408',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2005-01-01',
    'Blk 35 Lot 106 Ph 5 Mabuhay City Mamatid Cabuyao Laguna',
    '09606900150',
    'https://www.facebook.com/share/1Bq6uoTcSQ/',
    'Cte Week Declamation Contest (Champion) 2023
1st Place (Short and Sweet Play) 2024',
    v_unit_id,
    'https://drive.google.com/open?id=1LUOyku8fgAhqotPMZWxiWI9JK9CH_Yhk',
    'https://drive.google.com/open?id=1tUDaDoFHUrT9SWZCWs_imJ_TKRQUyqX4',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSND' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'zenemijuriko@gmail.com',
    'JIMENEZ',
    'URIKO MEI',
    'B',
    '0423-4065',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2005-09-04',
    '0064 Silangan, Bayog, Los Baños, Laguna',
    '09102959713 / 09929959832',
    'https://www.facebook.com/share/1EtnzcC1GR/',
    'Dean''s Lister (2023-2025), 3rd place Short and Sweet Play (2024), 2nd place Radio Drama (2025)',
    v_unit_id,
    'https://drive.google.com/open?id=1eM2Ueep17RuQ8P0j4MQAiLwlduWoRzZ9',
    'https://drive.google.com/open?id=1gtUPi85j8yHTJNq3DMqtm7FUEyifAor3',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Secondary Education major in English' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'LIKHA ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'mirasol.czarinadenisse@gmail.com',
    'MIRASOL',
    'CZARINA DENISSE',
    'G',
    '0423-4473',
    v_prog_id,
    'Fourth Year',
    'Female',
    '2004-12-25',
    '742 Ilang-ilang, Purok 2 St. Brgy. Bambang, Los Baños, Laguna',
    '09944090841',
    'https://www.facebook.com/share/1F6YjYmwBx/',
    'NONE',
    v_unit_id,
    'https://drive.google.com/open?id=17glxFt1yrvWg0yH-qPkM6bDQ6NYF3OFO',
    'https://drive.google.com/open?id=1hqdXZom9jodTpJyNyw-eQu6VxjpBIqB-',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BS Nutrition and Dietetics' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'RITMO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'akishajahrenpanisales@gmail.com',
    'Panisales',
    'Akisha Jahren',
    'N',
    '0424-0845',
    v_prog_id,
    'Third Year',
    'Female',
    '2006-06-24',
    'Purok 6 San Antonio, Bay, Laguna 4033',
    '09086877205',
    'https://www.facebook.com/share/1EDRcBnw9S/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1AF3A-pItPqwIoSCKyiyByLt7mgCxffZJ',
    'https://drive.google.com/open?id=1SAL22nHf1W12acvI2Xl7roubB5GTEyK1',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'alcaydeknightley@gmail.com',
    'ALCAYDE',
    'KNIGHTLEY',
    'L',
    '0424-0038',
    v_prog_id,
    'Third Year',
    'Female',
    '2006-06-30',
    '12109 J Aquino st. Mayondon Los Baños Laguna',
    '09948766100',
    'https://www.facebook.com/knightley.alcayde.2024',
    'SHS & COLLEGE
Gr 11 - With Honors
Sabayang pagbigkas ( CDLB) champion
Sabayang pagbigkas( CMDI) champion
Gr 12 - With High Honors
Best in Work Immersion (HRM Municipal of LB)
Outstanding Performance in Performing Arrs Award
Service Award (SBO)
DL''s (1st yr 2nd sem, 2nd yr 1st & 2nd sem)
Service Award ( Jfinex) 1st yr & 2nd yr
Best Actress 2024 ( Likhayag)  
Short & Sweet Play (Uwide) 2nd place
Noli me tangere - (Sisa) Best Actress',
    v_unit_id,
    'https://drive.google.com/open?id=1que5eUjEF8ejfch8xBNep_y3wFPzPdG6',
    'https://drive.google.com/open?id=1EoButqlFmZdYbCY5EG0jYVMgFfUvI80y',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSed English' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'jhusteenealbania@gmail.com',
    'Albania',
    'Jhusteene Mei',
    'C',
    '0424-0152',
    v_prog_id,
    'Third Year',
    'Female',
    '2005-11-18',
    '0824 Purok 4. Brgy, Daang Bakal, Maitim Bay, Laguna',
    '09818002140',
    'https://www.facebook.com/profile.php?id=61579116809888',
    'n/a',
    v_unit_id,
    'https://drive.google.com/open?id=17fD6RlTaWUn-xzFmu94t55o466rqC58o',
    'https://drive.google.com/open?id=12WZlw5fdYd1B14TETMUwxpCtGfbg4v8M',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'CTE BPED ll - A' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'preciousjewellerymeneses@gmail.com',
    'Meneses',
    'Precious Jewel Cortez',
    '',
    '0425-0725',
    v_prog_id,
    'Second Year',
    'Female',
    '2007-01-01',
    '306, Purok 2, Kawayanan, Brgy. Malinta Los Baños Laguna',
    '09346201536',
    'https://www.facebook.com/prxcious.jewelry',
    'teatro workshop (best actress), first production (main character) MBSS43',
    v_unit_id,
    'https://drive.google.com/open?id=18ksSoMmDQ62SJIrmafcn67-56yBonVcL',
    'https://drive.google.com/open?id=1z9m5VSgBpxY1RZI3gd2VLtoyD49KY0Kv',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'Bachelor of Science in Information Technology' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'HIMIG ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'joshuazechariah24@gmail.com',
    'HERRERA',
    'JOSHUA ZECHARIAH',
    'L',
    '0422-1383',
    v_prog_id,
    'Fourth Year',
    'Male',
    '2001-09-30',
    '8851, Batong Malake, Los Baños Laguna',
    '09678474302',
    'https://www.facebook.com/share/1T2hiPMnvq/',
    '- Bronze Diploma at Biñan National Chorale Festival
- 2nd place at LSPU Culture and Arts Festival intercampus mixed choir category',
    v_unit_id,
    'https://drive.google.com/open?id=10u928-bI724lnYURpW4esIoJ1NkG6mCr',
    'https://drive.google.com/open?id=1CCtKv2W1ZY3qMdFntN05jd2mmcirJKPh',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;


DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = 'BSBA - 1B - M.M.' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = 'TEATRO ESKULTURA' LIMIT 1;

  INSERT INTO public.student_profiles (
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
    'k.maryllemayo@gmail.com',
    'MAYO',
    'KRIXIA MARYLLE',
    'B',
    '0426-0044',
    v_prog_id,
    'First Year',
    'Female',
    '2008-09-07',
    '820, Purok 3, Brgy. Malinta, Los Baños, Laguna',
    '09219325018',
    'https://www.facebook.com/share/1ETSFAtWB6/',
    'None',
    v_unit_id,
    'https://drive.google.com/open?id=1PqYLq64WOvCambExV2KCqGK3dXw8T6qV',
    'https://drive.google.com/open?id=1WIE73Bu_X1bJydtbDA8SKv5_QJbO2xxY',
    'submitted'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;
