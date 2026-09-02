import React from 'react';
import { Link } from 'react-router-dom';
import { useStudentProfile } from '../../hooks/useStudentProfile';
import { useAuth } from '../../hooks/useAuth';
import { Button } from '../../components/ui/Button';
import { Badge } from '../../components/ui/Badge';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { EmptyState } from '../../components/ui/EmptyState';
import { Printer, Edit3, ArrowLeft } from 'lucide-react';

export const StudentProfile: React.FC = () => {
  const { user } = useAuth();
  const { profile, loading } = useStudentProfile();

  const handlePrint = () => {
    window.print();
  };

  if (loading) {
    return <LoadingSpinner message="Loading your membership profile..." size="lg" />;
  }

  if (!profile) {
    return (
      <EmptyState
        title="No Membership Profile Found"
        description="You have not completed your ESKULTURA membership registration form yet."
        actionLabel="Complete Registration Now"
        onAction={() => window.location.assign('/student/edit')}
      />
    );
  }

  const fullName = `${profile.first_name} ${profile.middle_initial ? profile.middle_initial + '.' : ''} ${profile.surname}`.trim();

  let age = 'N/A';
  if (profile.date_of_birth) {
    const birthDate = new Date(profile.date_of_birth);
    if (!isNaN(birthDate.getTime())) {
      const today = new Date();
      let calculatedAge = today.getFullYear() - birthDate.getFullYear();
      const monthDiff = today.getMonth() - birthDate.getMonth();
      if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        calculatedAge--;
      }
      age = `${calculatedAge} years old`;
    }
  }

  const formatDate = (dateStr: string) => {
    if (!dateStr) return 'N/A';
    try {
      return new Date(dateStr).toLocaleDateString('en-US', {
        month: 'long',
        day: 'numeric',
        year: 'numeric',
      });
    } catch {
      return dateStr;
    }
  };

  return (
    <div className="max-w-4xl mx-auto space-y-6 text-left">
      {/* Top Action Bar (hidden in print) */}
      <div className="no-print flex flex-wrap items-center justify-between gap-4">
        <Link to="/student/dashboard">
          <Button variant="outline" size="sm" leftIcon={<ArrowLeft className="w-4 h-4" />}>
            Back to Dashboard
          </Button>
        </Link>

        <div className="flex items-center gap-3">
          <Button variant="outline" size="sm" onClick={handlePrint} leftIcon={<Printer className="w-4 h-4" />}>
            Print Membership Slip
          </Button>
          <Link to="/student/edit">
            <Button variant="primary" size="sm" leftIcon={<Edit3 className="w-4 h-4" />}>
              Edit Information
            </Button>
          </Link>
        </div>
      </div>

      {/* Printable Membership Slip Container */}
      <div className="print-card bg-white rounded-3xl border border-[#A8A492]/25 shadow-lg overflow-hidden p-6 sm:p-10 space-y-8">
        {/* Slip Header */}
        <div className="border-b-2 border-[#2B2625] pb-6 flex flex-col sm:flex-row items-center sm:items-start justify-between gap-6">
          <div className="flex items-center gap-4 text-center sm:text-left">
            <img
              src="/logo.png"
              alt="ESKULTURA"
              className="w-16 h-16 rounded-2xl object-contain border border-[#A8A492]/30 shadow-xs bg-white"
            />
            <div className="space-y-0.5">
              <div className="flex items-center justify-center sm:justify-start gap-2.5">
                <span className="text-2xl font-black tracking-tight text-[#2B2625] font-['Outfit']">
                  ESKULTURA
                </span>
                <span className="text-[10px] uppercase font-bold px-2 py-0.5 rounded-md bg-[#FFF7EB] text-[#A56F63] border border-[#A56F63]/30">
                  Official Member Slip
                </span>
              </div>
              <p className="text-xs text-[#A8A492] font-semibold">
                Student Registration & Membership Data Entry Record
              </p>
              <p className="text-[11px] text-[#A8A492]">
                Issued: {formatDate(profile.created_at)}
              </p>
            </div>
          </div>

          {/* 1x1 Photo Preview */}
          <div className="shrink-0 text-center">
            <div className="w-28 h-28 rounded-2xl border-2 border-[#2B2625] bg-[#FFF7EB] overflow-hidden shadow-xs flex items-center justify-center">
              {profile.photo_url ? (
                <img
                  src={profile.photo_url}
                  alt={fullName}
                  className="w-full h-full object-cover object-center"
                />
              ) : (
                <span className="text-xs font-bold text-[#A8A492]">1x1 Formal Photo</span>
              )}
            </div>
            <span className="text-[10px] text-[#A8A492] font-mono mt-1 block">1x1 Formal ID Photo</span>
          </div>
        </div>

        {/* Member Key Summary */}
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 p-4 rounded-2xl bg-[#FFF7EB]/60 border border-[#A8A492]/20">
          <div>
            <span className="text-[10px] font-bold text-[#A8A492] uppercase tracking-wider block">Student Number</span>
            <span className="text-sm font-mono font-bold text-[#A56F63]">{profile.student_number}</span>
          </div>
          <div>
            <span className="text-[10px] font-bold text-[#A8A492] uppercase tracking-wider block">Year Level</span>
            <span className="text-sm font-bold text-[#2B2625]">{profile.year_level}</span>
          </div>
          <div>
            <span className="text-[10px] font-bold text-[#A8A492] uppercase tracking-wider block">Assigned Unit</span>
            <span className="text-sm font-bold text-[#2B2625]">{profile.eskultura_unit?.name || 'N/A'}</span>
          </div>
          <div>
            <span className="text-[10px] font-bold text-[#A8A492] uppercase tracking-wider block">Membership Status</span>
            <Badge variant={profile.status === 'submitted' ? 'success' : 'warning'} size="sm" dot>
              {profile.status.toUpperCase()}
            </Badge>
          </div>
        </div>

        {/* Section 1: Personal Details */}
        <div className="space-y-3">
          <h4 className="text-xs font-black uppercase tracking-wider text-[#A56F63] border-b border-[#A8A492]/20 pb-2">
            1. Personal Information
          </h4>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-y-3 gap-x-6 text-xs">
            <div>
              <span className="text-[#A8A492] font-medium block">Full Name:</span>
              <span className="text-[#2B2625] font-black text-sm font-['Outfit']">{fullName}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Degree Program:</span>
              <span className="text-[#2B2625] font-bold">{profile.program?.name || 'N/A'}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Gender:</span>
              <span className="text-[#2B2625] font-semibold">{profile.gender}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Date of Birth:</span>
              <span className="text-[#2B2625] font-semibold">{formatDate(profile.date_of_birth)}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Age:</span>
              <span className="text-[#2B2625] font-semibold">{age}</span>
            </div>
          </div>
        </div>

        {/* Section 2: Contact Details */}
        <div className="space-y-3">
          <h4 className="text-xs font-black uppercase tracking-wider text-[#A56F63] border-b border-[#A8A492]/20 pb-2">
            2. Contact Information
          </h4>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-y-3 gap-x-6 text-xs">
            <div>
              <span className="text-[#A8A492] font-medium block">Email Address:</span>
              <span className="text-[#2B2625] font-semibold">{profile.email || user?.email || 'N/A'}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Contact Number:</span>
              <span className="text-[#2B2625] font-mono font-bold">{profile.contact_number}</span>
            </div>
            <div>
              <span className="text-[#A8A492] font-medium block">Facebook Profile:</span>
              <a
                href={profile.facebook_profile}
                target="_blank"
                rel="noreferrer"
                className="text-[#A56F63] hover:underline font-bold truncate block max-w-xs"
              >
                {profile.facebook_profile}
              </a>
            </div>
            <div className="sm:col-span-3">
              <span className="text-[#A8A492] font-medium block mb-0.5">Complete Address:</span>
              <p className="text-[#2B2625] font-semibold bg-[#FFF7EB]/50 p-3 rounded-2xl border border-[#A8A492]/20 leading-relaxed">
                {profile.complete_address}
              </p>
            </div>
          </div>
        </div>

        {/* Section 3: Honors & Achievements */}
        <div className="space-y-3">
          <h4 className="text-xs font-black uppercase tracking-wider text-[#A56F63] border-b border-[#A8A492]/20 pb-2">
            3. Achievements & Awards Received
          </h4>
          <p className="text-[#2B2625] text-xs font-semibold bg-[#FFF7EB]/50 p-3 rounded-2xl border border-[#A8A492]/20 leading-relaxed whitespace-pre-line">
            {profile.achievements || 'NONE'}
          </p>
        </div>

        {/* Section 4: Signature & Declaration */}
        <div className="border-t-2 border-[#2B2625] pt-6 flex flex-col sm:flex-row justify-between items-center sm:items-end gap-6">
          <div className="text-xs text-[#A8A492] max-w-sm text-center sm:text-left leading-relaxed font-medium">
            <p className="font-bold text-[#2B2625] mb-1">Student Declaration:</p>
            I hereby certify that all information provided in this registration form is true, correct, and submitted under my personal volition.
          </div>

          <div className="text-center">
            <div className="w-48 h-20 bg-white border border-[#A8A492]/30 rounded-2xl p-1 flex items-center justify-center shadow-inner mb-1">
              {profile.signature_url ? (
                <img
                  src={profile.signature_url}
                  alt="Student Signature"
                  className="max-h-full max-w-full object-contain"
                />
              ) : (
                <span className="text-xs text-[#A8A492] italic">No signature on file</span>
              )}
            </div>
            <span className="text-xs font-bold text-[#2B2625] block font-['Outfit']">{fullName}</span>
            <span className="text-[10px] text-[#A8A492] font-semibold block">Member Signature over Printed Name</span>
          </div>
        </div>
      </div>
    </div>
  );
};
