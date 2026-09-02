import React from 'react';

export interface FullPageLoaderProps {
  message?: string;
  subtitle?: string;
}

export const FullPageLoader: React.FC<FullPageLoaderProps> = ({
  message = 'Authenticating Session...',
  subtitle = 'Please wait while we prepare your portal',
}) => {
  return (
    <div className="min-h-screen bg-[#FFF7EB] flex flex-col items-center justify-center p-6 relative overflow-hidden select-none">
      {/* Soft atmospheric background glow */}
      <div className="absolute w-96 h-96 rounded-full bg-[#A56F63]/10 blur-3xl pointer-events-none -top-20 -left-20" />
      <div className="absolute w-96 h-96 rounded-full bg-[#A8A492]/15 blur-3xl pointer-events-none -bottom-20 -right-20" />

      <div className="relative z-10 flex flex-col items-center text-center max-w-sm">
        {/* Animated Brand Logo Container */}
        <div className="relative mb-6">
          {/* Pulsing outer ring */}
          <div className="absolute -inset-3 rounded-3xl bg-[#A56F63]/15 animate-ping opacity-75" />
          
          {/* Spinning accent border */}
          <div className="absolute -inset-1.5 rounded-3xl bg-gradient-to-tr from-[#A56F63] via-[#FFF7EB] to-[#2B2625] animate-spin opacity-80" />
          
          {/* Logo Card */}
          <div className="relative w-20 h-20 sm:w-24 sm:h-24 rounded-2xl bg-white p-1.5 shadow-xl border border-[#A8A492]/30 flex items-center justify-center">
            <img
              src="/logo.png"
              alt="ESKULTURA"
              className="w-full h-full object-contain rounded-xl shadow-inner"
            />
          </div>
        </div>

        {/* Brand Name */}
        <span className="text-2xl sm:text-3xl font-black text-[#2B2625] tracking-tight font-['Outfit'] block">
          ESKULTURA
        </span>
        <span className="text-[10px] uppercase font-bold tracking-widest text-[#A56F63] block -mt-0.5 mb-5">
          Student Registration & Membership
        </span>

        {/* Message Pill */}
        <div className="flex items-center gap-2.5 px-4 py-2 rounded-full bg-white/80 border border-[#A8A492]/25 shadow-xs backdrop-blur-xs">
          <div className="w-2.5 h-2.5 rounded-full bg-[#A56F63] animate-pulse" />
          <span className="text-xs font-bold text-[#2B2625] font-['Outfit']">
            {message}
          </span>
        </div>

        {subtitle && (
          <p className="text-[11px] text-[#A8A492] font-medium mt-2">
            {subtitle}
          </p>
        )}
      </div>
    </div>
  );
};
