import React, { useState } from 'react';
import { Outlet, Link, useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';
import { isSupabaseConfigured } from '../lib/supabase';
import {
  LayoutDashboard,
  UserCheck,
  Edit3,
  LogOut,
  Menu,
  X,
  ChevronLeft,
  ChevronRight,
  AlertTriangle,
} from 'lucide-react';
import { Button } from '../components/ui/Button';

export const StudentLayout: React.FC = () => {
  const { user, signOut } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  const [isCollapsed, setIsCollapsed] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const handleSignOut = async () => {
    try {
      await signOut();
      navigate('/login');
    } catch (err) {
      console.error('Sign out error:', err);
    }
  };

  const navItems = [
    { label: 'Dashboard', path: '/student/dashboard', icon: <LayoutDashboard className="w-5 h-5 fill-current" /> },
    { label: 'My Profile Slip', path: '/student/profile', icon: <UserCheck className="w-5 h-5 fill-current" /> },
    { label: 'Registration Form', path: '/student/edit', icon: <Edit3 className="w-5 h-5 fill-current" /> },
  ];

  const studentEmail = user?.email || 'student@university.edu.ph';
  const studentDisplayName = studentEmail.split('@')[0];

  return (
    <div className="min-h-screen bg-[#FFF7EB] text-[#2B2625] flex flex-col selection:bg-[#A56F63] selection:text-white">
      {/* Supabase Config Warning */}
      {!isSupabaseConfigured() && (
        <div className="fixed top-0 left-0 right-0 z-50 bg-amber-500 text-white px-4 py-1.5 text-xs font-bold text-center flex items-center justify-center gap-2 shadow-md">
          <AlertTriangle className="w-4 h-4 shrink-0" />
          <span>Supabase credentials missing in .env. Please configure your database credentials.</span>
        </div>
      )}

      {/* Desktop Sidebar */}
      <aside
        className={`hidden md:flex flex-col fixed inset-y-0 left-0 z-30 bg-white border-r border-[#A8A492]/25 transition-all duration-300 ease-in-out ${
          isCollapsed ? 'w-20' : 'w-64'
        }`}
      >
        {/* Brand Header */}
        <div className="h-20 flex items-center justify-between px-4 border-b border-[#A8A492]/15">
          <div className="flex items-center gap-3 overflow-hidden">
            <img
              src="/logo.png"
              alt="ESKULTURA Logo"
              className="w-10 h-10 rounded-2xl object-contain shrink-0 border border-[#A8A492]/30 shadow-xs bg-white"
            />
            {!isCollapsed && (
              <div className="min-w-0 transition-opacity duration-200">
                <span className="text-base font-black tracking-tight text-[#2B2625] block truncate font-['Outfit']">
                  ESKULTURA
                </span>
                <span className="text-[10px] uppercase font-bold tracking-widest text-[#A56F63] block -mt-1">
                  Student Portal
                </span>
              </div>
            )}
          </div>

          {/* Collapse Toggle Button */}
          <button
            onClick={() => setIsCollapsed(!isCollapsed)}
            className="w-7 h-7 rounded-xl bg-[#FFF7EB] hover:bg-[#A56F63] text-[#A8A492] hover:text-white flex items-center justify-center transition-colors cursor-pointer shrink-0"
            title={isCollapsed ? 'Expand sidebar' : 'Collapse sidebar'}
          >
            {isCollapsed ? <ChevronRight className="w-4 h-4" /> : <ChevronLeft className="w-4 h-4" />}
          </button>
        </div>

        {/* Navigation Menu */}
        <div className="flex-1 py-6 px-3 space-y-2 overflow-y-auto">
          {!isCollapsed && (
            <div className="px-3 pb-2 text-[10px] font-bold uppercase tracking-wider text-[#A8A492]">
              Navigation
            </div>
          )}

          {navItems.map((item) => {
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                title={isCollapsed ? item.label : undefined}
                className={`flex items-center gap-3.5 px-3.5 py-3 rounded-2xl text-xs font-bold transition-all ${
                  isActive
                    ? 'bg-[#A56F63] text-white shadow-sm'
                    : 'text-[#2B2625] hover:bg-[#FFF7EB] hover:text-[#A56F63]'
                } ${isCollapsed ? 'justify-center px-0' : ''}`}
              >
                <span className={isActive ? 'text-white' : 'text-[#A8A492]'}>{item.icon}</span>
                {!isCollapsed && <span>{item.label}</span>}
              </Link>
            );
          })}
        </div>

        {/* Footer info in sidebar */}
        {!isCollapsed && (
          <div className="p-4 m-3 rounded-2xl bg-[#FFF7EB] border border-[#A8A492]/20 text-left">
            <div className="text-[11px] font-bold text-[#2B2625] truncate">{studentEmail}</div>
            <div className="text-[10px] font-semibold text-[#A56F63] uppercase tracking-wider">
              Student Member
            </div>
          </div>
        )}
      </aside>

      {/* Main Content Area (Sticks with sidebar) */}
      <div
        className={`flex-1 flex flex-col transition-all duration-300 ease-in-out ${
          isCollapsed ? 'md:pl-20' : 'md:pl-64'
        }`}
      >
        {/* Top Minimalist Header */}
        <header className="h-20 bg-white/80 backdrop-blur-md border-b border-[#A8A492]/20 sticky top-0 z-20 px-4 sm:px-8 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <button
              onClick={() => setMobileMenuOpen(true)}
              className="md:hidden p-2 rounded-xl bg-[#FFF7EB] text-[#2B2625] hover:text-[#A56F63]"
            >
              <Menu className="w-5 h-5" />
            </button>

            <div>
              <h2 className="text-base sm:text-lg font-black text-[#2B2625] tracking-tight font-['Outfit']">
                Student Membership Portal
              </h2>
              <p className="text-xs text-[#A8A492] font-medium hidden sm:block">
                ESKULTURA Official Registration & Data Record
              </p>
            </div>
          </div>

          {/* User Profile & Logout Header Action */}
          <div className="flex items-center gap-4">
            <div className="hidden sm:flex items-center gap-3 pl-4 border-l border-[#A8A492]/20 text-left">
              <div className="w-9 h-9 rounded-2xl bg-[#A56F63]/10 text-[#A56F63] flex items-center justify-center font-bold text-xs uppercase border border-[#A56F63]/30">
                {studentDisplayName.slice(0, 2)}
              </div>
              <div className="min-w-0">
                <span className="text-xs font-bold text-[#2B2625] block truncate max-w-[140px]">
                  {studentDisplayName}
                </span>
                <span className="text-[10px] font-semibold text-[#A8A492] block -mt-0.5">
                  Student Member
                </span>
              </div>
            </div>

            <Button
              variant="secondary"
              size="sm"
              onClick={handleSignOut}
              className="rounded-xl px-4 py-2 font-bold text-xs"
              rightIcon={<LogOut className="w-3.5 h-3.5 fill-current" />}
            >
              Log Out
            </Button>
          </div>
        </header>

        {/* Mobile Drawer */}
        {mobileMenuOpen && (
          <div className="fixed inset-0 z-50 md:hidden bg-black/40 backdrop-blur-xs flex">
            <div className="w-72 bg-white h-full p-6 flex flex-col justify-between shadow-2xl">
              <div>
                <div className="flex items-center justify-between pb-4 border-b border-[#A8A492]/20 mb-6">
                  <div className="flex items-center gap-2.5">
                    <img
                      src="/logo.png"
                      alt="Logo"
                      className="w-9 h-9 rounded-xl object-cover"
                    />
                    <span className="text-base font-black text-[#2B2625]">ESKULTURA</span>
                  </div>
                  <button
                    onClick={() => setMobileMenuOpen(false)}
                    className="p-1.5 rounded-xl bg-[#FFF7EB] text-[#2B2625]"
                  >
                    <X className="w-5 h-5" />
                  </button>
                </div>

                <div className="space-y-1.5">
                  {navItems.map((item) => {
                    const isActive = location.pathname === item.path;
                    return (
                      <Link
                        key={item.path}
                        to={item.path}
                        onClick={() => setMobileMenuOpen(false)}
                        className={`flex items-center gap-3 px-3.5 py-3 rounded-2xl text-xs font-bold ${
                          isActive
                            ? 'bg-[#A56F63] text-white shadow-sm'
                            : 'text-[#2B2625] hover:bg-[#FFF7EB]'
                        }`}
                      >
                        {item.icon}
                        <span>{item.label}</span>
                      </Link>
                    );
                  })}
                </div>
              </div>

              <div className="pt-4 border-t border-[#A8A492]/20">
                <Button
                  variant="secondary"
                  size="sm"
                  onClick={() => {
                    setMobileMenuOpen(false);
                    handleSignOut();
                  }}
                  className="w-full"
                  rightIcon={<LogOut className="w-4 h-4 fill-current" />}
                >
                  Log Out
                </Button>
              </div>
            </div>
            <div className="flex-1" onClick={() => setMobileMenuOpen(false)} />
          </div>
        )}

        {/* Main Content View (Sticks and resizes seamlessly with sidebar) */}
        <main className="flex-1 p-4 sm:p-6 lg:p-8 w-full max-w-7xl mx-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
};
