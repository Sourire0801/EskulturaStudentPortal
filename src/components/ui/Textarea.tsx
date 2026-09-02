import React from 'react';
import { clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export interface TextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  helperText?: string;
  error?: string;
}

export const Textarea = React.forwardRef<HTMLTextAreaElement, TextareaProps>(
  ({ label, helperText, error, className, id, required, ...props }, ref) => {
    const textareaId = id || (label ? label.toLowerCase().replace(/\s+/g, '-') : undefined);

    return (
      <div className="w-full space-y-1.5 text-left">
        {label && (
          <label htmlFor={textareaId} className="block text-xs font-bold text-[#2B2625] tracking-tight">
            {label} {required && <span className="text-[#A56F63]">*</span>}
          </label>
        )}
        <textarea
          ref={ref}
          id={textareaId}
          className={twMerge(
            clsx(
              'w-full text-xs sm:text-sm bg-white border rounded-xl p-3 text-[#2B2625] placeholder:text-[#A8A492] transition-colors focus:outline-none shadow-xs',
              error
                ? 'border-rose-400 focus:border-rose-500'
                : 'border-[#A8A492]/40 hover:border-[#A8A492] focus:border-[#A56F63] focus:ring-1 focus:ring-[#A56F63]/20',
              className
            )
          )}
          required={required}
          {...props}
        />
        {error && <p className="text-[11px] font-medium text-rose-600">{error}</p>}
        {!error && helperText && <p className="text-[11px] text-[#A8A492]">{helperText}</p>}
      </div>
    );
  }
);

Textarea.displayName = 'Textarea';
