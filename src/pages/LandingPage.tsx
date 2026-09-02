import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../hooks/useAuth';
import { ArrowRight, LogIn, ShieldCheck } from 'lucide-react';
import { Button } from '../components/ui/Button';

export const LandingPage: React.FC = () => {
  const { user, isAdmin } = useAuth();

  const officialUnits = [
    {
      name: 'LIKHA ESKULTURA',
      category: 'Visual Arts & Design',
      desc: 'Traditional illustration, painting, digital media, sculpting, and art gallery curation.',
    },
    {
      name: 'RITMO ESKULTURA',
      category: 'Dance & Movement',
      desc: 'Contemporary, folk, street dance, choreography, and rhythmic performance expressions.',
    },
    {
      name: 'TEATRO ESKULTURA',
      category: 'Theatre & Stage Arts',
      desc: 'Dramatic arts, musical theatre, playwriting, stage direction, and character embodiment.',
    },
    {
      name: 'HIMIG ESKULTURA',
      category: 'Music & Chorale',
      desc: 'Vocal music, chorale arrangements, instrumental ensembles, and sonic compositions.',
    },
    {
      name: 'KATHA ESKULTURA',
      category: 'Literary & Creative Writing',
      desc: 'Poetry, fiction, journalism, storytelling, spoken word, and creative publications.',
    },
  ];

  return (
    <div className="min-h-screen bg-[#FFF7EB] text-[#2B2625] flex flex-col selection:bg-[#A56F63] selection:text-white">
      {/* Navigation Header */}
      <header className="border-b border-[#A8A492]/20 bg-white/90 backdrop-blur-md sticky top-0 z-40">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-20 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <img
              src="/logo.png"
              alt="ESKULTURA Logo"
              className="w-11 h-11 rounded-2xl object-contain border border-[#A8A492]/30 shadow-xs bg-white"
            />
            <div>
              <span className="text-xl font-black tracking-tight text-[#2B2625] font-['Outfit']">
                ESKULTURA
              </span>
              <span className="text-[10px] uppercase font-bold tracking-widest text-[#A56F63] block -mt-1">
                Student Membership Portal
              </span>
            </div>
          </div>

          <div className="flex items-center gap-2 sm:gap-3">
            {user ? (
              <Link to={isAdmin ? '/admin/dashboard' : '/student/dashboard'}>
                <Button variant="primary" size="sm" rightIcon={<ArrowRight className="w-4 h-4" />}>
                  Go to {isAdmin ? 'Admin Console' : 'My Dashboard'}
                </Button>
              </Link>
            ) : (
              <>
                <Link to="/admin/login">
                  <Button
                    variant="ghost"
                    size="sm"
                    className="text-[#2B2625] hover:text-[#A56F63] text-xs hidden sm:inline-flex"
                    leftIcon={<ShieldCheck className="w-4 h-4 text-[#A56F63]" />}
                  >
                    Admin Login
                  </Button>
                </Link>
                <Link to="/login">
                  <Button variant="outline" size="sm">
                    Student Login
                  </Button>
                </Link>
                <Link to="/register">
                  <Button variant="primary" size="sm" rightIcon={<ArrowRight className="w-4 h-4" />}>
                    Register Now
                  </Button>
                </Link>
              </>
            )}
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative pt-16 pb-20 px-4 sm:px-6 lg:px-8 max-w-5xl mx-auto text-center">
        <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-[#A56F63]/10 border border-[#A56F63]/25 text-[#A56F63] text-xs font-bold mb-6">
          <span>Official Membership & Data Entry System</span>
        </div>

        <h1 className="text-4xl sm:text-6xl font-black tracking-tight text-[#2B2625] leading-tight mb-6 font-['Outfit']">
          Shape Culture. Express Art. <br />
          <span className="text-[#A56F63]">Be Part of ESKULTURA.</span>
        </h1>

        <p className="text-sm sm:text-base text-[#2B2625]/80 max-w-2xl mx-auto mb-10 leading-relaxed font-medium">
          The central registration platform for students to join ESKULTURA. Complete your membership profile, upload your credentials, digitally sign, and choose your artistic unit.
        </p>

        <div className="flex flex-col sm:flex-row items-center justify-center gap-4 max-w-md mx-auto">
          <Link to="/register" className="w-full sm:w-auto">
            <Button size="lg" className="w-full font-bold shadow-md" rightIcon={<ArrowRight className="w-5 h-5" />}>
              Start Student Registration
            </Button>
          </Link>
          <Link to="/login" className="w-full sm:w-auto">
            <Button variant="outline" size="lg" className="w-full font-semibold" leftIcon={<LogIn className="w-5 h-5" />}>
              Student Sign In
            </Button>
          </Link>
        </div>
      </section>

      {/* 4-Step Registration Process */}
      <section className="py-16 bg-white border-y border-[#A8A492]/20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center max-w-xl mx-auto mb-12">
            <span className="text-xs font-bold uppercase tracking-wider text-[#A56F63]">Process</span>
            <h2 className="text-2xl sm:text-3xl font-black text-[#2B2625] font-['Outfit'] mt-1">
              4-Step Membership Registration
            </h2>
            <p className="text-xs sm:text-sm text-[#A8A492] font-medium mt-1">
              Fast, modern, and completely digital student onboarding.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {[
              {
                step: '01',
                title: 'Create Account',
                desc: 'Sign up with your student email or continue seamlessly with Google OAuth.',
              },
              {
                step: '02',
                title: 'Profile Information',
                desc: 'Input your personal details, student number, academic degree, and contact info.',
              },
              {
                step: '03',
                title: 'Photo & E-Signature',
                desc: 'Upload your 1x1 formal ID picture and create your digital signature on canvas.',
              },
              {
                step: '04',
                title: 'Review & Submit',
                desc: 'Verify all your information on the summary screen and generate your member slip.',
              },
            ].map((s) => (
              <div
                key={s.step}
                className="bg-[#FFF7EB]/50 border border-[#A8A492]/20 rounded-3xl p-6 text-left hover:border-[#A56F63]/50 transition-all group"
              >
                <div className="text-xs font-mono font-black text-[#A56F63] mb-3">
                  STEP {s.step}
                </div>
                <h3 className="text-base font-bold text-[#2B2625] mb-2 font-['Outfit']">{s.title}</h3>
                <p className="text-xs text-[#2B2625]/70 leading-relaxed font-medium">{s.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Official ESKULTURA Units */}
      <section className="py-20 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
        <div className="text-center max-w-xl mx-auto mb-12">
          <span className="text-xs font-bold uppercase tracking-wider text-[#A56F63]">Artistic Wings</span>
          <h2 className="text-2xl sm:text-3xl font-black text-[#2B2625] font-['Outfit'] mt-1">
            Official ESKULTURA Units
          </h2>
          <p className="text-xs sm:text-sm text-[#A8A492] font-medium mt-1">
            Find your creative discipline in one of our five recognized artistic wings.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-5 gap-5">
          {officialUnits.map((u) => (
            <div
              key={u.name}
              className="p-6 rounded-3xl bg-white border border-[#A8A492]/25 hover:border-[#A56F63] hover:shadow-sm transition-all text-left flex flex-col justify-between"
            >
              <div>
                <span className="text-[10px] font-bold uppercase tracking-wider text-[#A8A492] block mb-1">
                  {u.category}
                </span>
                <h4 className="text-base font-black text-[#2B2625] mb-2 font-['Outfit']">
                  {u.name}
                </h4>
                <p className="text-xs text-[#2B2625]/70 leading-relaxed font-medium">{u.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Minimalist Footer */}
      <footer className="mt-auto border-t border-[#A8A492]/20 bg-white py-8 text-xs text-[#A8A492] text-center font-medium">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col sm:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-2.5">
            <img
              src="/logo.png"
              alt="Logo"
              className="w-6 h-6 rounded-lg object-contain bg-white"
            />
            <span className="font-bold text-[#2B2625]">ESKULTURA</span>
            <span>— Student Registration and Membership Portal</span>
          </div>
          <div>
            <Link
              to="/admin/login"
              className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-[#FFF7EB] border border-[#A8A492]/30 text-[#A56F63] hover:bg-[#A56F63] hover:text-white transition-all font-bold"
            >
              <ShieldCheck className="w-3.5 h-3.5" />
              <span>Administrator Portal</span>
            </Link>
          </div>
        </div>
      </footer>
    </div>
  );
};
