import { supabase } from '../lib/supabase';
import type { StudentProfile, StudentStatus } from '../types/database';
import type { MemberFilterOptions, AdminDashboardStats } from '../types/student';

export const memberService = {
  /**
   * Fetch members with server-side / query-level filtering
   */
  async getMembers(
    filters: MemberFilterOptions,
    page: number = 1,
    pageSize: number = 20
  ): Promise<{ data: StudentProfile[]; total: number }> {
    let query = supabase
      .from('student_profiles')
      .select(
        `
        *,
        program:programs(*),
        eskultura_unit:eskultura_units(*),
        profile:profiles(*)
      `,
        { count: 'exact' }
      );

    // Archiving filter
    if (filters.showArchived) {
      query = query.eq('status', 'archived');
    } else {
      if (filters.status && filters.status !== 'all') {
        query = query.eq('status', filters.status);
      } else {
        query = query.neq('status', 'archived');
      }
    }

    // Program filter
    if (filters.programId) {
      query = query.eq('program_id', filters.programId);
    }

    // Unit filter
    if (filters.unitId) {
      query = query.eq('eskultura_unit_id', filters.unitId);
    }

    // Year level filter
    if (filters.yearLevel) {
      query = query.eq('year_level', filters.yearLevel);
    }

    // Gender filter
    if (filters.gender) {
      query = query.eq('gender', filters.gender);
    }

    // Search Query (Student number, Surname, First Name)
    if (filters.searchQuery && filters.searchQuery.trim() !== '') {
      const term = `%${filters.searchQuery.trim()}%`;
      query = query.or(
        `student_number.ilike.${term},surname.ilike.${term},first_name.ilike.${term}`
      );
    }

    // Pagination & Ordering
    const from = (page - 1) * pageSize;
    const to = from + pageSize - 1;

    const { data, count, error } = await query
      .order('created_at', { ascending: false })
      .range(from, to);

    if (error) throw error;

    return {
      data: (data as StudentProfile[]) || [],
      total: count || 0,
    };
  },

  /**
   * Fetch a single member's complete details
   */
  async getMemberById(id: string): Promise<StudentProfile | null> {
    const { data, error } = await supabase
      .from('student_profiles')
      .select(
        `
        *,
        program:programs(*),
        eskultura_unit:eskultura_units(*),
        profile:profiles(*)
      `
      )
      .eq('id', id)
      .single();

    if (error) throw error;
    return data as StudentProfile;
  },

  /**
   * Update a member's profile
   */
  async updateMember(
    id: string,
    updates: Partial<StudentProfile>
  ): Promise<StudentProfile> {
    const { data, error } = await supabase
      .from('student_profiles')
      .update(updates as any)
      .eq('id', id)
      .select(
        `
        *,
        program:programs(*),
        eskultura_unit:eskultura_units(*),
        profile:profiles(*)
      `
      )
      .single();

    if (error) throw error;
    return data as StudentProfile;
  },

  /**
   * Archive a member (sets status to 'archived')
   */
  async archiveMember(id: string): Promise<void> {
    const { error } = await supabase
      .from('student_profiles')
      .update({ status: 'archived' as StudentStatus } as any)
      .eq('id', id);

    if (error) throw error;
  },

  /**
   * Restore an archived member back to 'submitted'
   */
  async restoreMember(id: string): Promise<void> {
    const { error } = await supabase
      .from('student_profiles')
      .update({ status: 'submitted' as StudentStatus } as any)
      .eq('id', id);

    if (error) throw error;
  },

  /**
   * Get aggregate statistics for the Admin Dashboard
   */
  async getDashboardStats(): Promise<AdminDashboardStats> {
    // Fetch active (non-archived) members
    const { data: members, error } = await supabase
      .from('student_profiles')
      .select(
        `
        *,
        program:programs(name),
        eskultura_unit:eskultura_units(name)
      `
      )
      .neq('status', 'archived');

    if (error) throw error;

    const allMembers = (members as any[]) || [];
    const totalMembers = allMembers.length;

    let firstYearCount = 0;
    let secondYearCount = 0;
    let thirdYearCount = 0;
    let fourthYearCount = 0;

    const programCounts: Record<string, number> = {};
    const unitCounts: Record<string, number> = {};
    const genderCounts: Record<string, number> = {
      Male: 0,
      Female: 0,
      'Prefer not to say': 0,
    };

    allMembers.forEach((m) => {
      // Year level
      if (m.year_level === 'First Year') firstYearCount++;
      else if (m.year_level === 'Second Year') secondYearCount++;
      else if (m.year_level === 'Third Year') thirdYearCount++;
      else if (m.year_level === 'Fourth Year') fourthYearCount++;

      // Program
      const progName = m.program?.name || 'Unassigned';
      programCounts[progName] = (programCounts[progName] || 0) + 1;

      // Unit
      const unitName = m.eskultura_unit?.name || 'Unassigned';
      unitCounts[unitName] = (unitCounts[unitName] || 0) + 1;

      // Gender
      if (m.gender && genderCounts[m.gender] !== undefined) {
        genderCounts[m.gender]++;
      } else if (m.gender) {
        genderCounts[m.gender] = (genderCounts[m.gender] || 0) + 1;
      }
    });

    const byProgram = Object.entries(programCounts).map(([name, count]) => ({
      name,
      count,
    }));
    const byUnit = Object.entries(unitCounts).map(([name, count]) => ({
      name,
      count,
    }));
    const byGender = Object.entries(genderCounts).map(([gender, count]) => ({
      gender,
      count,
    }));

    // Fetch 5 most recent members
    const { data: recent } = await supabase
      .from('student_profiles')
      .select(
        `
        *,
        program:programs(*),
        eskultura_unit:eskultura_units(*)
      `
      )
      .order('created_at', { ascending: false })
      .limit(5);

    return {
      totalMembers,
      firstYearCount,
      secondYearCount,
      thirdYearCount,
      fourthYearCount,
      byProgram,
      byUnit,
      byGender,
      recentMembers: (recent as StudentProfile[]) || [],
    };
  },

  /**
   * Export all matching members to CSV (respects currently active filters)
   */
  async exportMembersToCsv(filters: MemberFilterOptions): Promise<void> {
    let query = supabase.from('student_profiles').select(`
        student_number,
        surname,
        first_name,
        middle_initial,
        year_level,
        gender,
        date_of_birth,
        complete_address,
        contact_number,
        facebook_profile,
        achievements,
        status,
        created_at,
        program:programs(name),
        eskultura_unit:eskultura_units(name),
        profile:profiles(email)
      `);

    if (filters.showArchived) {
      query = query.eq('status', 'archived');
    } else {
      if (filters.status && filters.status !== 'all') {
        query = query.eq('status', filters.status);
      } else {
        query = query.neq('status', 'archived');
      }
    }

    if (filters.programId) query = query.eq('program_id', filters.programId);
    if (filters.unitId) query = query.eq('eskultura_unit_id', filters.unitId);
    if (filters.yearLevel) query = query.eq('year_level', filters.yearLevel);
    if (filters.gender) query = query.eq('gender', filters.gender);

    if (filters.searchQuery && filters.searchQuery.trim() !== '') {
      const term = `%${filters.searchQuery.trim()}%`;
      query = query.or(
        `student_number.ilike.${term},surname.ilike.${term},first_name.ilike.${term}`
      );
    }

    const { data, error } = await query.order('surname', { ascending: true });

    if (error) throw error;
    if (!data || data.length === 0) {
      alert('No members found to export with the selected filters.');
      return;
    }

    // CSV Headers
    const headers = [
      'Student Number',
      'Surname',
      'First Name',
      'M.I.',
      'Program',
      'Year Level',
      'Gender',
      'Date of Birth',
      'Email',
      'Contact Number',
      'Complete Address',
      'Facebook Profile',
      'ESKULTURA Unit',
      'Achievements',
      'Status',
      'Registration Date',
    ];

    const escapeCsv = (val: string | null | undefined): string => {
      if (val === null || val === undefined) return '""';
      const clean = String(val).replace(/"/g, '""');
      return `"${clean}"`;
    };

    const rows = (data as any[]).map((item: any) => [
      escapeCsv(item.student_number),
      escapeCsv(item.surname),
      escapeCsv(item.first_name),
      escapeCsv(item.middle_initial),
      escapeCsv(item.program?.name || 'N/A'),
      escapeCsv(item.year_level),
      escapeCsv(item.gender),
      escapeCsv(item.date_of_birth),
      escapeCsv(item.profile?.email || 'N/A'),
      escapeCsv(item.contact_number),
      escapeCsv(item.complete_address),
      escapeCsv(item.facebook_profile),
      escapeCsv(item.eskultura_unit?.name || 'N/A'),
      escapeCsv(item.achievements),
      escapeCsv(item.status),
      escapeCsv(
        item.created_at ? new Date(item.created_at).toLocaleDateString() : ''
      ),
    ]);

    const csvContent = [
      headers.join(','),
      ...rows.map((r) => r.join(',')),
    ].join('\r\n');

    // Trigger browser download
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.setAttribute('href', url);
    const timestamp = new Date().toISOString().slice(0, 10);
    link.setAttribute('download', `ESKULTURA_Members_${timestamp}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
  },
};
