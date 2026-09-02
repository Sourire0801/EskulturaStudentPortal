import React, { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'react-router-dom';
import { memberService } from '../../services/memberService';
import { studentService } from '../../services/studentService';
import { useToast } from '../../components/ui/Toast';
import { Card, CardHeader, CardTitle, CardContent } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Select } from '../../components/ui/Select';
import { Textarea } from '../../components/ui/Textarea';
import { Badge } from '../../components/ui/Badge';
import { Modal } from '../../components/ui/Modal';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { EmptyState } from '../../components/ui/EmptyState';
import {
  Search,
  Download,
  UploadCloud,
  ChevronLeft,
  ChevronRight,
  Printer,
} from 'lucide-react';
import { ExcelImportModal } from '../../components/admin/ExcelImportModal';
import type { StudentProfile, Program, EskulturaUnit, YearLevel, Gender } from '../../types/database';
import type { MemberFilterOptions } from '../../types/student';

export const Members: React.FC = () => {
  const [searchParams] = useSearchParams();
  const toast = useToast();

  const [members, setMembers] = useState<StudentProfile[]>([]);
  const [totalCount, setTotalCount] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const [exporting, setExporting] = useState(false);
  const [page, setPage] = useState(1);
  const pageSize = 15;

  // Filter Dropdowns Data
  const [programs, setPrograms] = useState<Program[]>([]);
  const [units, setUnits] = useState<EskulturaUnit[]>([]);

  // Filter State
  const [filters, setFilters] = useState<MemberFilterOptions>({
    searchQuery: '',
    programId: '',
    unitId: '',
    yearLevel: '',
    gender: '',
    status: 'all',
    showArchived: false,
  });

  // Modals
  const [selectedMember, setSelectedMember] = useState<StudentProfile | null>(null);
  const [isViewModalOpen, setIsViewModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [isArchiveConfirmOpen, setIsArchiveConfirmOpen] = useState(false);
  const [isImportModalOpen, setIsImportModalOpen] = useState(false);
  const [memberToArchive, setMemberToArchive] = useState<StudentProfile | null>(null);
  const [isArchiving, setIsArchiving] = useState(false);

  // Edit Form State
  const [editFormData, setEditFormData] = useState<Partial<StudentProfile>>({});
  const [isSavingEdit, setIsSavingEdit] = useState(false);

  // Load programs & units
  useEffect(() => {
    async function loadOptions() {
      try {
        const [pData, uData] = await Promise.all([
          studentService.getActivePrograms(),
          studentService.getActiveUnits(),
        ]);
        setPrograms(pData);
        setUnits(uData);
      } catch (err) {
        console.error('Error loading filter options:', err);
      }
    }
    loadOptions();
  }, []);

  // Fetch Members
  const fetchMembers = useCallback(async () => {
    try {
      setLoading(true);
      const res = await memberService.getMembers(filters, page, pageSize);
      setMembers(res.data);
      setTotalCount(res.total);
    } catch (err: any) {
      console.error('Error fetching members:', err);
      toast.error('Failed to load members', err.message);
    } finally {
      setLoading(false);
    }
  }, [filters, page, toast]);

  useEffect(() => {
    fetchMembers();
  }, [fetchMembers]);

  // Check URL params for direct view
  useEffect(() => {
    const viewId = searchParams.get('view');
    if (viewId) {
      memberService.getMemberById(viewId).then((m) => {
        if (m) {
          setSelectedMember(m);
          setIsViewModalOpen(true);
        }
      });
    }
  }, [searchParams]);

  // Handle Filter Change
  const handleFilterChange = (key: keyof MemberFilterOptions, value: any) => {
    setFilters((prev) => ({ ...prev, [key]: value }));
    setPage(1);
  };

  const handleClearFilters = () => {
    setFilters({
      searchQuery: '',
      programId: '',
      unitId: '',
      yearLevel: '',
      gender: '',
      status: 'all',
      showArchived: false,
    });
    setPage(1);
  };

  // CSV Export
  const handleExportCsv = async () => {
    try {
      setExporting(true);
      await memberService.exportMembersToCsv(filters);
      toast.success('Export Complete', 'Member records have been downloaded.');
    } catch (err: any) {
      console.error('Export error:', err);
      toast.error('Export Failed', err.message);
    } finally {
      setExporting(false);
    }
  };

  // Open Edit Modal
  const handleOpenEdit = (member: StudentProfile) => {
    setSelectedMember(member);
    setEditFormData({
      surname: member.surname,
      first_name: member.first_name,
      middle_initial: member.middle_initial,
      student_number: member.student_number,
      program_id: member.program_id,
      year_level: member.year_level,
      gender: member.gender,
      date_of_birth: member.date_of_birth,
      complete_address: member.complete_address,
      contact_number: member.contact_number,
      facebook_profile: member.facebook_profile,
      achievements: member.achievements,
      eskultura_unit_id: member.eskultura_unit_id,
      status: member.status,
    });
    setIsEditModalOpen(true);
  };

  // Save Edit
  const handleSaveEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedMember) return;

    try {
      setIsSavingEdit(true);
      await memberService.updateMember(selectedMember.id, editFormData);
      toast.success('Profile Updated', 'Student member information has been updated.');
      setIsEditModalOpen(false);
      fetchMembers();
    } catch (err: any) {
      console.error('Save edit error:', err);
      toast.error('Update Failed', err.message || 'Unable to save member changes.');
    } finally {
      setIsSavingEdit(false);
    }
  };

  // Archive / Restore Handler
  const handleConfirmArchive = async () => {
    if (!memberToArchive) return;

    try {
      setIsArchiving(true);
      const isArchived = memberToArchive.status === 'archived';

      if (isArchived) {
        await memberService.restoreMember(memberToArchive.id);
        toast.success('Member Restored', `${memberToArchive.first_name} ${memberToArchive.surname} is now active.`);
      } else {
        await memberService.archiveMember(memberToArchive.id);
        toast.info('Member Archived', `${memberToArchive.first_name} ${memberToArchive.surname} has been archived.`);
      }

      setIsArchiveConfirmOpen(false);
      setMemberToArchive(null);
      fetchMembers();
    } catch (err: any) {
      console.error('Archive error:', err);
      toast.error('Operation Failed', err.message);
    } finally {
      setIsArchiving(false);
    }
  };

  const totalPages = Math.ceil(totalCount / pageSize) || 1;

  return (
    <div className="space-y-6 text-left">
      {/* Top Header & Actions */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-[#2B2625] tracking-tight font-['Outfit']">
            Members Directory
          </h1>
          <p className="text-xs sm:text-sm text-[#A8A492] font-medium mt-0.5">
            Manage, search, filter, and import/export student registration records.
          </p>
        </div>

        <div className="flex items-center gap-3">
          <Button
            variant="primary"
            size="sm"
            onClick={() => setIsImportModalOpen(true)}
            leftIcon={<UploadCloud className="w-4 h-4" />}
          >
            Import Excel / CSV
          </Button>

          <Button
            variant="outline"
            size="sm"
            onClick={handleExportCsv}
            isLoading={exporting}
            leftIcon={<Download className="w-4 h-4" />}
          >
            Export CSV
          </Button>
        </div>
      </div>

      {/* Filter and Search Bar Card */}
      <Card className="p-5">
        <div className="space-y-4">
          {/* Search Input */}
          <div className="flex flex-col sm:flex-row items-center gap-3">
            <div className="flex-1 w-full">
              <Input
                placeholder="Search by student name or student number..."
                value={filters.searchQuery}
                onChange={(e) => handleFilterChange('searchQuery', e.target.value)}
                leftIcon={<Search className="w-4 h-4 text-[#A8A492]" />}
              />
            </div>

            <div className="flex items-center gap-2 w-full sm:w-auto">
              <Button
                variant={filters.showArchived ? 'primary' : 'outline'}
                size="sm"
                onClick={() => handleFilterChange('showArchived', !filters.showArchived)}
              >
                {filters.showArchived ? 'Viewing Archived' : 'Show Archived'}
              </Button>

              <Button
                variant="ghost"
                size="sm"
                onClick={handleClearFilters}
              >
                Clear Filters
              </Button>
            </div>
          </div>

          {/* Filter Dropdowns Grid */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 pt-3 border-t border-[#A8A492]/15">
            <Select
              placeholder="All Programs"
              value={filters.programId}
              onChange={(e) => handleFilterChange('programId', e.target.value)}
              options={[
                { value: '', label: 'All Programs' },
                ...programs.map((p) => ({ value: p.id, label: p.name })),
              ]}
            />

            <Select
              placeholder="All Units"
              value={filters.unitId}
              onChange={(e) => handleFilterChange('unitId', e.target.value)}
              options={[
                { value: '', label: 'All ESKULTURA Units' },
                ...units.map((u) => ({ value: u.id, label: u.name })),
              ]}
            />

            <Select
              placeholder="All Year Levels"
              value={filters.yearLevel}
              onChange={(e) => handleFilterChange('yearLevel', e.target.value)}
              options={[
                { value: '', label: 'All Year Levels' },
                { value: 'First Year', label: 'First Year' },
                { value: 'Second Year', label: 'Second Year' },
                { value: 'Third Year', label: 'Third Year' },
                { value: 'Fourth Year', label: 'Fourth Year' },
              ]}
            />

            <Select
              placeholder="All Genders"
              value={filters.gender}
              onChange={(e) => handleFilterChange('gender', e.target.value)}
              options={[
                { value: '', label: 'All Genders' },
                { value: 'Male', label: 'Male' },
                { value: 'Female', label: 'Female' },
                { value: 'Prefer not to say', label: 'Prefer not to say' },
              ]}
            />
          </div>
        </div>
      </Card>

      {/* Members Table Card */}
      <Card className="overflow-hidden">
        <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
          <div className="flex items-center gap-2">
            <CardTitle className="text-sm font-bold text-[#2B2625]">
              Registered Members
            </CardTitle>
            <Badge variant="neutral" size="sm">
              {totalCount} Total
            </Badge>
          </div>
          <span className="text-xs text-[#A8A492] font-semibold">
            Page {page} of {totalPages}
          </span>
        </CardHeader>

        <CardContent className="p-0 overflow-x-auto">
          {loading ? (
            <LoadingSpinner message="Filtering members..." />
          ) : members.length === 0 ? (
            <EmptyState
              title="No Members Found"
              description="No student records match the active search and filter criteria."
              actionLabel="Clear Filters"
              onAction={handleClearFilters}
            />
          ) : (
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-[#A8A492]/15 bg-[#FFF7EB]/60 text-[#2B2625] font-bold uppercase tracking-wider text-[10px]">
                  <th className="py-3.5 px-6">Student Name</th>
                  <th className="py-3.5 px-6">Student #</th>
                  <th className="py-3.5 px-6">Degree Program</th>
                  <th className="py-3.5 px-6">ESKULTURA Unit</th>
                  <th className="py-3.5 px-6">Year</th>
                  <th className="py-3.5 px-6">Gender</th>
                  <th className="py-3.5 px-6">Status</th>
                  <th className="py-3.5 px-6 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#A8A492]/10">
                {members.map((m) => (
                  <tr key={m.id} className="hover:bg-[#FFF7EB]/40 transition-colors">
                    <td className="py-3.5 px-6">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded-xl bg-white border border-[#A8A492]/30 overflow-hidden shrink-0 shadow-2xs flex items-center justify-center font-bold text-[#A56F63]">
                          {m.photo_url ? (
                            <img src={m.photo_url} alt="" className="w-full h-full object-cover" />
                          ) : (
                            m.surname.charAt(0)
                          )}
                        </div>
                        <div>
                          <span className="font-bold text-[#2B2625] block">
                            {m.surname}, {m.first_name} {m.middle_initial ? m.middle_initial + '.' : ''}
                          </span>
                          <span className="text-[11px] text-[#A8A492] block">{m.email || m.profile?.email}</span>
                        </div>
                      </div>
                    </td>
                    <td className="py-3.5 px-6 font-mono font-bold text-[#A56F63]">
                      {m.student_number}
                    </td>
                    <td className="py-3.5 px-6 text-[#2B2625]/80 font-medium truncate max-w-[170px]">
                      {m.program?.name || 'N/A'}
                    </td>
                    <td className="py-3.5 px-6">
                      <Badge variant="primary" size="sm">
                        {m.eskultura_unit?.name || 'N/A'}
                      </Badge>
                    </td>
                    <td className="py-3.5 px-6 text-[#2B2625]/80 font-semibold">{m.year_level}</td>
                    <td className="py-3.5 px-6 text-[#A8A492] font-medium">{m.gender}</td>
                    <td className="py-3.5 px-6">
                      <Badge
                        variant={m.status === 'submitted' ? 'success' : m.status === 'archived' ? 'danger' : 'warning'}
                        size="sm"
                        dot
                      >
                        {m.status.toUpperCase()}
                      </Badge>
                    </td>
                    <td className="py-3.5 px-6 text-right">
                      <div className="flex items-center justify-end gap-1.5">
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => {
                            setSelectedMember(m);
                            setIsViewModalOpen(true);
                          }}
                          className="h-8 px-2.5 text-xs text-[#2B2625]"
                        >
                          View
                        </Button>

                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => handleOpenEdit(m)}
                          className="h-8 px-2.5 text-xs text-[#2B2625]"
                        >
                          Edit
                        </Button>

                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={() => {
                            setMemberToArchive(m);
                            setIsArchiveConfirmOpen(true);
                          }}
                          className="h-8 px-2 text-xs text-[#A8A492] hover:text-rose-600"
                        >
                          {m.status === 'archived' ? 'Restore' : 'Archive'}
                        </Button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </CardContent>

        {/* Pagination Footer */}
        {totalPages > 1 && (
          <div className="p-4 border-t border-[#A8A492]/15 flex items-center justify-between bg-white">
            <span className="text-xs text-[#A8A492] font-semibold">
              Showing {(page - 1) * pageSize + 1} to {Math.min(page * pageSize, totalCount)} of {totalCount} records
            </span>
            <div className="flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setPage((p) => Math.max(p - 1, 1))}
                disabled={page === 1}
                leftIcon={<ChevronLeft className="w-4 h-4" />}
              >
                Previous
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setPage((p) => Math.min(p + 1, totalPages))}
                disabled={page === totalPages}
                rightIcon={<ChevronRight className="w-4 h-4" />}
              >
                Next
              </Button>
            </div>
          </div>
        )}
      </Card>

      {/* ===================== VIEW MEMBER DETAILS MODAL ===================== */}
      {selectedMember && (
        <Modal
          isOpen={isViewModalOpen}
          onClose={() => setIsViewModalOpen(false)}
          title="Member Profile Details"
          description={`Registered record for ${selectedMember.first_name} ${selectedMember.surname}`}
          maxWidth="3xl"
        >
          <div className="space-y-6 text-left">
            {/* Top Slip Summary Header */}
            <div className="p-5 rounded-3xl bg-[#FFF7EB]/60 border border-[#A8A492]/20 flex flex-col sm:flex-row items-center sm:items-start justify-between gap-4">
              <div className="flex items-center gap-4">
                <div className="w-20 h-20 rounded-2xl border border-[#A8A492]/30 bg-white overflow-hidden shrink-0 shadow-xs flex items-center justify-center">
                  {selectedMember.photo_url ? (
                    <img src={selectedMember.photo_url} alt="" className="w-full h-full object-cover" />
                  ) : (
                    <span className="text-xs font-bold text-[#A8A492]">1x1 Photo</span>
                  )}
                </div>
                <div>
                  <h3 className="text-base font-black text-[#2B2625] font-['Outfit']">
                    {selectedMember.surname}, {selectedMember.first_name} {selectedMember.middle_initial ? selectedMember.middle_initial + '.' : ''}
                  </h3>
                  <p className="text-xs font-mono font-bold text-[#A56F63] mt-0.5">
                    Student No: {selectedMember.student_number}
                  </p>
                  <p className="text-xs text-[#A8A492] font-semibold mt-0.5">
                    {selectedMember.program?.name || 'N/A'} • {selectedMember.year_level}
                  </p>
                </div>
              </div>

              <div className="text-right flex flex-col items-end gap-1.5">
                <Badge
                  variant={selectedMember.status === 'submitted' ? 'success' : selectedMember.status === 'archived' ? 'danger' : 'warning'}
                  size="md"
                  dot
                >
                  {selectedMember.status.toUpperCase()}
                </Badge>
                <span className="text-[11px] text-[#A8A492] font-medium">
                  Registered: {new Date(selectedMember.created_at).toLocaleDateString()}
                </span>
              </div>
            </div>

            {/* Sections Grid */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
              {/* Personal Info */}
              <div className="p-4 rounded-2xl border border-[#A8A492]/20 bg-white space-y-2">
                <h5 className="font-bold uppercase tracking-wider text-[#A56F63] border-b border-[#A8A492]/15 pb-1.5">
                  Personal Information
                </h5>
                <div className="space-y-1.5">
                  <p><span className="text-[#A8A492] font-medium">Gender:</span> <strong className="text-[#2B2625]">{selectedMember.gender}</strong></p>
                  <p><span className="text-[#A8A492] font-medium">Date of Birth:</span> <strong className="text-[#2B2625]">{new Date(selectedMember.date_of_birth).toLocaleDateString()}</strong></p>
                  <p><span className="text-[#A8A492] font-medium">Assigned Unit:</span> <strong className="text-[#A56F63]">{selectedMember.eskultura_unit?.name || 'N/A'}</strong></p>
                </div>
              </div>

              {/* Contact Info */}
              <div className="p-4 rounded-2xl border border-[#A8A492]/20 bg-white space-y-2">
                <h5 className="font-bold uppercase tracking-wider text-[#A56F63] border-b border-[#A8A492]/15 pb-1.5">
                  Contact Information
                </h5>
                <div className="space-y-1.5">
                  <p><span className="text-[#A8A492] font-medium">Email:</span> <strong className="text-[#2B2625]">{selectedMember.email || selectedMember.profile?.email || 'N/A'}</strong></p>
                  <p><span className="text-[#A8A492] font-medium">Mobile:</span> <strong className="text-[#2B2625] font-mono">{selectedMember.contact_number}</strong></p>
                  <p className="truncate">
                    <span className="text-[#A8A492] font-medium">Facebook:</span>{' '}
                    <a href={selectedMember.facebook_profile} target="_blank" rel="noreferrer" className="text-[#A56F63] hover:underline font-semibold">
                      {selectedMember.facebook_profile}
                    </a>
                  </p>
                </div>
              </div>

              {/* Address */}
              <div className="sm:col-span-2 p-4 rounded-2xl border border-[#A8A492]/20 bg-white space-y-1.5">
                <span className="font-bold uppercase tracking-wider text-[#A56F63] block">
                  Complete Address
                </span>
                <p className="text-slate-800 leading-relaxed font-medium">{selectedMember.complete_address}</p>
              </div>

              {/* Achievements */}
              <div className="sm:col-span-2 p-4 rounded-2xl border border-[#A8A492]/20 bg-white space-y-1.5">
                <span className="font-bold uppercase tracking-wider text-[#A56F63] block">
                  Achievements / Awards Received
                </span>
                <p className="text-slate-800 leading-relaxed whitespace-pre-line font-medium">
                  {selectedMember.achievements || 'NONE'}
                </p>
              </div>

              {/* E-Signature */}
              <div className="sm:col-span-2 p-4 rounded-2xl border border-[#A8A492]/20 bg-white flex flex-col sm:flex-row items-center justify-between gap-4">
                <div>
                  <span className="font-bold uppercase tracking-wider text-[#A56F63] block">
                    Digital Signature On File
                  </span>
                  <span className="text-[11px] text-[#A8A492]">
                    Verified digital signature of student member
                  </span>
                </div>
                <div className="w-48 h-16 bg-[#FFF7EB] border border-[#A8A492]/25 rounded-xl p-1 flex items-center justify-center">
                  {selectedMember.signature_url ? (
                    <img src={selectedMember.signature_url} alt="Signature" className="max-h-full max-w-full object-contain" />
                  ) : (
                    <span className="text-xs text-[#A8A492] italic">No signature</span>
                  )}
                </div>
              </div>
            </div>

            {/* Modal Actions */}
            <div className="flex items-center justify-between pt-4 border-t border-[#A8A492]/15">
              <Button
                variant="outline"
                size="sm"
                onClick={() => window.print()}
                leftIcon={<Printer className="w-4 h-4" />}
              >
                Print Member Record
              </Button>

              <div className="flex items-center gap-2">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    setIsViewModalOpen(false);
                    handleOpenEdit(selectedMember);
                  }}
                >
                  Edit Information
                </Button>
                <Button variant="primary" size="sm" onClick={() => setIsViewModalOpen(false)}>
                  Close
                </Button>
              </div>
            </div>
          </div>
        </Modal>
      )}

      {/* ===================== EDIT MEMBER MODAL ===================== */}
      {selectedMember && (
        <Modal
          isOpen={isEditModalOpen}
          onClose={() => setIsEditModalOpen(false)}
          title="Edit Member Information"
          description={`Update profile details for ${selectedMember.first_name} ${selectedMember.surname}`}
          maxWidth="2xl"
        >
          <form onSubmit={handleSaveEdit} className="space-y-4 text-left">
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <Input
                label="Surname"
                value={editFormData.surname || ''}
                onChange={(e) => setEditFormData({ ...editFormData, surname: e.target.value })}
                required
              />
              <Input
                label="First Name"
                value={editFormData.first_name || ''}
                onChange={(e) => setEditFormData({ ...editFormData, first_name: e.target.value })}
                required
              />
              <Input
                label="Middle Initial"
                value={editFormData.middle_initial || ''}
                onChange={(e) => setEditFormData({ ...editFormData, middle_initial: e.target.value })}
              />
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <Input
                label="Student Number"
                value={editFormData.student_number || ''}
                onChange={(e) => setEditFormData({ ...editFormData, student_number: e.target.value })}
                required
              />
              <Select
                label="Year Level"
                value={editFormData.year_level || ''}
                onChange={(e) => setEditFormData({ ...editFormData, year_level: e.target.value as YearLevel })}
                options={[
                  { value: 'First Year', label: 'First Year' },
                  { value: 'Second Year', label: 'Second Year' },
                  { value: 'Third Year', label: 'Third Year' },
                  { value: 'Fourth Year', label: 'Fourth Year' },
                ]}
                required
              />
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <Select
                label="Academic Program"
                value={editFormData.program_id || ''}
                onChange={(e) => setEditFormData({ ...editFormData, program_id: e.target.value })}
                options={programs.map((p) => ({ value: p.id, label: p.name }))}
                required
              />
              <Select
                label="ESKULTURA Unit"
                value={editFormData.eskultura_unit_id || ''}
                onChange={(e) => setEditFormData({ ...editFormData, eskultura_unit_id: e.target.value })}
                options={units.map((u) => ({ value: u.id, label: u.name }))}
                required
              />
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <Select
                label="Gender"
                value={editFormData.gender || ''}
                onChange={(e) => setEditFormData({ ...editFormData, gender: e.target.value as Gender })}
                options={[
                  { value: 'Male', label: 'Male' },
                  { value: 'Female', label: 'Female' },
                  { value: 'Prefer not to say', label: 'Prefer not to say' },
                ]}
                required
              />
              <Input
                label="Contact Number"
                value={editFormData.contact_number || ''}
                onChange={(e) => setEditFormData({ ...editFormData, contact_number: e.target.value })}
                required
              />
            </div>

            <Input
              label="Facebook Profile URL"
              value={editFormData.facebook_profile || ''}
              onChange={(e) => setEditFormData({ ...editFormData, facebook_profile: e.target.value })}
              required
            />

            <Textarea
              label="Complete Residential Address"
              rows={2}
              value={editFormData.complete_address || ''}
              onChange={(e) => setEditFormData({ ...editFormData, complete_address: e.target.value })}
              required
            />

            <Textarea
              label="Achievements & Awards"
              rows={3}
              value={editFormData.achievements || ''}
              onChange={(e) => setEditFormData({ ...editFormData, achievements: e.target.value })}
            />

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-[#A8A492]/15">
              <Button type="button" variant="outline" size="sm" onClick={() => setIsEditModalOpen(false)}>
                Cancel
              </Button>
              <Button type="submit" variant="primary" size="sm" isLoading={isSavingEdit}>
                Save Changes
              </Button>
            </div>
          </form>
        </Modal>
      )}

      {/* ===================== ARCHIVE CONFIRMATION MODAL ===================== */}
      {memberToArchive && (
        <Modal
          isOpen={isArchiveConfirmOpen}
          onClose={() => setIsArchiveConfirmOpen(false)}
          title={memberToArchive.status === 'archived' ? 'Restore Member Record' : 'Archive Member Record'}
          maxWidth="md"
        >
          <div className="space-y-4 text-left">
            <div className="p-4 rounded-2xl bg-[#FFF7EB] border border-[#A8A492]/30 text-xs text-[#2B2625] leading-relaxed">
              <p className="font-bold mb-1">
                {memberToArchive.status === 'archived'
                  ? 'Are you sure you want to restore this member?'
                  : 'Are you sure you want to archive this member?'}
              </p>
              <p className="text-[#A8A492]">
                {memberToArchive.status === 'archived'
                  ? 'Restoring will return this student to the active member registry.'
                  : 'Archived members will no longer appear in the standard active member list, but their records remain securely preserved.'}
              </p>
            </div>

            <div className="p-3 bg-white border border-[#A8A492]/20 rounded-xl text-xs space-y-1">
              <p><span className="text-[#A8A492]">Name:</span> <strong className="text-[#2B2625]">{memberToArchive.surname}, {memberToArchive.first_name}</strong></p>
              <p><span className="text-[#A8A492]">Student No:</span> <strong className="text-[#A56F63] font-mono">{memberToArchive.student_number}</strong></p>
            </div>

            <div className="flex items-center justify-end gap-3 pt-3 border-t border-[#A8A492]/15">
              <Button variant="outline" size="sm" onClick={() => setIsArchiveConfirmOpen(false)} disabled={isArchiving}>
                Cancel
              </Button>
              <Button
                variant={memberToArchive.status === 'archived' ? 'primary' : 'danger'}
                size="sm"
                onClick={handleConfirmArchive}
                isLoading={isArchiving}
              >
                {memberToArchive.status === 'archived' ? 'Yes, Restore Member' : 'Yes, Archive Member'}
              </Button>
            </div>
          </div>
        </Modal>
      )}

      {/* Excel / CSV Bulk Import Modal */}
      <ExcelImportModal
        isOpen={isImportModalOpen}
        onClose={() => setIsImportModalOpen(false)}
        onSuccess={() => {
          fetchMembers();
          studentService.getActivePrograms().then(setPrograms);
          studentService.getActiveUnits().then(setUnits);
        }}
        programs={programs}
        units={units}
      />
    </div>
  );
};
