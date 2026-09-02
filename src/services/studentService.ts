import { supabase } from '../lib/supabase';
import type { Program, EskulturaUnit, StudentProfile, StudentStatus, YearLevel, Gender } from '../types/database';
import type { StudentFormData } from '../types/student';

export const studentService = {
  /**
   * Fetch active academic programs
   */
  async getActivePrograms(): Promise<Program[]> {
    const { data, error } = await supabase
      .from('programs')
      .select('*')
      .eq('is_active', true)
      .order('name', { ascending: true });

    if (error) throw error;
    return (data as Program[]) || [];
  },

  /**
   * Fetch active ESKULTURA units
   */
  async getActiveUnits(): Promise<EskulturaUnit[]> {
    const { data, error } = await supabase
      .from('eskultura_units')
      .select('*')
      .eq('is_active', true)
      .order('name', { ascending: true });

    if (error) throw error;
    return (data as EskulturaUnit[]) || [];
  },

  /**
   * Fetch student profile by user_id (and optionally email fallback for imported profiles)
   */
  async getStudentProfile(userId: string, email?: string): Promise<StudentProfile | null> {
    // 1. Check by user_id
    const { data, error } = await supabase
      .from('student_profiles')
      .select(`
        *,
        program:programs(*),
        eskultura_unit:eskultura_units(*)
      `)
      .eq('user_id', userId)
      .maybeSingle();

    if (error) throw error;
    if (data) return data as StudentProfile;

    // 2. If no profile found by user_id and email is provided, check for unclaimed imported profile
    if (email && email.trim()) {
      const { data: unclaimedData, error: unclaimedError } = await supabase
        .from('student_profiles')
        .select(`
          *,
          program:programs(*),
          eskultura_unit:eskultura_units(*)
        `)
        .is('user_id', null)
        .ilike('email', email.trim())
        .maybeSingle();

      if (!unclaimedError && unclaimedData) {
        // Auto-link user_id to this unclaimed profile
        await supabase
          .from('student_profiles')
          .update({ user_id: userId })
          .eq('id', unclaimedData.id);

        return { ...unclaimedData, user_id: userId } as StudentProfile;
      }
    }

    return null;
  },

  /**
   * Check if a student number is already taken
   */
  async isStudentNumberUnique(studentNumber: string, currentUserId?: string): Promise<boolean> {
    const cleanSn = studentNumber.trim();
    if (!cleanSn) return true;

    try {
      // 1. Try secure RPC function (bypasses RLS to verify across the entire database)
      const { data: rpcData, error: rpcError } = await supabase.rpc(
        'check_student_number_available',
        {
          p_student_number: cleanSn,
          p_user_id: currentUserId || null,
        }
      );

      if (!rpcError && rpcData !== null) {
        return rpcData.available !== false;
      }
    } catch {
      // Fallback to table query if RPC is not yet registered in Supabase
    }

    // 2. Direct table fallback query
    let query = supabase
      .from('student_profiles')
      .select('id, user_id')
      .eq('student_number', cleanSn);

    if (currentUserId) {
      query = query.neq('user_id', currentUserId);
    }

    const { data, error } = await query;
    if (error) throw error;
    return !data || data.length === 0;
  },

  /**
   * Save or Update student profile
   */
  async saveStudentProfile(
    userId: string,
    formData: StudentFormData,
    status: StudentStatus = 'submitted'
  ): Promise<StudentProfile> {
    const cleanSn = formData.student_number.trim();
    const payload = {
      user_id: userId,
      surname: formData.surname.trim(),
      first_name: formData.first_name.trim(),
      middle_initial: formData.middle_initial.trim().toUpperCase(),
      student_number: cleanSn,
      program_id: formData.program_id || null,
      year_level: (formData.year_level as YearLevel) || 'First Year',
      gender: (formData.gender as Gender) || 'Male',
      date_of_birth: formData.date_of_birth,
      complete_address: formData.complete_address.trim(),
      contact_number: formData.contact_number.trim(),
      facebook_profile: formData.facebook_profile.trim(),
      achievements: formData.achievements.trim() || 'NONE',
      eskultura_unit_id: formData.eskultura_unit_id || null,
      photo_url: formData.photo_url,
      signature_url: formData.signature_url,
      status,
    };

    try {
      // 1. Try calling the RPC function (handles claiming and avoiding duplicate key issues)
      const { data: rpcData, error: rpcError } = await supabase.rpc(
        'save_or_claim_student_profile',
        {
          p_user_id: userId,
          p_payload: payload,
          p_status: status,
        }
      );

      if (!rpcError && rpcData) {
        // Fetch relations
        const { data: finalData, error: fetchError } = await supabase
          .from('student_profiles')
          .select(`
            *,
            program:programs(*),
            eskultura_unit:eskultura_units(*)
          `)
          .eq('id', rpcData.id)
          .single();

        if (!fetchError && finalData) {
          return finalData as StudentProfile;
        }
      } else if (rpcError && rpcError.message && !rpcError.message.includes('function') && !rpcError.message.includes('does not exist')) {
        // Known business logic error thrown by RPC
        throw new Error(rpcError.message);
      }
    } catch (rpcErr: any) {
      if (rpcErr.message && (rpcErr.message.includes('already registered') || rpcErr.message.includes('student number'))) {
        throw rpcErr;
      }
      // Otherwise continue to direct fallback
    }

    // 2. Fallback: Direct table operations
    try {
      // Check if there's an unclaimed imported profile with this student number (user_id IS NULL)
      const { data: unclaimedRecord } = await supabase
        .from('student_profiles')
        .select('id, user_id')
        .eq('student_number', cleanSn)
        .is('user_id', null)
        .maybeSingle();

      let targetId: string | undefined;

      if (unclaimedRecord) {
        targetId = unclaimedRecord.id;
      } else {
        const { data: existingUserRecord } = await supabase
          .from('student_profiles')
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();

        if (existingUserRecord) {
          targetId = existingUserRecord.id;
        }
      }

      if (targetId) {
        const { data: updatedData, error: updateError } = await supabase
          .from('student_profiles')
          .update(payload as any)
          .eq('id', targetId)
          .select(`
            *,
            program:programs(*),
            eskultura_unit:eskultura_units(*)
          `)
          .single();

        if (updateError) throw updateError;
        return updatedData as StudentProfile;
      } else {
        const { data: insertedData, error: insertError } = await supabase
          .from('student_profiles')
          .insert(payload as any)
          .select(`
            *,
            program:programs(*),
            eskultura_unit:eskultura_units(*)
          `)
          .single();

        if (insertError) throw insertError;
        return insertedData as StudentProfile;
      }
    } catch (err: any) {
      if (
        err.message?.includes('student_profiles_student_number_key') ||
        err.message?.includes('duplicate key') ||
        err.code === '23505'
      ) {
        throw new Error(
          `The Student Number "${cleanSn}" is already registered in the system. Please verify your student number.`
        );
      }
      throw err;
    }
  },
};
