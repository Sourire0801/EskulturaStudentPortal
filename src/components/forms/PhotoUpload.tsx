import React, { useState, useRef, useEffect } from 'react';
import { Upload, X, RefreshCw, AlertCircle, Camera } from 'lucide-react';
import { Button } from '../ui/Button';

export interface PhotoUploadProps {
  currentPhotoUrl?: string | null;
  onPhotoSelected: (file: File | null) => void;
  onPhotoRemoved?: () => void;
  error?: string;
  disabled?: boolean;
}

export const PhotoUpload: React.FC<PhotoUploadProps> = ({
  currentPhotoUrl,
  onPhotoSelected,
  onPhotoRemoved,
  error,
  disabled = false,
}) => {
  const [previewUrl, setPreviewUrl] = useState<string | null>(currentPhotoUrl || null);
  const [isDragging, setIsDragging] = useState(false);
  const [validationError, setValidationError] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    setPreviewUrl(currentPhotoUrl || null);
  }, [currentPhotoUrl]);

  const handleFile = (file: File) => {
    setValidationError(null);

    const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];
    if (!validTypes.includes(file.type)) {
      setValidationError('Please select a valid JPG, JPEG, PNG, or WEBP image.');
      return;
    }

    const maxSize = 5 * 1024 * 1024;
    if (file.size > maxSize) {
      setValidationError('Image size must be less than 5MB.');
      return;
    }

    const reader = new FileReader();
    reader.onloadend = () => {
      setPreviewUrl(reader.result as string);
    };
    reader.readAsDataURL(file);

    onPhotoSelected(file);
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    if (!disabled) setIsDragging(true);
  };

  const handleDragLeave = () => {
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    if (disabled) return;

    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      handleFile(e.dataTransfer.files[0]);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      handleFile(e.target.files[0]);
    }
  };

  const handleRemove = () => {
    setPreviewUrl(null);
    setValidationError(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
    onPhotoSelected(null);
    onPhotoRemoved?.();
  };

  const handleTriggerInput = () => {
    if (!disabled && fileInputRef.current) {
      fileInputRef.current.click();
    }
  };

  return (
    <div className="w-full text-left space-y-2">
      <label className="block text-xs font-bold text-[#2B2625] tracking-tight">
        1x1 Formal Picture <span className="text-[#A56F63]">*</span>
      </label>

      <input
        type="file"
        ref={fileInputRef}
        onChange={handleInputChange}
        accept="image/jpeg,image/jpg,image/png,image/webp"
        className="hidden"
        disabled={disabled}
      />

      <div className="flex flex-col sm:flex-row items-center gap-6 p-5 sm:p-6 bg-[#FFF7EB]/50 rounded-3xl border border-[#A8A492]/25">
        {/* Photo Box (1:1 Ratio) */}
        <div className="relative group shrink-0">
          <div
            className={`w-36 h-36 sm:w-40 sm:h-40 rounded-2xl overflow-hidden border-2 bg-white flex items-center justify-center shadow-inner transition-all ${
              previewUrl
                ? 'border-[#A56F63] ring-4 ring-[#A56F63]/10'
                : isDragging
                ? 'border-[#A56F63] bg-[#FFF7EB]'
                : 'border-dashed border-[#A8A492]/40 hover:border-[#A8A492]'
            }`}
          >
            {previewUrl ? (
              <img
                src={previewUrl}
                alt="1x1 Formal Preview"
                className="w-full h-full object-cover object-center"
              />
            ) : (
              <div className="text-center p-3">
                <Camera className="w-8 h-8 text-[#A8A492]/60 mx-auto mb-1.5" />
                <span className="text-xs font-black text-[#2B2625] font-['Outfit'] block">1x1 Photo</span>
                <p className="text-[10px] text-[#A8A492] mt-0.5 font-medium">Plain background</p>
              </div>
            )}
          </div>

          {previewUrl && !disabled && (
            <button
              type="button"
              onClick={handleRemove}
              className="absolute -top-2 -right-2 p-1.5 bg-rose-600 text-white rounded-full shadow-md hover:bg-rose-700 transition-transform active:scale-95 cursor-pointer"
              title="Remove photo"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* Upload Controls & Details */}
        <div
          onDragOver={handleDragOver}
          onDragLeave={handleDragLeave}
          onDrop={handleDrop}
          className={`flex-1 w-full flex flex-col justify-center rounded-2xl p-4 transition-all text-center sm:text-left ${
            isDragging ? 'bg-[#FFF7EB] border-2 border-dashed border-[#A56F63]' : ''
          }`}
        >
          <h4 className="text-sm font-black text-[#2B2625] font-['Outfit']">
            {previewUrl ? 'Photo Uploaded' : 'Upload 1x1 Formal Picture'}
          </h4>
          <p className="text-xs text-[#A8A492] font-medium mt-1 leading-relaxed">
            Please upload a recent 1x1 formal identification picture with a plain background. JPG, JPEG, or PNG up to 5MB.
          </p>

          <div className="flex flex-wrap items-center justify-center sm:justify-start gap-2.5 mt-4">
            <Button
              type="button"
              variant={previewUrl ? 'outline' : 'primary'}
              size="sm"
              onClick={handleTriggerInput}
              disabled={disabled}
              leftIcon={previewUrl ? <RefreshCw className="w-3.5 h-3.5" /> : <Upload className="w-3.5 h-3.5" />}
            >
              {previewUrl ? 'Change Photo' : 'Choose Photo File'}
            </Button>
            {previewUrl && (
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={handleRemove}
                disabled={disabled}
                className="text-rose-600 hover:bg-rose-50"
              >
                Remove
              </Button>
            )}
          </div>
        </div>
      </div>

      {(validationError || error) && (
        <p className="text-xs text-rose-600 font-medium flex items-center gap-1 mt-1">
          <AlertCircle className="w-3.5 h-3.5 shrink-0" />
          {validationError || error}
        </p>
      )}
    </div>
  );
};
