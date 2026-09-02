import React from 'react';
import { clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export interface SelectOption {
  value: string;
  label: string;
}

export interface SelectProps extends React.SelectHTMLAttributes<HTMLSelectElement> {
  label?: string;
  options: SelectOption[];
  helperText?: string;
  error?: string;
  placeholder?: string;
}

export const Select = React.forwardRef<HTMLSelectElement, SelectProps>(
  ({ label, options, helperText, error, placeholder, className, id, required, ...props }, ref) => {
    const selectId = id || (label ? label.toLowerCase().replace(/\s+/g, '-') : undefined);

    return (
      <div className="w-full space-y-1.5 text-left">
        {label && (
          <label htmlFor={selectId} className="block text-xs font-bold text-[#2B2625] tracking-tight">
            {label} {required && <span className="text-[#A56F63]">*</span>}
          </label>
        )}
        <div className="relative">
          <select
            ref={ref}
            id={selectId}
            className={twMerge(
              clsx(
                'w-full text-xs sm:text-sm bg-white border rounded-xl py-2.5 pl-3.5 pr-8 text-[#2B2625] transition-colors focus:outline-none shadow-xs appearance-none cursor-pointer',
                error
                  ? 'border-rose-400 focus:border-rose-500'
                  : 'border-[#A8A492]/40 hover:border-[#A8A492] focus:border-[#A56F63] focus:ring-1 focus:ring-[#A56F63]/20',
                className
              )
            )}
            required={required}
            {...props}
          >
            {placeholder && (
              <option value="" disabled>
                {placeholder}
              </option>
            )}
            {options.map((opt) => (
              <option key={opt.value} value={opt.value}>
                {opt.label}
              </option>
            ))}
          </select>
          <div className="absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none text-[#A8A492]">
            <svg className="w-4 h-4 fill-current" viewBox="0 0 20 20">
              <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
            </svg>
          </div>
        </div>
        {error && <p className="text-[11px] font-medium text-rose-600">{error}</p>}
        {!error && helperText && <p className="text-[11px] text-[#A8A492]">{helperText}</p>}
      </div>
    );
  }
);

Select.displayName = 'Select';
