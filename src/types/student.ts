import type { YearLevel, Gender, StudentStatus, StudentProfile, Program, EskulturaUnit } from './database';

export interface StudentFormData {
  surname: string;
  first_name: string;
  middle_initial: string;
  student_number: string;
  program_id: string;
  year_level: YearLevel | '';
  gender: Gender | '';
  date_of_birth: string;
  complete_address: string;
  email: string; // pre-populated from auth
  contact_number: string;
  facebook_profile: string;
  achievements: string;
  eskultura_unit_id: string;
  photo_url: string | null;
  signature_url: string | null;
}

export interface StudentFormErrors {
  surname?: string;
  first_name?: string;
  middle_initial?: string;
  student_number?: string;
  program_id?: string;
  year_level?: string;
  gender?: string;
  date_of_birth?: string;
  complete_address?: string;
  email?: string;
  contact_number?: string;
  facebook_profile?: string;
  achievements?: string;
  eskultura_unit_id?: string;
  photo_url?: string;
  signature_url?: string;
  general?: string;
}

export interface MemberFilterOptions {
  searchQuery: string;
  programId: string;
  unitId: string;
  yearLevel: string;
  gender: string;
  status: StudentStatus | 'all';
  showArchived: boolean;
}

export interface AdminDashboardStats {
  totalMembers: number;
  firstYearCount: number;
  secondYearCount: number;
  thirdYearCount: number;
  fourthYearCount: number;
  byProgram: { name: string; count: number }[];
  byUnit: { name: string; count: number }[];
  byGender: { gender: string; count: number }[];
  recentMembers: StudentProfile[];
}

export interface FormOptionsData {
  programs: Program[];
  units: EskulturaUnit[];
}
