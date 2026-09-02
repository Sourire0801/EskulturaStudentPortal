import React from 'react';
import { Routes, Route, Navigate, useLocation, Link } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';
import { FullPageLoader } from '../components/ui/FullPageLoader';
import { Button } from '../components/ui/Button';

// Layouts
import { StudentLayout } from '../layouts/StudentLayout';
import { AdminLayout } from '../layouts/AdminLayout';

// Public Pages
import { LandingPage } from '../pages/LandingPage';
import { Login } from '../pages/auth/Login';
import { AdminLogin } from '../pages/auth/AdminLogin';
import { AdminRegister } from '../pages/auth/AdminRegister';
import { Register } from '../pages/auth/Register';
import { ForgotPassword } from '../pages/auth/ForgotPassword';

// Student Pages
import { StudentDashboard } from '../pages/student/StudentDashboard';
import { StudentProfile } from '../pages/student/StudentProfile';
import { StudentForm } from '../pages/student/StudentForm';

// Admin Pages
import { AdminDashboard } from '../pages/admin/AdminDashboard';
import { Members } from '../pages/admin/Members';
import { Programs } from '../pages/admin/Programs';
import { EskulturaUnits } from '../pages/admin/EskulturaUnits';

// Route Guard: Protected for Students
const StudentRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user, role, loading } = useAuth();
  const location = useLocation();

  if (loading) {
    return <FullPageLoader message="Authenticating Student Session..." subtitle="Loading your ESKULTURA profile" />;
  }

  if (!user) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  if (role === 'admin') {
    return <>{children}</>;
  }

  return <>{children}</>;
};

// Route Guard: Protected for Admins Only
const AdminRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user, isAdmin, loading } = useAuth();
  const location = useLocation();

  if (loading) {
    return <FullPageLoader message="Verifying Administrator Privileges..." subtitle="Securing console access" />;
  }

  if (!user) {
    return <Navigate to="/admin/login" state={{ from: location }} replace />;
  }

  if (!isAdmin) {
    return <Navigate to="/student/dashboard" replace />;
  }

  return <>{children}</>;
};

// Route Guard: Public Only (redirects logged-in users away from login/register)
const PublicOnlyRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user, isAdmin, loading } = useAuth();

  if (loading) {
    return <FullPageLoader message="Checking Authentication..." subtitle="Preparing ESKULTURA portal" />;
  }

  if (user) {
    return <Navigate to={isAdmin ? '/admin/dashboard' : '/student/dashboard'} replace />;
  }

  return <>{children}</>;
};

// 404 Page
const NotFoundPage: React.FC = () => (
  <div className="min-h-screen flex flex-col items-center justify-center bg-[#FFF7EB] p-4 text-center">
    <div className="text-6xl font-black text-[#A56F63] mb-2 font-['Outfit']">404</div>
    <h2 className="text-2xl font-bold text-[#2B2625] mb-1 font-['Outfit']">Page Not Found</h2>
    <p className="text-xs text-[#A8A492] font-medium max-w-sm mb-6">
      The page you requested does not exist or has been moved.
    </p>
    <Link to="/">
      <Button variant="primary" size="md">
        Back to Home
      </Button>
    </Link>
  </div>
);

export const AppRoutes: React.FC = () => {
  return (
    <Routes>
      {/* Public Pages */}
      <Route path="/" element={<LandingPage />} />
      <Route
        path="/login"
        element={
          <PublicOnlyRoute>
            <Login />
          </PublicOnlyRoute>
        }
      />
      <Route
        path="/admin/login"
        element={
          <PublicOnlyRoute>
            <AdminLogin />
          </PublicOnlyRoute>
        }
      />
      <Route
        path="/admin/register"
        element={
          <PublicOnlyRoute>
            <AdminRegister />
          </PublicOnlyRoute>
        }
      />
      <Route
        path="/admin-register"
        element={
          <PublicOnlyRoute>
            <AdminRegister />
          </PublicOnlyRoute>
        }
      />
      <Route
        path="/register"
        element={
          <PublicOnlyRoute>
            <Register />
          </PublicOnlyRoute>
        }
      />
      <Route
        path="/forgot-password"
        element={
          <PublicOnlyRoute>
            <ForgotPassword />
          </PublicOnlyRoute>
        }
      />

      {/* Student Portal Routes */}
      <Route
        path="/student"
        element={
          <StudentRoute>
            <StudentLayout />
          </StudentRoute>
        }
      >
        <Route index element={<Navigate to="/student/dashboard" replace />} />
        <Route path="dashboard" element={<StudentDashboard />} />
        <Route path="profile" element={<StudentProfile />} />
        <Route path="edit" element={<StudentForm />} />
      </Route>

      {/* Administrator Console Routes */}
      <Route
        path="/admin"
        element={
          <AdminRoute>
            <AdminLayout />
          </AdminRoute>
        }
      >
        <Route index element={<Navigate to="/admin/dashboard" replace />} />
        <Route path="dashboard" element={<AdminDashboard />} />
        <Route path="members" element={<Members />} />
        <Route path="programs" element={<Programs />} />
        <Route path="eskultura-units" element={<EskulturaUnits />} />
      </Route>

      {/* 404 Fallback */}
      <Route path="*" element={<NotFoundPage />} />
    </Routes>
  );
};
