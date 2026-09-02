import React, { useState, useEffect, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { memberService } from '../../services/memberService';
import { StatsCard } from '../../components/ui/StatsCard';
import { Card, CardHeader, CardTitle, CardContent } from '../../components/ui/Card';
import { Badge } from '../../components/ui/Badge';
import { Button } from '../../components/ui/Button';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { ArrowUpRight, ArrowRight } from 'lucide-react';
import type { AdminDashboardStats } from '../../types/student';

export const AdminDashboard: React.FC = () => {
  const [stats, setStats] = useState<AdminDashboardStats | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchStats = useCallback(async () => {
    try {
      setLoading(true);
      const data = await memberService.getDashboardStats();
      setStats(data);
    } catch (err) {
      console.error('Failed to load admin stats:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  if (loading) {
    return <LoadingSpinner message="Calculating dashboard analytics..." size="lg" />;
  }

  const currentDate = new Date().toLocaleDateString('en-US', {
    weekday: 'long',
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  });

  return (
    <div className="space-y-8 text-left">
      {/* Dashboard Top Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <span className="text-xs font-bold uppercase tracking-wider text-[#A56F63]">
            {currentDate}
          </span>
          <h1 className="text-2xl sm:text-3xl font-black text-[#2B2625] tracking-tight font-['Outfit'] mt-0.5">
            Membership Dashboard
          </h1>
          <p className="text-xs sm:text-sm text-[#A8A492] font-medium">
            Overview of student member registrations, academic distribution, and unit allocations.
          </p>
        </div>

        <div className="flex items-center gap-3">
          <Link to="/admin/members">
            <Button variant="primary" size="sm" rightIcon={<ArrowRight className="w-4 h-4" />}>
              Open Members Directory
            </Button>
          </Link>
        </div>
      </div>

      {/* KPI Cards Grid (Donezo Style) */}
      <div className="grid grid-cols-2 lg:grid-cols-5 gap-4 sm:gap-5">
        <StatsCard
          title="Total Members"
          value={stats?.totalMembers || 0}
          subtitle="Official registered students"
          badgeText="Active"
          isPrimary
          className="col-span-2 sm:col-span-1 lg:col-span-1"
        />
        <StatsCard
          title="First Year"
          value={stats?.firstYearCount || 0}
          subtitle="1st Year level"
        />
        <StatsCard
          title="Second Year"
          value={stats?.secondYearCount || 0}
          subtitle="2nd Year level"
        />
        <StatsCard
          title="Third Year"
          value={stats?.thirdYearCount || 0}
          subtitle="3rd Year level"
        />
        <StatsCard
          title="Fourth Year"
          value={stats?.fourthYearCount || 0}
          subtitle="4th Year level"
        />
      </div>

      {/* Breakdown Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* ESKULTURA Units Breakdown */}
        <Card className="lg:col-span-2">
          <CardHeader className="flex items-center justify-between">
            <div>
              <CardTitle>ESKULTURA Units Allocation</CardTitle>
              <p className="text-xs text-[#A8A492] font-medium mt-0.5">
                Member count across recognized artistic wings
              </p>
            </div>
            <Link to="/admin/eskultura-units" className="text-xs font-bold text-[#A56F63] hover:underline">
              Manage Units
            </Link>
          </CardHeader>
          <CardContent className="space-y-4">
            {stats && stats.byUnit && stats.byUnit.length > 0 ? (
              <div className="space-y-3.5">
                {stats.byUnit.map((item) => {
                  const percent = stats.totalMembers > 0
                    ? Math.round((item.count / stats.totalMembers) * 100)
                    : 0;

                  return (
                    <div key={item.name} className="space-y-1.5">
                      <div className="flex items-center justify-between text-xs">
                        <span className="font-bold text-[#2B2625]">{item.name}</span>
                        <div className="flex items-center gap-2">
                          <span className="font-mono text-[11px] text-[#A8A492]">
                            {item.count} {item.count === 1 ? 'member' : 'members'}
                          </span>
                          <span className="font-bold text-[#A56F63] w-9 text-right font-['Outfit']">
                            {percent}%
                          </span>
                        </div>
                      </div>
                      <div className="w-full h-2 bg-[#FFF7EB] rounded-full overflow-hidden border border-[#A8A492]/20">
                        <div
                          className="h-full bg-[#A56F63] rounded-full transition-all duration-500"
                          style={{ width: `${percent}%` }}
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className="text-xs text-[#A8A492] text-center py-6">No unit data available yet.</p>
            )}
          </CardContent>
        </Card>

        {/* Gender Breakdown */}
        <Card>
          <CardHeader>
            <CardTitle>Demographics & Gender</CardTitle>
            <p className="text-xs text-[#A8A492] font-medium mt-0.5">
              Self-identified gender breakdown
            </p>
          </CardHeader>
          <CardContent className="space-y-4">
            {stats && stats.byGender ? (
              <div className="space-y-3">
                {stats.byGender.map((item) => {
                  const percent = stats.totalMembers > 0
                    ? Math.round((item.count / stats.totalMembers) * 100)
                    : 0;
                  return (
                    <div
                      key={item.gender}
                      className="p-3.5 rounded-2xl bg-[#FFF7EB]/50 border border-[#A8A492]/20 flex items-center justify-between"
                    >
                      <div>
                        <span className="text-xs font-bold text-[#2B2625] block">{item.gender}</span>
                        <span className="text-[11px] text-[#A8A492] font-medium">
                          {percent}% of total
                        </span>
                      </div>
                      <span className="text-lg font-black text-[#A56F63] font-['Outfit']">
                        {item.count}
                      </span>
                    </div>
                  );
                })}
              </div>
            ) : null}
          </CardContent>
        </Card>
      </div>

      {/* Recent Registrations Table */}
      <Card>
        <CardHeader className="flex items-center justify-between">
          <div>
            <CardTitle>Recent Member Registrations</CardTitle>
            <p className="text-xs text-[#A8A492] font-medium mt-0.5">
              Latest students added into the ESKULTURA database
            </p>
          </div>
          <Link to="/admin/members">
            <Button variant="outline" size="sm" rightIcon={<ArrowUpRight className="w-3.5 h-3.5" />}>
              View All Directory
            </Button>
          </Link>
        </CardHeader>
        <CardContent className="p-0 overflow-x-auto">
          {stats?.recentMembers && stats.recentMembers.length > 0 ? (
            <table className="w-full text-left text-xs border-collapse">
              <thead>
                <tr className="border-b border-[#A8A492]/15 bg-[#FFF7EB]/60 text-[#2B2625] font-bold uppercase tracking-wider text-[10px]">
                  <th className="py-3.5 px-6">Student Name</th>
                  <th className="py-3.5 px-6">Student Number</th>
                  <th className="py-3.5 px-6">Course / Program</th>
                  <th className="py-3.5 px-6">ESKULTURA Unit</th>
                  <th className="py-3.5 px-6">Year Level</th>
                  <th className="py-3.5 px-6">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-[#A8A492]/10">
                {stats.recentMembers.map((m) => (
                  <tr key={m.id} className="hover:bg-[#FFF7EB]/40 transition-colors">
                    <td className="py-3.5 px-6 font-bold text-[#2B2625]">
                      {m.surname}, {m.first_name} {m.middle_initial ? m.middle_initial + '.' : ''}
                    </td>
                    <td className="py-3.5 px-6 font-mono font-bold text-[#A56F63]">
                      {m.student_number}
                    </td>
                    <td className="py-3.5 px-6 text-[#2B2625]/80 font-medium truncate max-w-[180px]">
                      {m.program?.name || 'N/A'}
                    </td>
                    <td className="py-3.5 px-6">
                      <Badge variant="neutral" size="sm">
                        {m.eskultura_unit?.name || 'N/A'}
                      </Badge>
                    </td>
                    <td className="py-3.5 px-6 text-[#A8A492] font-semibold">{m.year_level}</td>
                    <td className="py-3.5 px-6">
                      <Badge variant={m.status === 'submitted' ? 'success' : 'warning'} size="sm" dot>
                        {m.status.toUpperCase()}
                      </Badge>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <div className="py-12 text-center text-xs text-[#A8A492] font-medium">
              No registered members found yet.
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};
