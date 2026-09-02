import { useState, useEffect, useCallback } from 'react';
import { useAuth } from './useAuth';
import { studentService } from '../services/studentService';
import type { StudentProfile } from '../types/database';

export const useStudentProfile = () => {
  const { user } = useAuth();
  const [profile, setProfile] = useState<StudentProfile | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchProfile = useCallback(async () => {
    if (!user) {
      setProfile(null);
      setLoading(false);
      return;
    }

    try {
      setLoading(true);
      setError(null);
      const data = await studentService.getStudentProfile(user.id, user.email || undefined);
      setProfile(data);
    } catch (err: any) {
      console.error('Error fetching student profile:', err);
      setError(err.message || 'Failed to load profile');
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    fetchProfile();
  }, [fetchProfile]);

  return {
    profile,
    loading,
    error,
    refreshProfile: fetchProfile,
  };
};
