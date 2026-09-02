import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';
import { authService } from '../../services/authService';
import { useToast } from '../../components/ui/Toast';
import { Button } from '../../components/ui/Button';
import { Input } from '../../components/ui/Input';
import { Card, CardContent } from '../../components/ui/Card';
import { Badge } from '../../components/ui/Badge';
import { AlertCircle, ArrowLeft } from 'lucide-react';

export const AdminLogin: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const { refreshProfile } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!email.trim()) {
      setError('Please enter your administrator email.');
      return;
    }
    if (!password) {
      setError('Please enter your password.');
      return;
    }

    try {
      setLoading(true);
      const res = await authService.signIn(email.trim(), password);

      if (res.user) {
        const profile = await authService.getProfile(res.user.id);
        await refreshProfile();

        if (profile?.role !== 'admin') {
          await authService.signOut();
          setError('Access Denied: This portal is strictly for administrators. Student accounts cannot sign in here.');
          toast.error('Unauthorized Access', 'This account does not have administrator privileges.');
          return;
        }

        toast.success('Admin Authenticated', 'Welcome to the ESKULTURA Administrator Console.');
        navigate('/admin/dashboard', { replace: true });
      }
    } catch (err: any) {
      console.error('Admin Login error:', err);
      setError(err.message || 'Invalid administrator credentials. Access denied.');
      toast.error('Authentication Failed', err.message || 'Invalid administrator credentials.');
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
            Restricted Admin Area
          </Badge>
        </div>

        <h2 className="text-2xl font-black text-[#2B2625] tracking-tight font-['Outfit']">
          Administrator Console Login
        </h2>
        <p className="text-xs text-[#A8A492] font-medium mt-1">
          Authorized personnel access only.
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
                label="Administrator Email"
                type="email"
                placeholder="admin@eskultura.edu.ph"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />

              <Input
                label="Administrator Password"
                type="password"
                placeholder="••••••••••••"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />

              <Button
                type="submit"
                size="lg"
                variant="secondary"
                isLoading={loading}
                className="w-full mt-3 font-bold shadow-md bg-[#2B2625] hover:bg-[#1E1B1A]"
              >
                Authenticate as Admin
              </Button>
            </form>

            <div className="text-center pt-3 border-t border-[#A8A492]/20">
              <p className="text-xs text-[#2B2625]/80 font-medium">
                Need to create an administrator account?{' '}
                <Link to="/admin/register" className="text-[#A56F63] font-bold hover:underline">
                  Register here
                </Link>
              </p>
            </div>

            <div className="pt-3 border-t border-[#A8A492]/10 flex items-center justify-between text-xs text-[#A8A492] font-medium">
              <Link
                to="/login"
                className="inline-flex items-center gap-1.5 text-[#2B2625] hover:text-[#A56F63] transition-colors"
              >
                <ArrowLeft className="w-3.5 h-3.5" />
                <span>Student Login</span>
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
