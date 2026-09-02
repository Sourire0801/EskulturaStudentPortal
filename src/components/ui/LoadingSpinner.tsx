import React from 'react';
import { Loader2 } from 'lucide-react';

export interface LoadingSpinnerProps {
  message?: string;
  className?: string;
  size?: 'sm' | 'md' | 'lg';
}

export const LoadingSpinner: React.FC<LoadingSpinnerProps> = ({
  message = 'Loading...',
  className = '',
  size = 'md',
}) => {
  const sizeClasses = {
    sm: 'w-5 h-5',
    md: 'w-7 h-7',
    lg: 'w-10 h-10',
  };

  return (
    <div className={`flex flex-col items-center justify-center py-10 px-4 gap-3 text-center ${className}`}>
      <div className="relative flex items-center justify-center">
        <Loader2 className={`${sizeClasses[size]} animate-spin text-[#A56F63]`} />
      </div>
      {message && (
        <p className="text-xs font-bold text-[#2B2625] font-['Outfit'] tracking-tight">
          {message}
        </p>
      )}
    </div>
  );
};
