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
import type { EskulturaUnit } from '../../types/database';

export const EskulturaUnits: React.FC = () => {
  const toast = useToast();
  const [units, setUnits] = useState<EskulturaUnit[]>([]);
  const [loading, setLoading] = useState(true);

  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingUnit, setEditingUnit] = useState<EskulturaUnit | null>(null);
  const [unitName, setUnitName] = useState('');
  const [saving, setSaving] = useState(false);

  const fetchUnits = useCallback(async () => {
    try {
      setLoading(true);
      const data = await adminSettingsService.getUnits(true);
      setUnits(data);
    } catch (err: any) {
      console.error('Error loading units:', err);
      toast.error('Failed to load units', err.message);
    } finally {
      setLoading(false);
    }
  }, [toast]);

  useEffect(() => {
    fetchUnits();
  }, [fetchUnits]);

  const handleOpenAdd = () => {
    setEditingUnit(null);
    setUnitName('');
    setIsModalOpen(true);
  };

  const handleOpenEdit = (unit: EskulturaUnit) => {
    setEditingUnit(unit);
    setUnitName(unit.name);
    setIsModalOpen(true);
  };

  const handleSave = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!unitName.trim()) {
      toast.error('Validation Error', 'Unit name cannot be empty.');
      return;
    }

    try {
      setSaving(true);
      if (editingUnit) {
        await adminSettingsService.updateUnit(editingUnit.id, {
          name: unitName.trim(),
        });
        toast.success('Unit Updated', 'ESKULTURA unit updated successfully.');
      } else {
        await adminSettingsService.createUnit(unitName.trim());
        toast.success('Unit Added', 'New ESKULTURA unit created.');
      }
      setIsModalOpen(false);
      fetchUnits();
    } catch (err: any) {
      console.error('Save unit error:', err);
      toast.error('Operation Failed', err.message || 'Unable to save unit.');
    } finally {
      setSaving(false);
    }
  };

  const handleToggleStatus = async (unit: EskulturaUnit) => {
    try {
      await adminSettingsService.toggleUnitStatus(unit.id, unit.is_active);
      toast.info(
        'Status Updated',
        `${unit.name} is now ${!unit.is_active ? 'Active' : 'Inactive'}.`
      );
      fetchUnits();
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
            ESKULTURA Units
          </h1>
          <p className="text-xs sm:text-sm text-[#A8A492] font-medium mt-0.5">
            Configure the 5 official artistic wings and creative units for student membership.
          </p>
        </div>

        <Button variant="primary" size="sm" onClick={handleOpenAdd} leftIcon={<Plus className="w-4 h-4" />}>
          Add New Unit
        </Button>
      </div>

      {/* Units Card */}
      <Card className="overflow-hidden">
        <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
          <CardTitle className="text-sm font-bold text-[#2B2625]">
            Official Units Registry
          </CardTitle>
          <Badge variant="neutral" size="sm">
            {units.length} Units
          </Badge>
        </CardHeader>

        <CardContent className="p-0 overflow-x-auto">
          {loading ? (
            <LoadingSpinner message="Loading ESKULTURA units..." />
          ) : units.length === 0 ? (
            <EmptyState
              title="No Units Configured"
              description="No ESKULTURA units found in the database. Add your first unit."
              actionLabel="Add Unit"
              onAction={handleOpenAdd}
            />
          ) : (
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-[#A8A492]/15 bg-[#FFF7EB]/60 text-[#2B2625] font-bold uppercase tracking-wider text-[10px]">
                  <th className="py-3.5 px-6">Unit Name</th>
                  <th className="py-3.5 px-6">Status</th>
                  <th className="py-3.5 px-6">Date Added</th>
                  <th className="py-3.5 px-6 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#A8A492]/10">
                {units.map((unit) => (
                  <tr key={unit.id} className="hover:bg-[#FFF7EB]/40 transition-colors">
                    <td className="py-3.5 px-6 font-black text-[#2B2625] text-sm font-['Outfit']">
                      {unit.name}
                    </td>
                    <td className="py-3.5 px-6">
                      <Badge variant={unit.is_active ? 'success' : 'neutral'} size="sm" dot>
                        {unit.is_active ? 'Active' : 'Inactive'}
                      </Badge>
                    </td>
                    <td className="py-3.5 px-6 text-[#A8A492] font-semibold">
                      {new Date(unit.created_at).toLocaleDateString()}
                    </td>
                    <td className="py-3.5 px-6 text-right">
                      <div className="flex items-center justify-end gap-2">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleOpenEdit(unit)}
                          className="h-8 px-2.5 text-xs text-[#2B2625]"
                        >
                          Edit
                        </Button>

                        <Button
                          variant={unit.is_active ? 'outline' : 'primary'}
                          size="sm"
                          onClick={() => handleToggleStatus(unit)}
                          className="h-8 text-xs font-semibold"
                        >
                          {unit.is_active ? 'Deactivate' : 'Activate'}
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

      {/* Add / Edit Unit Modal */}
      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title={editingUnit ? 'Edit ESKULTURA Unit' : 'Add New ESKULTURA Unit'}
        description="Active units are available for applicants to join in the registration form."
        maxWidth="md"
      >
        <form onSubmit={handleSave} className="space-y-4 text-left">
          <Input
            label="Unit Title"
            placeholder="e.g. LIKHA ESKULTURA"
            value={unitName}
            onChange={(e) => setUnitName(e.target.value)}
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
              {editingUnit ? 'Update Unit' : 'Create Unit'}
            </Button>
          </div>
        </form>
      </Modal>
    </div>
  );
};
