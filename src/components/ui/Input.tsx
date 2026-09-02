import React from 'react';
import { clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  helperText?: string;
  error?: string;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
}

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ label, helperText, error, leftIcon, rightIcon, className, id, required, ...props }, ref) => {
    const inputId = id || (label ? label.toLowerCase().replace(/\s+/g, '-') : undefined);

    return (
      <div className="w-full space-y-1.5 text-left">
        {label && (
          <label htmlFor={inputId} className="block text-xs font-bold text-[#2B2625] tracking-tight">
            {label} {required && <span className="text-[#A56F63]">*</span>}
          </label>
        )}
        <div className="relative flex items-center">
          {leftIcon && (
            <div className="absolute left-3.5 text-[#A8A492] pointer-events-none flex items-center justify-center">
              {leftIcon}
            </div>
          )}
          <input
            ref={ref}
            id={inputId}
            className={twMerge(
              clsx(
                'w-full text-xs sm:text-sm bg-white border rounded-xl py-2.5 px-3.5 text-[#2B2625] placeholder:text-[#A8A492] transition-colors focus:outline-none shadow-xs',
                leftIcon ? 'pl-10' : 'pl-3.5',
                rightIcon ? 'pr-10' : 'pr-3.5',
                error
                  ? 'border-rose-400 focus:border-rose-500 focus:ring-1 focus:ring-rose-500/20'
                  : 'border-[#A8A492]/40 hover:border-[#A8A492] focus:border-[#A56F63] focus:ring-1 focus:ring-[#A56F63]/20',
                className
              )
            )}
            required={required}
            {...props}
          />
          {rightIcon && (
            <div className="absolute right-3.5 text-[#A8A492] pointer-events-none flex items-center justify-center">
              {rightIcon}
            </div>
          )}
        </div>
        {error && <p className="text-[11px] font-medium text-rose-600">{error}</p>}
        {!error && helperText && <p className="text-[11px] text-[#A8A492]">{helperText}</p>}
      </div>
    );
  }
);

Input.displayName = 'Input';
