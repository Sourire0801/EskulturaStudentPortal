import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';
import { useStudentProfile } from '../../hooks/useStudentProfile';
import { Card } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Badge } from '../../components/ui/Badge';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { ArrowRight, Printer, Edit3 } from 'lucide-react';

export const StudentDashboard: React.FC = () => {
  const { user } = useAuth();
  const { profile, loading } = useStudentProfile();

  if (loading) {
    return <LoadingSpinner message="Loading your student portal..." size="lg" />;
  }

  const calculateCompletion = () => {
    if (!profile) return 10;
    let score = 0;
    const totalFields = 11;
    if (profile.surname && profile.first_name) score++;
    if (profile.student_number) score++;
    if (profile.program_id) score++;
    if (profile.year_level) score++;
    if (profile.gender) score++;
    if (profile.date_of_birth) score++;
    if (profile.complete_address) score++;
    if (profile.contact_number) score++;
    if (profile.facebook_profile) score++;
    if (profile.eskultura_unit_id) score++;
    if (profile.photo_url && profile.signature_url) score++;

    return Math.round((score / totalFields) * 100);
  };

  const completionPercentage = calculateCompletion();
  const isSubmitted = profile?.status === 'submitted';
  const isDraft = profile?.status === 'draft';
  const studentName = profile?.first_name ? `${profile.first_name} ${profile.surname}` : user?.email?.split('@')[0] || 'Student';

  return (
    <div className="space-y-8 text-left">
      {/* Welcome Banner */}
      <div className="bg-[#A56F63] text-white rounded-3xl p-6 sm:p-8 shadow-md relative overflow-hidden">
        <div className="relative z-10 max-w-2xl">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/15 text-white text-xs font-bold mb-3">
            <span>Student Membership Record</span>
          </div>
          <h1 className="text-2xl sm:text-4xl font-black tracking-tight font-['Outfit']">
            Welcome, {studentName}!
          </h1>
          <p className="text-xs sm:text-sm text-white/85 mt-2 leading-relaxed font-medium">
            {isSubmitted
              ? 'Your ESKULTURA membership profile is currently submitted and verified.'
              : 'Complete your registration form to finalize your active membership in ESKULTURA.'}
          </p>

          <div className="flex flex-wrap items-center gap-3 mt-6">
            <Link to={isSubmitted ? '/student/profile' : '/student/edit'}>
              <Button
                variant="secondary"
                size="sm"
                className="bg-white text-[#2B2625] hover:bg-[#FFF7EB] font-bold shadow-xs"
                rightIcon={<ArrowRight className="w-4 h-4" />}
              >
                {isSubmitted ? 'View Membership Slip' : 'Complete Information Form'}
              </Button>
            </Link>
            {isSubmitted && (
              <Link to="/student/profile">
                <Button
                  variant="outline"
                  size="sm"
                  className="bg-transparent border-white/40 text-white hover:bg-white/10"
                  leftIcon={<Printer className="w-4 h-4" />}
                >
                  Print Slip
                </Button>
              </Link>
            )}
          </div>
        </div>
      </div>

      {/* Status & Progress Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Membership Status Card */}
        <Card className="p-6">
          <div className="flex items-center justify-between mb-4">
            <span className="text-xs font-bold uppercase tracking-wider text-[#A8A492]">
              Status
            </span>
            <Badge
              variant={isSubmitted ? 'success' : isDraft ? 'warning' : 'neutral'}
              size="md"
              dot
            >
              {isSubmitted ? 'Submitted' : isDraft ? 'Draft' : 'Not Started'}
            </Badge>
          </div>

          <div className="text-xl font-black text-[#2B2625] font-['Outfit'] mb-1">
            {isSubmitted ? 'Application Submitted' : 'Registration Incomplete'}
          </div>
          <p className="text-xs text-[#A8A492] font-medium">
            {isSubmitted ? 'Active ESKULTURA student member' : 'Form completion required'}
          </p>
        </Card>

        {/* Profile Completion Card */}
        <Card className="p-6">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold uppercase tracking-wider text-[#A8A492]">
              Profile Completion
            </span>
            <span className="text-xs font-black text-[#A56F63]">
              {completionPercentage}%
            </span>
          </div>

          <div className="text-2xl font-black text-[#2B2625] mb-3 tracking-tight font-['Outfit']">
            {completionPercentage === 100 ? '100% Completed' : `${completionPercentage}% Progress`}
          </div>

          <div className="w-full h-2.5 bg-[#FFF7EB] border border-[#A8A492]/20 rounded-full overflow-hidden">
            <div
              className="h-full bg-[#A56F63] rounded-full transition-all duration-500"
              style={{ width: `${completionPercentage}%` }}
            />
          </div>
        </Card>

        {/* ESKULTURA Unit Card */}
        <Card className="p-6">
          <div className="flex items-center justify-between mb-4">
            <span className="text-xs font-bold uppercase tracking-wider text-[#A8A492]">
              Assigned Unit
            </span>
            <Badge variant="primary" size="sm">
              Artistic Wing
            </Badge>
          </div>

          <div className="text-lg font-black text-[#2B2625] font-['Outfit'] mb-1">
            {profile?.eskultura_unit?.name || 'Unit Not Selected'}
          </div>
          <p className="text-xs text-[#A8A492] font-medium">
            {profile?.eskultura_unit?.name
              ? 'Official artistic discipline assigned.'
              : 'Select one of the 5 official units in the form.'}
          </p>
        </Card>
      </div>

      {/* Main Action Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card hoverEffect className="p-6 flex flex-col justify-between">
          <div>
            <h3 className="text-lg font-black text-[#2B2625] mb-1 font-['Outfit']">
              Official Membership Slip
            </h3>
            <p className="text-xs text-[#A8A492] font-medium leading-relaxed mb-6">
              View your registered personal details, contact information, uploaded 1x1 photo, and e-signature on the official member record.
            </p>
          </div>

          <Link to="/student/profile">
            <Button variant="outline" size="sm" className="w-full justify-between">
              <span>View Profile Details</span>
              <ArrowRight className="w-4 h-4" />
            </Button>
          </Link>
        </Card>

        <Card hoverEffect className="p-6 flex flex-col justify-between">
          <div>
            <h3 className="text-lg font-black text-[#2B2625] mb-1 font-['Outfit']">
              Edit / Update Information
            </h3>
            <p className="text-xs text-[#A8A492] font-medium leading-relaxed mb-6">
              Update your contact number, address, achievements, or adjust your selected ESKULTURA unit if your details need revision.
            </p>
          </div>

          <Link to="/student/edit">
            <Button variant="outline" size="sm" className="w-full justify-between" leftIcon={<Edit3 className="w-4 h-4 text-[#A56F63]" />}>
              <span>Open Registration Form</span>
              <ArrowRight className="w-4 h-4" />
            </Button>
          </Link>
        </Card>
      </div>
    </div>
  );
};
