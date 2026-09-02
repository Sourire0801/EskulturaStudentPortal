import React, { useState, useEffect, useCallback } from 'react';
import { adminSettingsService } from '../../services/adminSettingsService';
import { useToast } from '../../components/ui/Toast';
import { Card, CardHeader, CardTitle, CardContent } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Badge } from '../../components/ui/Badge';
import { Modal } from '../../components/ui/Modal';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { EmptyState } from '../../components/ui/EmptyState';
import { Plus } from 'lucide-react';
import type { Program } from '../../types/database';

export const Programs: React.FC = () => {
  const toast = useToast();
  const [programs, setPrograms] = useState<Program[]>([]);
  const [loading, setLoading] = useState(true);

  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingProgram, setEditingProgram] = useState<Program | null>(null);
  const [programName, setProgramName] = useState('');
  const [saving, setSaving] = useState(false);

  const fetchPrograms = useCallback(async () => {
    try {
      setLoading(true);
      const data = await adminSettingsService.getPrograms(true);
      setPrograms(data);
    } catch (err: any) {
      console.error('Error loading programs:', err);
      toast.error('Failed to load programs', err.message);
    } finally {
      setLoading(false);
    }
  }, [toast]);

  useEffect(() => {
    fetchPrograms();
  }, [fetchPrograms]);

  const handleOpenAdd = () => {
    setEditingProgram(null);
    setProgramName('');
    setIsModalOpen(true);
  };

  const handleOpenEdit = (prog: Program) => {
    setEditingProgram(prog);
    setProgramName(prog.name);
    setIsModalOpen(true);
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!programName.trim()) {
      toast.error('Validation Error', 'Program name cannot be empty.');
      return;
    }

    try {
      setSaving(true);
      if (editingProgram) {
        await adminSettingsService.updateProgram(editingProgram.id, {
          name: programName.trim(),
        });
        toast.success('Program Updated', 'Academic program updated successfully.');
      } else {
        await adminSettingsService.createProgram(programName.trim());
        toast.success('Program Added', 'New academic program created.');
      }
      setIsModalOpen(false);
      fetchPrograms();
    } catch (err: any) {
      console.error('Save program error:', err);
      toast.error('Operation Failed', err.message || 'Unable to save program.');
    } finally {
      setSaving(false);
    }
  };

  const handleToggleStatus = async (prog: Program) => {
    try {
      await adminSettingsService.toggleProgramStatus(prog.id, prog.is_active);
      toast.info(
        'Status Updated',
        `${prog.name} is now ${!prog.is_active ? 'Active' : 'Inactive'}.`
      );
      fetchPrograms();
    } catch (err: any) {
      console.error('Toggle status error:', err);
      toast.error('Toggle Failed', err.message);
    }
  };

  return (
    <div className="space-y-6 text-left">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-[#2B2625] tracking-tight font-['Outfit']">
            Academic Programs
          </h1>
          <p className="text-xs sm:text-sm text-[#A8A492] font-medium mt-0.5">
            Configure degree courses and academic tracks available in the registration form.
          </p>
        </div>

        <Button variant="primary" size="sm" onClick={handleOpenAdd} leftIcon={<Plus className="w-4 h-4" />}>
          Add New Program
        </Button>
      </div>

      {/* Programs Card */}
      <Card className="overflow-hidden">
        <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
          <CardTitle className="text-sm font-bold text-[#2B2625]">
            Degree Programs Registry
          </CardTitle>
          <Badge variant="neutral" size="sm">
            {programs.length} Programs
          </Badge>
        </CardHeader>

        <CardContent className="p-0 overflow-x-auto">
          {loading ? (
            <LoadingSpinner message="Loading academic programs..." />
          ) : programs.length === 0 ? (
            <EmptyState
              title="No Programs Configured"
              description="No academic programs found in the database. Add your first program."
              actionLabel="Add Program"
              onAction={handleOpenAdd}
            />
          ) : (
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-[#A8A492]/15 bg-[#FFF7EB]/60 text-[#2B2625] font-bold uppercase tracking-wider text-[10px]">
                  <th className="py-3.5 px-6">Program Name</th>
                  <th className="py-3.5 px-6">Status</th>
                  <th className="py-3.5 px-6">Date Added</th>
                  <th className="py-3.5 px-6 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#A8A492]/10">
                {programs.map((prog) => (
                  <tr key={prog.id} className="hover:bg-[#FFF7EB]/40 transition-colors">
                    <td className="py-3.5 px-6 font-bold text-[#2B2625] text-sm font-['Outfit']">
                      {prog.name}
                    </td>
                    <td className="py-3.5 px-6">
                      <Badge variant={prog.is_active ? 'success' : 'neutral'} size="sm" dot>
                        {prog.is_active ? 'Active' : 'Inactive'}
                      </Badge>
                    </td>
                    <td className="py-3.5 px-6 text-[#A8A492] font-semibold">
                      {new Date(prog.created_at).toLocaleDateString()}
                    </td>
                    <td className="py-3.5 px-6 text-right">
                      <div className="flex items-center justify-end gap-2">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleOpenEdit(prog)}
                          className="h-8 px-2.5 text-xs text-[#2B2625]"
                        >
                          Edit
                        </Button>

                        <Button
                          variant={prog.is_active ? 'outline' : 'primary'}
                          size="sm"
                          onClick={() => handleToggleStatus(prog)}
                          className="h-8 text-xs font-semibold"
                        >
                          {prog.is_active ? 'Deactivate' : 'Activate'}
                        </Button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </CardContent>
      </Card>

      {/* Add / Edit Program Modal */}
      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title={editingProgram ? 'Edit Academic Program' : 'Add New Academic Program'}
        description="Active programs are visible to students during registration."
        maxWidth="md"
      >
        <form onSubmit={handleSave} className="space-y-4 text-left">
          <Input
            label="Program Full Title"
            placeholder="e.g. BS Information Technology"
            value={programName}
            onChange={(e) => setProgramName(e.target.value)}
            required
            autoFocus
          />

          <div className="flex items-center justify-end gap-3 pt-3 border-t border-[#A8A492]/15">
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => setIsModalOpen(false)}
              disabled={saving}
            >
              Cancel
            </Button>
            <Button type="submit" variant="primary" size="sm" isLoading={saving}>
              {editingProgram ? 'Update Program' : 'Create Program'}
            </Button>
          </div>
        </form>
      </Modal>
    </div>
  );
};
