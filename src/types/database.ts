export type UserRole = 'student' | 'admin';
export type YearLevel = 'First Year' | 'Second Year' | 'Third Year' | 'Fourth Year';
export type Gender = 'Male' | 'Female' | 'Prefer not to say';
export type StudentStatus = 'draft' | 'submitted' | 'archived';

export interface Profile {
  id: string;
  email: string;
  role: UserRole;
  created_at: string;
  updated_at: string;
}

export interface Program {
  id: string;
  name: string;
  is_active: boolean;
  created_at: string;
}

export interface EskulturaUnit {
  id: string;
  name: string;
  is_active: boolean;
  created_at: string;
}

export interface StudentProfile {
  id: string;
  user_id?: string | null;
  email?: string | null;
  surname: string;
  first_name: string;
  middle_initial: string;
  student_number: string;
  program_id: string | null;
  year_level: YearLevel;
  gender: Gender;
  date_of_birth: string;
  complete_address: string;
  contact_number: string;
  facebook_profile: string;
  achievements: string;
  eskultura_unit_id: string | null;
  photo_url: string | null;
  signature_url: string | null;
  status: StudentStatus;
  created_at: string;
  updated_at: string;

  // Joined relations
  program?: Program | null;
  eskultura_unit?: EskulturaUnit | null;
  profile?: Profile | null;
}
