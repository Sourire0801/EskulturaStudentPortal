import React, { useRef, useState, useEffect, useCallback } from 'react';
import { Check, RotateCcw, AlertCircle, PenTool, Upload, Image as ImageIcon, X, RefreshCw } from 'lucide-react';
import { Button } from '../ui/Button';

export interface SignaturePadProps {
  currentSignatureUrl?: string | null;
  onSaveSignature: (dataUrl: string | null) => void;
  onClearSignature?: () => void;
  error?: string;
  disabled?: boolean;
}

export const SignaturePad: React.FC<SignaturePadProps> = ({
  currentSignatureUrl,
  onSaveSignature,
  onClearSignature,
  error,
  disabled = false,
}) => {
  const [activeTab, setActiveTab] = useState<'draw' | 'upload'>('draw');
  
  // Canvas State
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [hasDrawn, setHasDrawn] = useState(false);
  const [savedDataUrl, setSavedDataUrl] = useState<string | null>(currentSignatureUrl || null);
  const [isSaved, setIsSaved] = useState(Boolean(currentSignatureUrl));

  // Upload State
  const [uploadedSignatureUrl, setUploadedSignatureUrl] = useState<string | null>(
    currentSignatureUrl && !currentSignatureUrl.startsWith('data:image') ? currentSignatureUrl : null
  );
  const [uploadValidationError, setUploadValidationError] = useState<string | null>(null);
  const [isDragging, setIsDragging] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Sync with prop updates
  useEffect(() => {
    if (currentSignatureUrl) {
      setSavedDataUrl(currentSignatureUrl);
      setIsSaved(true);
    }
  }, [currentSignatureUrl]);

  // Setup Canvas
  const setupCanvas = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const rect = canvas.getBoundingClientRect();
    const dpr = window.devicePixelRatio || 1;

    canvas.width = rect.width * dpr;
    canvas.height = rect.height * dpr;

    const ctx = canvas.getContext('2d');
    if (ctx) {
      ctx.scale(dpr, dpr);
      ctx.lineCap = 'round';
      ctx.lineJoin = 'round';
      ctx.strokeStyle = '#1E1B1A'; // Rich ink
      ctx.lineWidth = 2.5;
    }
  }, []);

  useEffect(() => {
    if (activeTab === 'draw') {
      setupCanvas();
      window.addEventListener('resize', setupCanvas);
      return () => window.removeEventListener('resize', setupCanvas);
    }
  }, [activeTab, setupCanvas]);

  const getCoordinates = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
    const canvas = canvasRef.current;
    if (!canvas) return { x: 0, y: 0 };
    const rect = canvas.getBoundingClientRect();

    if ('touches' in e) {
      const touch = e.touches[0];
      return {
        x: touch.clientX - rect.left,
        y: touch.clientY - rect.top,
      };
    } else {
      return {
        x: e.clientX - rect.left,
        y: e.clientY - rect.top,
      };
    }
  };

  const startDrawing = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
    if (disabled) return;
    if ('touches' in e) {
      e.stopPropagation();
    }
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const { x, y } = getCoordinates(e);
    ctx.beginPath();
    ctx.moveTo(x, y);
    setIsDrawing(true);
    setHasDrawn(true);
    setIsSaved(false);
  };

  const draw = (e: React.MouseEvent<HTMLCanvasElement> | React.TouchEvent<HTMLCanvasElement>) => {
    if (!isDrawing || disabled) return;
    if ('touches' in e) {
      e.preventDefault();
      e.stopPropagation();
    }
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const { x, y } = getCoordinates(e);
    ctx.lineTo(x, y);
    ctx.stroke();
  };

  const stopDrawing = () => {
    if (!isDrawing) return;
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (ctx) {
      ctx.closePath();
    }
    setIsDrawing(false);

    // Auto-save signature data URL on stroke completion for a smooth experience
    const dataUrl = canvas.toDataURL('image/png');
    setSavedDataUrl(dataUrl);
    setIsSaved(true);
    onSaveSignature(dataUrl);
  };

  const handleClearCanvas = () => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (ctx) {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
    setHasDrawn(false);
    setSavedDataUrl(null);
    setIsSaved(false);
    if (onClearSignature) onClearSignature();
  };

  // Upload Handlers
  const handleUploadedFile = (file: File) => {
    setUploadValidationError(null);

    const validTypes = ['image/png', 'image/jpeg', 'image/jpg', 'image/webp'];
    if (!validTypes.includes(file.type)) {
      setUploadValidationError('Please upload a valid PNG, JPG, or WEBP signature image.');
      return;
    }

    if (file.size > 5 * 1024 * 1024) {
      setUploadValidationError('Signature file size must be less than 5MB.');
      return;
    }

    const reader = new FileReader();
    reader.onloadend = () => {
      const result = reader.result as string;
      setUploadedSignatureUrl(result);
      setSavedDataUrl(result);
      setIsSaved(true);
      onSaveSignature(result);
    };
    reader.readAsDataURL(file);
  };

  const handleRemoveUploadedSignature = () => {
    setUploadedSignatureUrl(null);
    setSavedDataUrl(null);
    setIsSaved(false);
    setUploadValidationError(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
    if (onClearSignature) onClearSignature();
  };

  return (
    <div className="w-full text-left space-y-3">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
        <div>
          <label className="block text-xs font-bold text-[#2B2625] tracking-tight">
            E-Signature <span className="text-[#A56F63]">*</span>
          </label>
          <p className="text-[11px] text-[#A8A492] font-medium">
            You can either draw your signature directly or upload a photo of your handwritten signature.
          </p>
        </div>

        {isSaved && (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 bg-emerald-50 text-emerald-800 rounded-full text-xs font-bold border border-emerald-200">
            <Check className="w-3.5 h-3.5 text-emerald-600" /> Signature Ready
          </span>
        )}
      </div>

      {/* Mode Selection Tabs */}
      <div className="flex items-center p-1 bg-[#FFF7EB] rounded-2xl border border-[#A8A492]/25 w-fit">
        <button
          type="button"
          onClick={() => setActiveTab('draw')}
          className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all cursor-pointer ${
            activeTab === 'draw'
              ? 'bg-white text-[#2B2625] shadow-xs border border-[#A8A492]/20'
              : 'text-[#A8A492] hover:text-[#2B2625]'
          }`}
        >
          <PenTool className="w-3.5 h-3.5" />
          <span>Draw Signature</span>
        </button>

        <button
          type="button"
          onClick={() => setActiveTab('upload')}
          className={`flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold transition-all cursor-pointer ${
            activeTab === 'upload'
              ? 'bg-white text-[#2B2625] shadow-xs border border-[#A8A492]/20'
              : 'text-[#A8A492] hover:text-[#2B2625]'
          }`}
        >
          <Upload className="w-3.5 h-3.5" />
          <span>Upload Signature Photo</span>
        </button>
      </div>

      {/* DRAW TAB */}
      {activeTab === 'draw' && (
        <div className="bg-[#FFF7EB]/50 rounded-3xl border border-[#A8A492]/25 p-4 sm:p-5 space-y-3">
          <div className="relative bg-white rounded-2xl border border-[#A8A492]/30 shadow-inner overflow-hidden">
            <canvas
              ref={canvasRef}
              onMouseDown={startDrawing}
              onMouseMove={draw}
              onMouseUp={stopDrawing}
              onMouseLeave={stopDrawing}
              onTouchStart={startDrawing}
              onTouchMove={draw}
              onTouchEnd={stopDrawing}
              className={`w-full h-44 sm:h-48 block touch-none cursor-crosshair ${
                disabled ? 'pointer-events-none opacity-60' : ''
              }`}
            />

            {/* Guide Baseline */}
            <div className="absolute bottom-6 left-8 right-8 border-b border-dashed border-[#A8A492]/30 pointer-events-none flex justify-between">
              <span className="text-[10px] text-[#A8A492] select-none uppercase font-mono">Sign on the line</span>
              <span className="text-[10px] text-[#A8A492] select-none font-mono">✕</span>
            </div>

            {!hasDrawn && !savedDataUrl && (
              <div className="absolute inset-0 flex items-center justify-center pointer-events-none text-[#A8A492] text-xs font-medium">
                Draw your signature here with mouse, touch, or stylus
              </div>
            )}
          </div>

          <div className="flex flex-wrap items-center justify-between gap-2">
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={handleClearCanvas}
              disabled={disabled || (!hasDrawn && !savedDataUrl)}
              leftIcon={<RotateCcw className="w-3.5 h-3.5" />}
            >
              Clear Signature Pad
            </Button>

            <span className="text-[11px] text-[#A8A492] font-medium hidden sm:inline">
              Signature automatically saves as you draw
            </span>
          </div>
        </div>
      )}

      {/* UPLOAD TAB */}
      {activeTab === 'upload' && (
        <div className="bg-[#FFF7EB]/50 rounded-3xl border border-[#A8A492]/25 p-5 sm:p-6 space-y-4">
          <input
            type="file"
            ref={fileInputRef}
            onChange={(e) => {
              if (e.target.files && e.target.files[0]) {
                handleUploadedFile(e.target.files[0]);
              }
            }}
            accept="image/png,image/jpeg,image/jpg,image/webp"
            className="hidden"
            disabled={disabled}
          />

          <div className="flex flex-col sm:flex-row items-center gap-6">
            {/* Signature Preview Box */}
            <div className="relative group shrink-0">
              <div
                className={`w-48 sm:w-56 h-32 rounded-2xl overflow-hidden border-2 bg-white flex items-center justify-center shadow-inner p-3 transition-all ${
                  uploadedSignatureUrl || (savedDataUrl && activeTab === 'upload')
                    ? 'border-[#A56F63] ring-4 ring-[#A56F63]/10'
                    : isDragging
                    ? 'border-[#A56F63] bg-[#FFF7EB]'
                    : 'border-dashed border-[#A8A492]/40 hover:border-[#A8A492]'
                }`}
              >
                {uploadedSignatureUrl || (savedDataUrl && activeTab === 'upload') ? (
                  <img
                    src={uploadedSignatureUrl || savedDataUrl || ''}
                    alt="E-Signature Preview"
                    className="max-h-full max-w-full object-contain"
                  />
                ) : (
                  <div className="text-center p-2">
                    <ImageIcon className="w-7 h-7 text-[#A8A492]/60 mx-auto mb-1" />
                    <span className="text-xs font-bold text-[#2B2625] block">Signature Photo</span>
                    <p className="text-[10px] text-[#A8A492] mt-0.5">PNG or clean white background</p>
                  </div>
                )}
              </div>

              {(uploadedSignatureUrl || savedDataUrl) && !disabled && (
                <button
                  type="button"
                  onClick={handleRemoveUploadedSignature}
                  className="absolute -top-2 -right-2 p-1.5 bg-rose-600 text-white rounded-full shadow-md hover:bg-rose-700 transition-transform active:scale-95 cursor-pointer"
                  title="Remove uploaded signature"
                >
                  <X className="w-4 h-4" />
                </button>
              )}
            </div>

            {/* Controls */}
            <div
              onDragOver={(e) => {
                e.preventDefault();
                if (!disabled) setIsDragging(true);
              }}
              onDragLeave={() => setIsDragging(false)}
              onDrop={(e) => {
                e.preventDefault();
                setIsDragging(false);
                if (!disabled && e.dataTransfer.files && e.dataTransfer.files[0]) {
                  handleUploadedFile(e.dataTransfer.files[0]);
                }
              }}
              className={`flex-1 w-full flex flex-col justify-center rounded-2xl p-4 transition-all text-center sm:text-left ${
                isDragging ? 'bg-[#FFF7EB] border-2 border-dashed border-[#A56F63]' : ''
              }`}
            >
              <h4 className="text-sm font-black text-[#2B2625] font-['Outfit']">
                {uploadedSignatureUrl || savedDataUrl ? 'Signature Photo Selected' : 'Upload Handwritten Signature'}
              </h4>
              <p className="text-xs text-[#A8A492] font-medium mt-1 leading-relaxed">
                Take a clear, bright picture of your signature on white paper, or upload a transparent PNG signature file. Up to 5MB.
              </p>

              <div className="flex flex-wrap items-center justify-center sm:justify-start gap-2.5 mt-4">
                <Button
                  type="button"
                  variant={uploadedSignatureUrl || savedDataUrl ? 'outline' : 'primary'}
                  size="sm"
                  onClick={() => fileInputRef.current?.click()}
                  disabled={disabled}
                  leftIcon={
                    uploadedSignatureUrl || savedDataUrl ? (
                      <RefreshCw className="w-3.5 h-3.5" />
                    ) : (
                      <Upload className="w-3.5 h-3.5" />
                    )
                  }
                >
                  {uploadedSignatureUrl || savedDataUrl ? 'Change Signature Photo' : 'Choose Signature Image'}
                </Button>

                {(uploadedSignatureUrl || savedDataUrl) && (
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    onClick={handleRemoveUploadedSignature}
                    disabled={disabled}
                    className="text-rose-600 hover:bg-rose-50"
                  >
                    Remove
                  </Button>
                )}
              </div>
            </div>
          </div>
        </div>
      )}

      {(uploadValidationError || error) && (
        <p className="text-xs text-rose-600 font-medium flex items-center gap-1 mt-1">
          <AlertCircle className="w-3.5 h-3.5 shrink-0" />
          {uploadValidationError || error}
        </p>
      )}
    </div>
  );
};
