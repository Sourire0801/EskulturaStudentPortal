import { supabase } from '../lib/supabase';
import type { Profile, UserRole } from '../types/database';

export const authService = {
  /**
   * Sign up with email and password
   */
  async signUp(email: string, password: string, role: UserRole = 'student') {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          role,
        },
      },
    });

    if (error) throw error;

    // Ensure profile row exists if trigger is delayed
    if (data.user) {
      await supabase
        .from('profiles')
        .upsert({
          id: data.user.id,
          email: data.user.email || email,
          role,
        } as any)
        .select()
        .single();
    }

    return data;
  },

  /**
   * Sign in with email and password
   */
  async signIn(email: string, password: string) {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) throw error;
    return data;
  },

  /**
   * Continue with Google OAuth
   */
  async signInWithGoogle() {
    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: `${window.location.origin}/student/dashboard`,
      },
    });

    if (error) throw error;
    return data;
  },

  /**
   * Sign out
   */
  async signOut() {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
  },

  /**
   * Send password reset email
   */
  async resetPassword(email: string) {
    const { data, error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/reset-password`,
    });

    if (error) throw error;
    return data;
  },

  /**
   * Update current user's password
   */
  async updatePassword(newPassword: string) {
    const { data, error } = await supabase.auth.updateUser({
      password: newPassword,
    });

    if (error) throw error;
    return data;
  },

  /**
   * Fetch user profile by Auth ID
   */
  async getProfile(userId: string): Promise<Profile | null> {
    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) {
      if (error.code === 'PGRST116') {
        // Record not found yet, create default
        const { data: userData } = await supabase.auth.getUser();
        if (userData.user && userData.user.id === userId) {
          const { data: newProfile } = await supabase
            .from('profiles')
            .upsert({
              id: userId,
              email: userData.user.email || '',
              role: 'student',
            } as any)
            .select()
            .single();
          return newProfile as Profile;
        }
        return null;
      }
      throw error;
    }

    return data as Profile;
  },
};
