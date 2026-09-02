import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import confetti from 'canvas-confetti';
import { useAuth } from '../../hooks/useAuth';
import { studentService } from '../../services/studentService';
import { storageService } from '../../services/storageService';
import { useToast } from '../../components/ui/Toast';
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from '../../components/ui/Card';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Select } from '../../components/ui/Select';
import { Textarea } from '../../components/ui/Textarea';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { PhotoUpload } from '../../components/forms/PhotoUpload';
import { SignaturePad } from '../../components/forms/SignaturePad';
import { ReviewSummary } from '../../components/forms/ReviewSummary';
import { ArrowRight, ArrowLeft, Save, Check } from 'lucide-react';
import type { Program, EskulturaUnit, YearLevel, Gender } from '../../types/database';
import type { StudentFormData, StudentFormErrors } from '../../types/student';

export const StudentForm: React.FC = () => {
  const { user } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [currentStep, setCurrentStep] = useState<number>(1);

  // Dynamic Options
  const [programs, setPrograms] = useState<Program[]>([]);
  const [units, setUnits] = useState<EskulturaUnit[]>([]);

  // Form State
  const [formData, setFormData] = useState<StudentFormData>({
    surname: '',
    first_name: '',
    middle_initial: '',
    student_number: '',
    program_id: '',
    year_level: '',
    gender: '',
    date_of_birth: '',
    complete_address: '',
    email: user?.email || '',
    contact_number: '',
    facebook_profile: '',
    achievements: 'NONE',
    eskultura_unit_id: '',
    photo_url: null,
    signature_url: null,
  });

  // Local File / Canvas Buffers
  const [photoFile, setPhotoFile] = useState<File | null>(null);
  const [signatureDataUrl, setSignatureDataUrl] = useState<string | null>(null);
  const [errors, setErrors] = useState<StudentFormErrors>({});

  // Dynamic Age calculation from Date of Birth
  const calculatedAge = useMemo(() => {
    if (!formData.date_of_birth) return '';
    const birthDate = new Date(formData.date_of_birth);
    if (isNaN(birthDate.getTime())) return '';
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age >= 0 ? age : '';
  }, [formData.date_of_birth]);

  // Load programs, units, and existing student profile
  useEffect(() => {
    let isMounted = true;

    async function initialize() {
      try {
        setLoading(true);
        const [activePrograms, activeUnits] = await Promise.all([
          studentService.getActivePrograms(),
          studentService.getActiveUnits(),
        ]);

        if (!isMounted) return;
        setPrograms(activePrograms);
        setUnits(activeUnits);

        if (user) {
          const existingProfile = await studentService.getStudentProfile(user.id, user.email || undefined);
          if (existingProfile && isMounted) {
            setFormData({
              surname: existingProfile.surname || '',
              first_name: existingProfile.first_name || '',
              middle_initial: existingProfile.middle_initial || '',
              student_number: existingProfile.student_number || '',
              program_id: existingProfile.program_id || '',
              year_level: existingProfile.year_level || '',
              gender: existingProfile.gender || '',
              date_of_birth: existingProfile.date_of_birth || '',
              complete_address: existingProfile.complete_address || '',
              email: existingProfile.email || user.email || '',
              contact_number: existingProfile.contact_number || '',
              facebook_profile: existingProfile.facebook_profile || '',
              achievements: existingProfile.achievements || 'NONE',
              eskultura_unit_id: existingProfile.eskultura_unit_id || '',
              photo_url: existingProfile.photo_url || null,
              signature_url: existingProfile.signature_url || null,
            });
          }
        }
      } catch (err) {
        console.error('Error initializing form data:', err);
      } finally {
        if (isMounted) setLoading(false);
      }
    }

    initialize();

    return () => {
      isMounted = false;
    };
  }, [user]);

  // Field validation rules
  const validateField = (field: keyof StudentFormData, value: any): string | undefined => {
    switch (field) {
      case 'surname':
        if (!value || !value.trim()) return 'Surname is required.';
        break;
      case 'first_name':
        if (!value || !value.trim()) return 'First name is required.';
        break;
      case 'middle_initial':
        if (!value || !value.trim()) return 'Middle initial is required (e.g. D).';
        if (value.trim().length > 3) return 'Middle initial should be 1-2 characters.';
        break;
      case 'student_number':
        if (!value || !value.trim()) return 'Student number is required.';
        const cleanSN = value.trim().replace(/\s+/g, '');
        if (!/^\d{4}-\d{4}$/.test(cleanSN) && !/^\d{8}$/.test(cleanSN)) {
          return 'Student number must follow format (e.g. 2024-1234 or 0423-4651).';
        }
        break;
      case 'program_id':
        if (!value) return 'Please select your academic degree program.';
        break;
      case 'year_level':
        if (!value) return 'Please select your year level.';
        break;
      case 'gender':
        if (!value) return 'Please select your gender.';
        break;
      case 'date_of_birth':
        if (!value) return 'Date of birth is required.';
        break;
      case 'complete_address':
        if (!value || !value.trim()) return 'Complete residential address is required.';
        break;
      case 'contact_number':
        if (!value || !value.trim()) return 'Contact number is required.';
        const cleanPhone = value.replace(/[\s-]/g, '');
        if (!/^(09|\+639)\d{9}$/.test(cleanPhone)) {
          return 'Please enter a valid Philippine mobile number (09XXXXXXXXX or +639XXXXXXXXX).';
        }
        break;
      case 'facebook_profile':
        if (!value || !value.trim()) return 'Facebook profile link is required.';
        if (!value.includes('facebook.com') && !value.startsWith('http') && value.length < 4) {
          return 'Please provide a valid Facebook profile URL or handle.';
        }
        break;
      case 'eskultura_unit_id':
        if (!value) return 'Please select your preferred ESKULTURA unit.';
        break;
      case 'achievements':
        if (!value || !value.trim()) return 'Please list achievements or write NONE.';
        break;
      default:
        return undefined;
    }
    return undefined;
  };

  const handleInputChange = (field: keyof StudentFormData, value: any) => {
    let sanitizedValue = value;

    if (field === 'surname' || field === 'first_name') {
      sanitizedValue = value;
    } else if (field === 'middle_initial') {
      sanitizedValue = value.toUpperCase().slice(0, 3);
    } else if (field === 'student_number') {
      sanitizedValue = value;
    }

    setFormData((prev) => ({ ...prev, [field]: sanitizedValue }));

    if (errors[field]) {
      setErrors((prev) => ({ ...prev, [field]: undefined }));
    }
  };

  const validateAll = async (): Promise<boolean> => {
    const newErrors: StudentFormErrors = {};
    const fieldsToValidate: (keyof StudentFormData)[] = [
      'surname',
      'first_name',
      'middle_initial',
      'student_number',
      'program_id',
      'year_level',
      'gender',
      'date_of_birth',
      'complete_address',
      'contact_number',
      'facebook_profile',
      'achievements',
      'eskultura_unit_id',
    ];

    fieldsToValidate.forEach((f) => {
      const err = validateField(f, formData[f]);
      if (err) newErrors[f] = err;
    });

    if (!photoFile && !formData.photo_url) {
      newErrors.photo_url = 'Please upload a 1x1 formal picture.';
    }
    if (!signatureDataUrl && !formData.signature_url) {
      newErrors.signature_url = 'Please provide your digital e-signature.';
    }

    if (formData.student_number.trim()) {
      try {
        const isUnique = await studentService.isStudentNumberUnique(
          formData.student_number.trim(),
          user?.id
        );
        if (!isUnique) {
          newErrors.student_number = 'This student number is already registered in the system.';
        }
      } catch (err) {
        console.error('Error checking student number uniqueness:', err);
      }
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleNextStep = async () => {
    if (currentStep === 1) {
      const step1Fields: (keyof StudentFormData)[] = [
        'surname',
        'first_name',
        'middle_initial',
        'student_number',
        'program_id',
        'year_level',
        'gender',
        'date_of_birth',
      ];
      const stepErrors: StudentFormErrors = {};
      step1Fields.forEach((f) => {
        const err = validateField(f, formData[f]);
        if (err) stepErrors[f] = err;
      });

      if (formData.student_number.trim()) {
        const isUnique = await studentService.isStudentNumberUnique(
          formData.student_number.trim(),
          user?.id
        );
        if (!isUnique) {
          stepErrors.student_number = 'This student number is already registered.';
        }
      }

      if (Object.keys(stepErrors).length > 0) {
        setErrors((prev) => ({ ...prev, ...stepErrors }));
        toast.error('Validation Error', 'Please complete all required personal fields.');
        return;
      }
    } else if (currentStep === 2) {
      const step2Fields: (keyof StudentFormData)[] = [
        'complete_address',
        'contact_number',
        'facebook_profile',
      ];
      const stepErrors: StudentFormErrors = {};
      step2Fields.forEach((f) => {
        const err = validateField(f, formData[f]);
        if (err) stepErrors[f] = err;
      });

      if (Object.keys(stepErrors).length > 0) {
        setErrors((prev) => ({ ...prev, ...stepErrors }));
        toast.error('Validation Error', 'Please complete all contact details.');
        return;
      }
    } else if (currentStep === 3) {
      const step3Fields: (keyof StudentFormData)[] = ['achievements', 'eskultura_unit_id'];
      const stepErrors: StudentFormErrors = {};
      step3Fields.forEach((f) => {
        const err = validateField(f, formData[f]);
        if (err) stepErrors[f] = err;
      });

      if (Object.keys(stepErrors).length > 0) {
        setErrors((prev) => ({ ...prev, ...stepErrors }));
        toast.error('Validation Error', 'Please select an ESKULTURA unit.');
        return;
      }
    } else if (currentStep === 4) {
      const stepErrors: StudentFormErrors = {};
      if (!photoFile && !formData.photo_url) {
        stepErrors.photo_url = 'Please upload a 1x1 formal picture.';
      }
      if (!signatureDataUrl && !formData.signature_url) {
        stepErrors.signature_url = 'Please provide your e-signature.';
      }

      if (Object.keys(stepErrors).length > 0) {
        setErrors((prev) => ({ ...prev, ...stepErrors }));
        toast.error('Validation Error', 'Please upload your photo and e-signature.');
        return;
      }
    }

    setCurrentStep((prev) => Math.min(prev + 1, 5));
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handlePrevStep = () => {
    setCurrentStep((prev) => Math.max(prev - 1, 1));
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  // Save Draft
  const handleSaveDraft = async () => {
    if (!user) return;
    try {
      setSubmitting(true);
      await studentService.saveStudentProfile(user.id, formData, 'draft');
      toast.info('Draft Saved', 'Your progress has been saved.');
    } catch (err: any) {
      console.error('Save draft error:', err);
      const msg = err.message || 'Unable to save draft.';
      if (
        msg.toLowerCase().includes('student number') ||
        msg.toLowerCase().includes('duplicate') ||
        msg.toLowerCase().includes('already registered')
      ) {
        setErrors((prev) => ({ ...prev, student_number: msg }));
        setCurrentStep(1);
        window.scrollTo({ top: 0, behavior: 'smooth' });
        toast.error('Student Number Already Registered', msg);
      } else {
        toast.error('Save Failed', msg);
      }
    } finally {
      setSubmitting(false);
    }
  };

  // Final Submit
  const handleFinalSubmit = async () => {
    if (!user) return;

    const isValid = await validateAll();
    if (!isValid) {
      toast.error('Submission Incomplete', 'Please fix all highlighted errors before submitting.');
      return;
    }

    try {
      setSubmitting(true);

      let finalPhotoUrl = formData.photo_url;
      let finalSignatureUrl = formData.signature_url;

      if (photoFile) {
        finalPhotoUrl = await storageService.uploadPhoto(user.id, photoFile);
      }

      if (signatureDataUrl && signatureDataUrl.startsWith('data:image')) {
        finalSignatureUrl = await storageService.uploadSignature(user.id, signatureDataUrl);
      }

      const updatedFormData: StudentFormData = {
        ...formData,
        photo_url: finalPhotoUrl,
        signature_url: finalSignatureUrl,
      };

      await studentService.saveStudentProfile(user.id, updatedFormData, 'submitted');

      confetti({
        particleCount: 120,
        spread: 70,
        origin: { y: 0.6 },
      });

      toast.success(
        'Submission Successful!',
        'Your ESKULTURA membership information has been successfully submitted.'
      );

      navigate('/student/dashboard', { replace: true });
    } catch (err: any) {
      console.error('Final submit error:', err);
      const msg = err.message || 'Unable to submit your application.';
      if (
        msg.toLowerCase().includes('student number') ||
        msg.toLowerCase().includes('duplicate') ||
        msg.toLowerCase().includes('already registered')
      ) {
        setErrors((prev) => ({ ...prev, student_number: msg }));
        setCurrentStep(1);
        window.scrollTo({ top: 0, behavior: 'smooth' });
        toast.error('Student Number Conflict', msg);
      } else {
        toast.error('Submission Failed', msg);
      }
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading registration form..." size="lg" />;
  }

  const steps = [
    { num: 1, label: 'Personal Info' },
    { num: 2, label: 'Contact Details' },
    { num: 3, label: 'Unit & Awards' },
    { num: 4, label: 'Photo & Signature' },
    { num: 5, label: 'Review & Submit' },
  ];

  return (
    <div className="max-w-4xl mx-auto space-y-8 text-left">
      {/* Header Banner */}
      <div className="bg-[#A56F63] text-white rounded-3xl p-6 sm:p-8 shadow-md text-left relative overflow-hidden">
        <div className="relative z-10">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/15 text-white text-xs font-bold mb-3">
            <span>Official Application</span>
          </div>
          <h2 className="text-2xl sm:text-3xl font-black tracking-tight font-['Outfit']">
            ESKULTURA Membership Registration
          </h2>
          <p className="text-xs sm:text-sm text-white/85 mt-1 max-w-xl font-medium">
            Please provide accurate and verifiable student information to complete your organization membership.
          </p>
        </div>
      </div>

      {/* Minimalist Stepper Navigation */}
      <div className="bg-white rounded-3xl border border-[#A8A492]/20 p-3 sm:p-4 shadow-xs">
        <div className="grid grid-cols-5 gap-1 sm:gap-2">
          {steps.map((step) => {
            const isCompleted = step.num < currentStep;
            const isCurrent = step.num === currentStep;

            return (
              <button
                key={step.num}
                type="button"
                onClick={() => {
                  if (step.num < currentStep) setCurrentStep(step.num);
                }}
                disabled={step.num > currentStep}
                className={`flex flex-col sm:flex-row items-center justify-center gap-2 py-2.5 px-2 rounded-2xl text-xs font-bold transition-all ${
                  isCurrent
                    ? 'bg-[#A56F63] text-white shadow-xs'
                    : isCompleted
                    ? 'bg-[#FFF7EB] text-[#2B2625] hover:bg-[#A56F63]/10 cursor-pointer'
                    : 'bg-transparent text-[#A8A492] opacity-60 cursor-not-allowed'
                }`}
              >
                <span
                  className={`w-6 h-6 rounded-full flex items-center justify-center text-[11px] font-black shrink-0 ${
                    isCurrent
                      ? 'bg-white text-[#A56F63]'
                      : isCompleted
                      ? 'bg-[#A56F63] text-white'
                      : 'bg-[#A8A492]/20 text-[#A8A492]'
                  }`}
                >
                  {isCompleted ? <Check className="w-3.5 h-3.5 stroke-[3]" /> : step.num}
                </span>
                <span className="hidden sm:inline truncate">{step.label}</span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Main Form Content Container */}
      <Card className="overflow-hidden">
        {/* STEP 1: Personal Information */}
        {currentStep === 1 && (
          <div>
            <CardHeader className="bg-[#FFF7EB]/40">
              <CardTitle className="text-base font-black font-['Outfit']">
                1. Personal Information
              </CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                Official student identity details as enrolled in the university.
              </p>
            </CardHeader>

            <CardContent className="p-6 sm:p-8 space-y-6">
              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <Input
                  label="Surname"
                  placeholder="e.g. Dela Cruz"
                  value={formData.surname}
                  onChange={(e) => handleInputChange('surname', e.target.value)}
                  error={errors.surname}
                  required
                />
                <Input
                  label="First Name"
                  placeholder="e.g. Juan"
                  value={formData.first_name}
                  onChange={(e) => handleInputChange('first_name', e.target.value)}
                  error={errors.first_name}
                  required
                />
                <Input
                  label="Middle Initial"
                  placeholder="e.g. P."
                  value={formData.middle_initial}
                  onChange={(e) => handleInputChange('middle_initial', e.target.value)}
                  error={errors.middle_initial}
                  helperText="Initial only (e.g. P)"
                  required
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <Input
                  label="Student Number"
                  placeholder="e.g. 0423-4651 or 2024-1234"
                  value={formData.student_number}
                  onChange={(e) => handleInputChange('student_number', e.target.value)}
                  error={errors.student_number}
                  helperText="Official university student identification number."
                  required
                />

                <Select
                  label="Academic Program"
                  placeholder="Select Academic Program"
                  value={formData.program_id}
                  onChange={(e) => handleInputChange('program_id', e.target.value)}
                  options={programs.map((p) => ({ value: p.id, label: p.name }))}
                  error={errors.program_id}
                  required
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                <Select
                  label="Year Level"
                  placeholder="Select Year Level"
                  value={formData.year_level}
                  onChange={(e) => handleInputChange('year_level', e.target.value as YearLevel)}
                  options={[
                    { value: 'First Year', label: 'First Year' },
                    { value: 'Second Year', label: 'Second Year' },
                    { value: 'Third Year', label: 'Third Year' },
                    { value: 'Fourth Year', label: 'Fourth Year' },
                  ]}
                  error={errors.year_level}
                  required
                />

                <Select
                  label="Gender"
                  placeholder="Select Gender"
                  value={formData.gender}
                  onChange={(e) => handleInputChange('gender', e.target.value as Gender)}
                  options={[
                    { value: 'Male', label: 'Male' },
                    { value: 'Female', label: 'Female' },
                    { value: 'Prefer not to say', label: 'Prefer not to say' },
                  ]}
                  error={errors.gender}
                  required
                />

                <div className="space-y-1.5">
                  <Input
                    label="Date of Birth"
                    type="date"
                    value={formData.date_of_birth}
                    onChange={(e) => handleInputChange('date_of_birth', e.target.value)}
                    error={errors.date_of_birth}
                    required
                  />
                  {calculatedAge !== '' && (
                    <div className="text-right">
                      <span className="text-[11px] font-bold text-[#A56F63] bg-[#FFF7EB] px-2 py-0.5 rounded-md border border-[#A56F63]/25">
                        Age: {calculatedAge} years old
                      </span>
                    </div>
                  )}
                </div>
              </div>
            </CardContent>
          </div>
        )}

        {/* STEP 2: Contact Information */}
        {currentStep === 2 && (
          <div>
            <CardHeader className="bg-[#FFF7EB]/40">
              <CardTitle className="text-base font-black font-['Outfit']">
                2. Contact Information
              </CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                How the organization coordinators can reach you for rehearsals and updates.
              </p>
            </CardHeader>

            <CardContent className="p-6 sm:p-8 space-y-6">
              <Textarea
                label="Complete Residential Address"
                placeholder="House/Unit No., Street, Barangay, City/Municipality, Province"
                value={formData.complete_address}
                onChange={(e) => handleInputChange('complete_address', e.target.value)}
                error={errors.complete_address}
                rows={3}
                required
              />

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <Input
                  label="Email Address"
                  type="email"
                  value={formData.email}
                  disabled
                  helperText="Linked to your authenticated student account."
                  className="bg-[#FFF7EB]/60 font-semibold cursor-not-allowed"
                />

                <Input
                  label="Contact Number"
                  placeholder="09171234567"
                  value={formData.contact_number}
                  onChange={(e) => handleInputChange('contact_number', e.target.value)}
                  helperText="Format: 09XXXXXXXXX or +639XXXXXXXXX"
                  error={errors.contact_number}
                  required
                />
              </div>

              <Input
                label="Facebook Profile Link"
                placeholder="https://facebook.com/username"
                value={formData.facebook_profile}
                onChange={(e) => handleInputChange('facebook_profile', e.target.value)}
                helperText="Direct Facebook profile URL for organization groups & announcements."
                error={errors.facebook_profile}
                required
              />
            </CardContent>
          </div>
        )}

        {/* STEP 3: Membership & Units */}
        {currentStep === 3 && (
          <div>
            <CardHeader className="bg-[#FFF7EB]/40">
              <CardTitle className="text-base font-black font-['Outfit']">
                3. ESKULTURA Unit & Achievements
              </CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                Choose one of the 5 official ESKULTURA units and list any awards.
              </p>
            </CardHeader>

            <CardContent className="p-6 sm:p-8 space-y-6">
              <div>
                <label className="block text-xs font-bold text-[#2B2625] mb-2">
                  Which ESKULTURA unit would you like to join? <span className="text-[#A56F63]">*</span>
                </label>

                {/* Interactive Card Selection for the 5 Units */}
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 mb-3">
                  {units.map((u) => {
                    const isSelected = formData.eskultura_unit_id === u.id;
                    return (
                      <div
                        key={u.id}
                        onClick={() => handleInputChange('eskultura_unit_id', u.id)}
                        className={`p-4 rounded-2xl border-2 transition-all cursor-pointer text-left ${
                          isSelected
                            ? 'border-[#A56F63] bg-[#FFF7EB] shadow-xs'
                            : 'border-[#A8A492]/25 bg-white hover:border-[#A8A492]'
                        }`}
                      >
                        <div className="flex items-center justify-between mb-1">
                          <span className="text-sm font-black text-[#2B2625] font-['Outfit']">
                            {u.name}
                          </span>
                          <div
                            className={`w-4 h-4 rounded-full border flex items-center justify-center ${
                              isSelected
                                ? 'border-[#A56F63] bg-[#A56F63] text-white'
                                : 'border-[#A8A492]/40'
                            }`}
                          >
                            {isSelected && <span className="w-1.5 h-1.5 rounded-full bg-white" />}
                          </div>
                        </div>
                        <span className="text-[11px] text-[#A8A492] font-semibold">
                          Official Artistic Wing
                        </span>
                      </div>
                    );
                  })}
                </div>
                {errors.eskultura_unit_id && (
                  <p className="text-[11px] font-semibold text-rose-600">{errors.eskultura_unit_id}</p>
                )}
              </div>

              <Textarea
                label="ACHIEVEMENT(S) / AWARD(S) RECEIVED"
                placeholder="List any artistic, choral, academic, or leadership honors received. Write NONE if not applicable."
                value={formData.achievements}
                onChange={(e) => handleInputChange('achievements', e.target.value)}
                helperText="Write NONE if not applicable."
                error={errors.achievements}
                rows={4}
                required
              />
            </CardContent>
          </div>
        )}

        {/* STEP 4: Documents (1x1 Photo & E-Signature) */}
        {currentStep === 4 && (
          <div>
            <CardHeader className="bg-[#FFF7EB]/40">
              <CardTitle className="text-base font-black font-['Outfit']">
                4. Upload 1x1 Photo & E-Signature
              </CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                Provide your 1x1 formal picture and sign the digital declaration.
              </p>
            </CardHeader>

            <CardContent className="p-6 sm:p-8 space-y-8">
              <PhotoUpload
                currentPhotoUrl={formData.photo_url}
                onPhotoSelected={(file) => {
                  setPhotoFile(file);
                  if (errors.photo_url) setErrors((prev) => ({ ...prev, photo_url: undefined }));
                }}
                onPhotoRemoved={() => {
                  setPhotoFile(null);
                  setFormData((prev) => ({ ...prev, photo_url: null }));
                }}
                error={errors.photo_url}
              />

              <SignaturePad
                currentSignatureUrl={formData.signature_url}
                onSaveSignature={(dataUrl) => {
                  setSignatureDataUrl(dataUrl);
                  if (errors.signature_url) setErrors((prev) => ({ ...prev, signature_url: undefined }));
                }}
                onClearSignature={() => {
                  setSignatureDataUrl(null);
                  setFormData((prev) => ({ ...prev, signature_url: null }));
                }}
                error={errors.signature_url}
              />
            </CardContent>
          </div>
        )}

        {/* STEP 5: Review Summary */}
        {currentStep === 5 && (
          <div>
            <CardHeader className="bg-[#FFF7EB]/40">
              <CardTitle className="text-base font-black font-['Outfit']">
                5. Final Verification & Review
              </CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                Please double-check all details below before finalizing your submission.
              </p>
            </CardHeader>

            <CardContent className="p-6 sm:p-8">
              <ReviewSummary
                formData={formData}
                programs={programs}
                units={units}
                photoPreviewUrl={photoFile ? URL.createObjectURL(photoFile) : formData.photo_url}
                signaturePreviewUrl={signatureDataUrl || formData.signature_url}
                onEditSection={(stepNum) => {
                  setCurrentStep(stepNum);
                  window.scrollTo({ top: 0, behavior: 'smooth' });
                }}
              />
            </CardContent>
          </div>
        )}

        {/* Footer Step Controls */}
        <CardFooter className="flex flex-col sm:flex-row items-center justify-between gap-4">
          <div>
            {currentStep > 1 && (
              <Button
                variant="outline"
                size="sm"
                onClick={handlePrevStep}
                disabled={submitting}
                leftIcon={<ArrowLeft className="w-4 h-4" />}
              >
                Previous Step
              </Button>
            )}
          </div>

          <div className="flex items-center gap-3 w-full sm:w-auto justify-end">
            <Button
              variant="outline"
              size="sm"
              onClick={handleSaveDraft}
              isLoading={submitting}
              leftIcon={<Save className="w-4 h-4" />}
            >
              Save Draft
            </Button>

            {currentStep < 5 ? (
              <Button
                variant="primary"
                size="sm"
                onClick={handleNextStep}
                rightIcon={<ArrowRight className="w-4 h-4" />}
              >
                Continue to Step {currentStep + 1}
              </Button>
            ) : (
              <Button
                variant="primary"
                size="lg"
                onClick={handleFinalSubmit}
                isLoading={submitting}
                className="font-bold shadow-md"
              >
                Confirm & Submit Application
              </Button>
            )}
          </div>
        </CardFooter>
      </Card>
    </div>
  );
};
