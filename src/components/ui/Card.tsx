import React from 'react';
import { clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  children: React.ReactNode;
  className?: string;
  hoverEffect?: boolean;
}

export const Card: React.FC<CardProps> = ({
  children,
  className,
  hoverEffect = false,
  ...props
}) => {
  return (
    <div
      className={twMerge(
        clsx(
          'bg-white rounded-3xl border border-[#A8A492]/20 shadow-sm transition-all duration-200',
          hoverEffect && 'hover:shadow-md hover:border-[#A56F63]/40',
          className
        )
      )}
      {...props}
    >
      {children}
    </div>
  );
};

export const CardHeader: React.FC<{ children: React.ReactNode; className?: string }> = ({
  children,
  className,
}) => (
  <div className={twMerge(clsx('px-6 py-5 border-b border-[#A8A492]/15', className))}>
    {children}
  </div>
);

export const CardTitle: React.FC<{ children: React.ReactNode; className?: string }> = ({
  children,
  className,
}) => (
  <h3 className={twMerge(clsx('text-base font-bold text-[#2B2625] tracking-tight', className))}>
    {children}
  </h3>
);

export const CardDescription: React.FC<{ children: React.ReactNode; className?: string }> = ({
  children,
  className,
}) => (
  <p className={twMerge(clsx('text-xs text-[#A8A492] mt-1 font-medium', className))}>
    {children}
  </p>
);

export const CardContent: React.FC<{ children: React.ReactNode; className?: string }> = ({
  children,
  className,
}) => <div className={twMerge(clsx('p-6', className))}>{children}</div>;

export const CardFooter: React.FC<{ children: React.ReactNode; className?: string }> = ({
  children,
  className,
}) => (
  <div className={twMerge(clsx('px-6 py-4 border-t border-[#A8A492]/15 bg-[#FFF7EB]/40 rounded-b-3xl', className))}>
    {children}
  </div>
);
