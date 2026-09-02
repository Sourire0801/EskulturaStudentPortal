import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { authService } from '../../services/authService';
import { useAuth } from '../../hooks/useAuth';
import { useToast } from '../../components/ui/Toast';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Card, CardContent } from '../../components/ui/Card';
import { Badge } from '../../components/ui/Badge';
import { AlertCircle, ShieldCheck, ArrowLeft } from 'lucide-react';

export const AdminRegister: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [adminKey, setAdminKey] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const { refreshProfile } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  // Master setup key (optional security layer: defaults to ESKULTURA2026 or admin12345)
  const EXPECTED_KEY = 'ESKULTURA2026';

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!email.trim()) {
      setError('Please enter your administrator email.');
      return;
    }
    if (!password || password.length < 6) {
      setError('Password must be at least 6 characters long.');
      return;
    }
    if (password !== confirmPassword) {
      setError('Passwords do not match. Please re-enter.');
      return;
    }

    // Check optional security passkey if provided or validate
    if (adminKey.trim() && adminKey.trim().toUpperCase() !== EXPECTED_KEY && adminKey.trim() !== 'admin12345') {
      setError(`Invalid Admin Authorization Key. (Hint: Use default "${EXPECTED_KEY}" or leave blank if direct creation is enabled).`);
      return;
    }

    try {
      setLoading(true);
      const res = await authService.signUp(email.trim(), password, 'admin');

      await refreshProfile();

      toast.success(
        'Administrator Account Created!',
        res.session ? 'Welcome to the Administrator Console.' : 'Please verify your email or sign in.'
      );

      if (res.session) {
        navigate('/admin/dashboard', { replace: true });
      } else {
        navigate('/admin/login', { replace: true });
      }
    } catch (err: any) {
      console.error('Admin Registration error:', err);
      setError(err.message || 'Unable to register administrator account. Please try again.');
      toast.error('Registration Failed', err.message);
    } finally {
      setLoading(false);
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
              Admin Portal
            </span>
          </div>
        </Link>

        <div className="flex items-center justify-center gap-2 mb-2">
          <Badge variant="primary" size="sm" className="font-mono text-[10px] uppercase tracking-widest">
            <ShieldCheck className="w-3 h-3 inline mr-1" />
            Admin Account Provisioning
          </Badge>
        </div>

        <h2 className="text-2xl font-black text-[#2B2625] tracking-tight font-['Outfit']">
          Register Administrator
        </h2>
        <p className="text-xs text-[#A8A492] font-medium mt-1">
          Create a privileged administrator account for managing ESKULTURA memberships.
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

            <form onSubmit={handleSubmit} className="space-y-4">
              <Input
                label="Administrator Email Address"
                type="email"
                placeholder="admin@eskultura.edu.ph"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />

              <Input
                label="Administrator Password"
                type="password"
                placeholder="Minimum 6 characters"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />

              <Input
                label="Confirm Password"
                type="password"
                placeholder="Repeat administrator password"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                required
              />

              <div>
                <Input
                  label="Admin Authorization Passcode"
                  type="password"
                  placeholder="ESKULTURA2026"
                  value={adminKey}
                  onChange={(e) => setAdminKey(e.target.value)}
                />
                <p className="text-[11px] text-[#A8A492] mt-1 font-medium">
                  Default authorization key: <code className="text-[#A56F63] font-bold">ESKULTURA2026</code>
                </p>
              </div>

              <Button
                type="submit"
                size="lg"
                variant="secondary"
                isLoading={loading}
                className="w-full mt-3 font-bold shadow-md bg-[#2B2625] hover:bg-[#1E1B1A]"
              >
                Create Admin Account
              </Button>
            </form>

            <div className="text-center pt-3 border-t border-[#A8A492]/20">
              <p className="text-xs text-[#2B2625]/80 font-medium">
                Already have administrator credentials?{' '}
                <Link to="/admin/login" className="text-[#A56F63] font-bold hover:underline">
                  Sign in here
                </Link>
              </p>
            </div>

            <div className="pt-2 flex items-center justify-between text-xs text-[#A8A492] font-medium border-t border-[#A8A492]/10">
              <Link
                to="/login"
                className="inline-flex items-center gap-1.5 text-[#2B2625] hover:text-[#A56F63] transition-colors"
              >
                <ArrowLeft className="w-3.5 h-3.5" />
                <span>Student Portal</span>
              </Link>

              <Link
                to="/"
                className="text-[#A8A492] hover:text-[#2B2625] transition-colors"
              >
                Home
              </Link>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};
