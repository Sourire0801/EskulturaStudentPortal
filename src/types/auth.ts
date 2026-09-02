import type { UserRole, Profile } from './database';

export interface AuthUser {
  id: string;
  email: string;
  role: UserRole;
  profile?: Profile | null;
}

export interface AuthState {
  user: AuthUser | null;
  loading: boolean;
  error: string | null;
}
