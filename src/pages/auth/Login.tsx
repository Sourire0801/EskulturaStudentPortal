import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';
import { authService } from '../../services/authService';
import { useToast } from '../../components/ui/Toast';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Card, CardContent } from '../../components/ui/Card';
import { AlertCircle, ShieldCheck } from 'lucide-react';

export const Login: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [googleLoading, setGoogleLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const { refreshProfile } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();
  const location = useLocation();

  const from = location.state?.from?.pathname || '/student/dashboard';

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!email.trim()) {
      setError('Please enter your student email address.');
      return;
    }
    if (!password) {
      setError('Please enter your password.');
      return;
    }

    try {
      setLoading(true);
      const res = await authService.signIn(email.trim(), password);
      toast.success('Welcome back!', 'Signed in successfully.');

      if (res.user) {
        const profile = await authService.getProfile(res.user.id);
        await refreshProfile();
        if (profile?.role === 'admin') {
          navigate('/admin/dashboard', { replace: true });
        } else {
          navigate(from === '/admin/dashboard' ? '/student/dashboard' : from, { replace: true });
        }
      }
    } catch (err: any) {
      console.error('Login error:', err);
      setError(err.message || 'Invalid email or password. Please try again.');
      toast.error('Login Failed', err.message || 'Invalid email or password.');
    } finally {
      setLoading(false);
    }
  };

  const handleGoogleSignIn = async () => {
    try {
      setGoogleLoading(true);
      setError(null);
      await authService.signInWithGoogle();
    } catch (err: any) {
      console.error('Google Sign In error:', err);
      setError(err.message || 'Failed to initialize Google Sign In.');
      toast.error('Google Auth Failed', err.message);
      setGoogleLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#FFF7EB] flex flex-col justify-center py-12 sm:px-6 lg:px-8 relative selection:bg-[#A56F63] selection:text-white">
      <div className="sm:mx-auto sm:w-full sm:max-w-md text-center z-10 px-4">
        <Link to="/" className="inline-flex items-center gap-3 mb-6">
          <img
            src="/logo.png"
            alt="ESKULTURA Logo"
            className="w-12 h-12 rounded-2xl object-contain border border-[#A8A492]/30 shadow-sm bg-white"
          />
          <div className="text-left">
            <span className="text-2xl font-black tracking-tight text-[#2B2625] block font-['Outfit']">
              ESKULTURA
            </span>
            <span className="text-[10px] uppercase font-bold tracking-widest text-[#A56F63] block -mt-1">
              Student Portal
            </span>
          </div>
        </Link>
        <h2 className="text-2xl font-black text-[#2B2625] tracking-tight font-['Outfit']">
          Student Sign In
        </h2>
        <p className="text-xs text-[#A8A492] font-medium mt-1">
          Access your student membership application and records.
        </p>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md z-10 px-4">
        <Card className="shadow-lg border-[#A8A492]/20">
          <CardContent className="p-6 sm:p-8 space-y-6">
            {error && (
              <div className="p-3.5 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs flex items-start gap-2.5">
                <AlertCircle className="w-4 h-4 shrink-0 text-rose-600 mt-0.5" />
                <span className="leading-relaxed font-medium">{error}</span>
              </div>
            )}

            {/* Google OAuth Button */}
            <button
              type="button"
              onClick={handleGoogleSignIn}
              disabled={googleLoading || loading}
              className="w-full flex items-center justify-center gap-3 px-4 py-3 rounded-xl border border-[#A8A492]/40 bg-white text-[#2B2625] text-xs font-bold hover:bg-[#FFF7EB] hover:border-[#A56F63] transition-all cursor-pointer disabled:opacity-50 shadow-xs"
            >
              <svg className="w-4 h-4" viewBox="0 0 24 24">
                <path
                  fill="#4285F4"
                  d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                />
                <path
                  fill="#34A853"
                  d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                />
                <path
                  fill="#FBBC05"
                  d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"
                />
                <path
                  fill="#EA4335"
                  d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"
                />
              </svg>
              <span>{googleLoading ? 'Connecting...' : 'Continue with Google'}</span>
            </button>

            <div className="relative flex items-center justify-center">
              <div className="border-t border-[#A8A492]/20 w-full" />
              <span className="bg-white px-3 text-[10px] font-bold uppercase tracking-wider text-[#A8A492] absolute">
                Or continue with email
              </span>
            </div>

            {/* Email / Password Form */}
            <form onSubmit={handleSubmit} className="space-y-4">
              <Input
                label="Student Email Address"
                type="email"
                placeholder="student@university.edu.ph"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />

              <div className="space-y-1">
                <div className="flex items-center justify-between">
                  <label className="block text-xs font-bold text-[#2B2625] tracking-tight">
                    Password <span className="text-[#A56F63]">*</span>
                  </label>
                  <Link
                    to="/forgot-password"
                    className="text-[11px] font-bold text-[#A56F63] hover:underline"
                  >
                    Forgot Password?
                  </Link>
                </div>
                <Input
                  type="password"
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                />
              </div>

              <Button
                type="submit"
                size="lg"
                isLoading={loading}
                className="w-full mt-2 font-bold shadow-md"
              >
                Sign In to Student Portal
              </Button>
            </form>

            <div className="text-center pt-3 border-t border-[#A8A492]/20 space-y-3">
              <p className="text-xs text-[#2B2625]/80 font-medium">
                Don't have a student account?{' '}
                <Link to="/register" className="text-[#A56F63] font-bold hover:underline">
                  Register here
                </Link>
              </p>

              <div className="pt-2">
                <Link
                  to="/admin/login"
                  className="inline-flex items-center gap-1.5 text-[11px] font-bold text-[#A8A492] hover:text-[#A56F63] transition-colors"
                >
                  <ShieldCheck className="w-3.5 h-3.5 text-[#A56F63]" />
                  <span>Administrator Portal Login</span>
                </Link>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};
