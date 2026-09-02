import { supabase } from '../lib/supabase';
import type { Program, EskulturaUnit } from '../types/database';

export const adminSettingsService = {
  // ==================== PROGRAMS ====================
  async getPrograms(includeInactive = true): Promise<Program[]> {
    let query = supabase.from('programs').select('*').order('name', { ascending: true });
    if (!includeInactive) {
      query = query.eq('is_active', true);
    }
    const { data, error } = await query;
    if (error) throw error;
    return (data as Program[]) || [];
  },

  async createProgram(name: string): Promise<Program> {
    const { data, error } = await supabase
      .from('programs')
      .insert({ name: name.trim(), is_active: true } as any)
      .select()
      .single();

    if (error) throw error;
    return data as Program;
  },

  async updateProgram(id: string, updates: { name?: string; is_active?: boolean }): Promise<Program> {
    const { data, error } = await supabase
      .from('programs')
      .update(updates as any)
      .eq('id', id)
      .select()
      .single();

    if (error) throw error;
    return data as Program;
  },

  async toggleProgramStatus(id: string, currentStatus: boolean): Promise<Program> {
    return this.updateProgram(id, { is_active: !currentStatus });
  },

  // ==================== ESKULTURA UNITS ====================
  async getUnits(includeInactive = true): Promise<EskulturaUnit[]> {
    let query = supabase.from('eskultura_units').select('*').order('name', { ascending: true });
    if (!includeInactive) {
      query = query.eq('is_active', true);
    }
    const { data, error } = await query;
    if (error) throw error;
    return (data as EskulturaUnit[]) || [];
  },

  async createUnit(name: string): Promise<EskulturaUnit> {
    const { data, error } = await supabase
      .from('eskultura_units')
      .insert({ name: name.trim(), is_active: true } as any)
      .select()
      .single();

    if (error) throw error;
    return data as EskulturaUnit;
  },

  async updateUnit(id: string, updates: { name?: string; is_active?: boolean }): Promise<EskulturaUnit> {
    const { data, error } = await supabase
      .from('eskultura_units')
      .update(updates as any)
      .eq('id', id)
      .select()
      .single();

    if (error) throw error;
    return data as EskulturaUnit;
  },

  async toggleUnitStatus(id: string, currentStatus: boolean): Promise<EskulturaUnit> {
    return this.updateUnit(id, { is_active: !currentStatus });
  },
};
