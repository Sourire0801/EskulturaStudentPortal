import React from 'react';
import { Card, CardHeader, CardTitle, CardContent } from '../ui/Card';
import { Badge } from '../ui/Badge';
import { Button } from '../ui/Button';
import type { StudentFormData } from '../../types/student';
import type { Program, EskulturaUnit } from '../../types/database';

export interface ReviewSummaryProps {
  formData: StudentFormData;
  programs: Program[];
  units: EskulturaUnit[];
  photoPreviewUrl?: string | null;
  signaturePreviewUrl?: string | null;
  onEditSection?: (stepNum: number) => void;
}

export const ReviewSummary: React.FC<ReviewSummaryProps> = ({
  formData,
  programs,
  units,
  photoPreviewUrl,
  signaturePreviewUrl,
  onEditSection,
}) => {
  const selectedProgram = programs.find((p) => p.id === formData.program_id)?.name || 'Not selected';
  const selectedUnit = units.find((u) => u.id === formData.eskultura_unit_id)?.name || 'Not selected';
  const fullName = `${formData.first_name} ${formData.middle_initial ? formData.middle_initial + '.' : ''} ${formData.surname}`.trim();

  const formatDate = (dateStr: string) => {
    if (!dateStr) return 'N/A';
    try {
      const d = new Date(dateStr);
      return d.toLocaleDateString('en-US', {
        month: 'long',
        day: 'numeric',
        year: 'numeric',
      });
    } catch {
      return dateStr;
    }
  };

  return (
    <div className="space-y-6 text-left">
      <div className="bg-[#FFF7EB]/80 border border-[#A8A492]/25 rounded-3xl p-5 flex items-start justify-between gap-4">
        <div>
          <h4 className="text-base font-black text-[#2B2625] font-['Outfit']">
            Review Your Membership Information
          </h4>
          <p className="text-xs text-[#A8A492] font-medium mt-0.5">
            Please carefully review all the details you provided before submitting your official ESKULTURA membership application.
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Personal Information */}
        <Card>
          <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
            <CardTitle className="text-xs uppercase tracking-wider font-bold text-[#A56F63]">
              1. Personal Information
            </CardTitle>
            {onEditSection && (
              <Button variant="ghost" size="sm" onClick={() => onEditSection(1)} className="text-xs">
                Edit
              </Button>
            )}
          </CardHeader>
          <CardContent className="p-5 space-y-3.5 text-xs">
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Complete Name:</span>
              <span className="text-[#2B2625] font-bold text-sm text-right font-['Outfit']">{fullName || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Student Number:</span>
              <span className="text-[#A56F63] font-mono font-bold">{formData.student_number || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Program:</span>
              <span className="text-[#2B2625] font-semibold text-right max-w-[200px] truncate">{selectedProgram}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Year Level:</span>
              <span className="text-[#2B2625] font-semibold">{formData.year_level || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Gender:</span>
              <span className="text-[#2B2625] font-semibold">{formData.gender || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline">
              <span className="text-[#A8A492] font-medium">Date of Birth:</span>
              <span className="text-[#2B2625] font-semibold">{formatDate(formData.date_of_birth)}</span>
            </div>
          </CardContent>
        </Card>

        {/* Contact Information */}
        <Card>
          <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
            <CardTitle className="text-xs uppercase tracking-wider font-bold text-[#A56F63]">
              2. Contact Information
            </CardTitle>
            {onEditSection && (
              <Button variant="ghost" size="sm" onClick={() => onEditSection(2)} className="text-xs">
                Edit
              </Button>
            )}
          </CardHeader>
          <CardContent className="p-5 space-y-3.5 text-xs">
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Email:</span>
              <span className="text-[#2B2625] font-semibold">{formData.email || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Mobile:</span>
              <span className="text-[#2B2625] font-mono font-bold">{formData.contact_number || 'N/A'}</span>
            </div>
            <div className="flex justify-between items-baseline border-b border-[#A8A492]/15 pb-2">
              <span className="text-[#A8A492] font-medium">Facebook:</span>
              <a
                href={formData.facebook_profile}
                target="_blank"
                rel="noreferrer"
                className="text-[#A56F63] hover:underline font-bold max-w-[200px] truncate"
              >
                {formData.facebook_profile || 'N/A'}
              </a>
            </div>
            <div className="pt-1">
              <span className="text-[#A8A492] font-medium block mb-1">Complete Address:</span>
              <p className="text-[#2B2625] bg-[#FFF7EB]/50 p-2.5 rounded-2xl border border-[#A8A492]/20 text-xs leading-relaxed font-medium">
                {formData.complete_address || 'N/A'}
              </p>
            </div>
          </CardContent>
        </Card>

        {/* Membership & Achievements */}
        <Card>
          <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
            <CardTitle className="text-xs uppercase tracking-wider font-bold text-[#A56F63]">
              3. ESKULTURA Unit
            </CardTitle>
            {onEditSection && (
              <Button variant="ghost" size="sm" onClick={() => onEditSection(3)} className="text-xs">
                Edit
              </Button>
            )}
          </CardHeader>
          <CardContent className="p-5 space-y-3.5 text-xs">
            <div className="flex justify-between items-center border-b border-[#A8A492]/15 pb-3">
              <span className="text-[#A8A492] font-medium">Selected Unit:</span>
              <Badge variant="primary" size="md">
                {selectedUnit}
              </Badge>
            </div>
            <div className="pt-1">
              <span className="text-[#A8A492] font-medium block mb-1">Achievements / Honors:</span>
              <p className="text-[#2B2625] bg-[#FFF7EB]/50 p-2.5 rounded-2xl border border-[#A8A492]/20 text-xs leading-relaxed font-medium whitespace-pre-line">
                {formData.achievements || 'NONE'}
              </p>
            </div>
          </CardContent>
        </Card>

        {/* Documents */}
        <Card>
          <CardHeader className="py-3.5 flex items-center justify-between bg-[#FFF7EB]/40">
            <CardTitle className="text-xs uppercase tracking-wider font-bold text-[#A56F63]">
              4. Documents
            </CardTitle>
            {onEditSection && (
              <Button variant="ghost" size="sm" onClick={() => onEditSection(4)} className="text-xs">
                Edit
              </Button>
            )}
          </CardHeader>
          <CardContent className="p-5 space-y-4 text-xs">
            <div className="flex items-center justify-between border-b border-[#A8A492]/15 pb-3">
              <div className="flex items-center gap-3">
                {photoPreviewUrl || formData.photo_url ? (
                  <img
                    src={photoPreviewUrl || formData.photo_url || ''}
                    alt="Photo preview"
                    className="w-12 h-12 rounded-xl object-cover border border-[#A8A492]/30 shadow-xs"
                  />
                ) : (
                  <div className="w-12 h-12 bg-[#FFF7EB] rounded-xl flex items-center justify-center text-[#A8A492] font-bold">
                    ✕
                  </div>
                )}
                <div>
                  <h5 className="font-bold text-[#2B2625]">1x1 Formal Picture</h5>
                  <span className="text-[11px] text-[#A8A492]">Official membership ID photo</span>
                </div>
              </div>
              <Badge variant={photoPreviewUrl || formData.photo_url ? 'success' : 'danger'} size="sm" dot>
                {photoPreviewUrl || formData.photo_url ? 'Uploaded' : 'Missing'}
              </Badge>
            </div>

            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                {signaturePreviewUrl || formData.signature_url ? (
                  <div className="w-20 h-10 bg-white rounded-lg border border-[#A8A492]/30 flex items-center justify-center p-1 shadow-xs">
                    <img
                      src={signaturePreviewUrl || formData.signature_url || ''}
                      alt="Signature preview"
                      className="max-h-full max-w-full object-contain"
                    />
                  </div>
                ) : (
                  <div className="w-12 h-12 bg-[#FFF7EB] rounded-xl flex items-center justify-center text-[#A8A492] font-bold">
                    ✕
                  </div>
                )}
                <div>
                  <h5 className="font-bold text-[#2B2625]">Electronic Signature</h5>
                  <span className="text-[11px] text-[#A8A492]">Official digital sign-off</span>
                </div>
              </div>
              <Badge variant={signaturePreviewUrl || formData.signature_url ? 'success' : 'danger'} size="sm" dot>
                {signaturePreviewUrl || formData.signature_url ? 'Completed' : 'Missing'}
              </Badge>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};
