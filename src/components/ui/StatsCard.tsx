import React from 'react';
import { clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export interface StatsCardProps {
  title: string;
  value: string | number;
  subtitle?: string;
  badgeText?: string;
  badgeTrend?: 'up' | 'down' | 'neutral';
  isPrimary?: boolean;
  className?: string;
}

export const StatsCard: React.FC<StatsCardProps> = ({
  title,
  value,
  subtitle,
  badgeText,
  isPrimary = false,
  className,
}) => {
  return (
    <div
      className={twMerge(
        clsx(
          'p-6 rounded-3xl border transition-all duration-200 text-left relative overflow-hidden',
          isPrimary
            ? 'bg-[#A56F63] text-white border-[#A56F63] shadow-md'
            : 'bg-white text-[#2B2625] border-[#A8A492]/20 shadow-xs hover:border-[#A8A492]/40',
          className
        )
      )}
    >
      <div className="flex items-center justify-between gap-2 mb-3">
        <span
          className={clsx(
            'text-xs font-semibold uppercase tracking-wider',
            isPrimary ? 'text-white/80' : 'text-[#A8A492]'
          )}
        >
          {title}
        </span>
        {badgeText && (
          <span
            className={clsx(
              'text-[10px] font-bold px-2 py-0.5 rounded-full',
              isPrimary
                ? 'bg-white/20 text-white'
                : 'bg-[#FFF7EB] text-[#A56F63] border border-[#A56F63]/20'
            )}
          >
            {badgeText}
          </span>
        )}
      </div>

      <div
        className={clsx(
          'text-3xl sm:text-4xl font-black tracking-tight mb-1 font-["Outfit"]',
          isPrimary ? 'text-white' : 'text-[#2B2625]'
        )}
      >
        {value}
      </div>

      {subtitle && (
        <p
          className={clsx(
            'text-xs font-medium mt-2',
            isPrimary ? 'text-white/80' : 'text-[#A8A492]'
          )}
        >
          {subtitle}
        </p>
      )}
    </div>
  );
};
