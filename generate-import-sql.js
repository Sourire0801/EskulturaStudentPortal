import XLSX from 'xlsx';
import fs from 'fs';

const filename = 'ESKULTURA MEMBER RENEWAL AND RECRUITMENT FORM 2026-2027 (Responses).xlsx';
const workbook = XLSX.readFile(filename);
const sheet = workbook.Sheets[workbook.SheetNames[0]];
const rows = XLSX.utils.sheet_to_json(sheet, { defval: '' });

// Normalize Programs mapping
function normalizeProgram(course) {
  const c = (course || '').trim();
  if (!c) return 'General Education';
  return c;
}

// Normalize Unit mapping
function normalizeUnit(unit) {
  const u = (unit || '').trim();
  if (!u) return 'LIKHA ESKULTURA';
  return u;
}

// Normalize Year Level
function normalizeYearLevel(yl) {
  const y = (yl || '').trim().toLowerCase();
  if (y.includes('first') || y.includes('1')) return 'First Year';
  if (y.includes('second') || y.includes('2')) return 'Second Year';
  if (y.includes('third') || y.includes('3')) return 'Third Year';
  if (y.includes('fourth') || y.includes('4')) return 'Fourth Year';
  return 'First Year';
}

// Normalize Gender
function normalizeGender(g) {
  const gen = (g || '').trim();
  if (gen.toLowerCase() === 'female') return 'Female';
  if (gen.toLowerCase() === 'male') return 'Male';
  return 'Prefer not to say';
}

// Normalize Student Number
function normalizeStudentNumber(sn, idx) {
  let clean = (sn || '').toString().replace(/\s+/g, '').trim();
  if (!clean) clean = `2024-${String(1000 + idx)}`;
  return clean;
}

// Parse Complete Name (SN, FN, MI)
function parseName(rawName, email) {
  let str = (rawName || '').trim();
  if (!str) {
    const fallback = (email || 'Student Member').split('@')[0];
    return { surname: fallback, firstName: 'Student', middleInitial: '' };
  }

  const parts = str.split(',').map(p => p.trim());
  if (parts.length >= 3) {
    const surname = parts[0];
    const firstName = parts[1];
    const middleInitial = parts[2].replace(/\./g, '').trim();
    return { surname, firstName, middleInitial };
  } else if (parts.length === 2) {
    const surname = parts[0];
    const rest = parts[1].split(' ');
    let middleInitial = '';
    let firstName = rest.join(' ');
    if (rest.length > 1 && rest[rest.length - 1].length <= 2) {
      middleInitial = rest.pop().replace(/\./g, '').trim();
      firstName = rest.join(' ');
    }
    return { surname, firstName, middleInitial };
  } else {
    const words = str.split(' ');
    if (words.length === 1) return { surname: words[0], firstName: words[0], middleInitial: '' };
    const surname = words.pop();
    const firstName = words.join(' ');
    return { surname, firstName, middleInitial: '' };
  }
}

// Date parser
function parseBirthDate(rawDate, rawAge) {
  if (!rawDate) {
    const age = parseInt(rawAge) || 20;
    const year = new Date().getFullYear() - age;
    return `${year}-01-01`;
  }

  const str = rawDate.toString().trim();
  if (str.includes('/')) {
    const parts = str.split('/');
    if (parts.length === 3) {
      let [m, d, y] = parts;
      if (y.length === 2) y = '20' + y;
      return `${y}-${m.padStart(2, '0')}-${d.padStart(2, '0')}`;
    }
  }

  const age = parseInt(rawAge) || 20;
  const year = new Date().getFullYear() - age;
  try {
    const parsed = new Date(`${str} ${year}`);
    if (!isNaN(parsed.getTime())) {
      return parsed.toISOString().slice(0, 10);
    }
  } catch (e) {}

  return `${year}-01-01`;
}

// Generate SQL Script
const sqlLines = [];
sqlLines.push('-- ====================================================================');
sqlLines.push('-- AUTOMATED BULK IMPORT OF 89 ESKULTURA MEMBERS FROM EXCEL');
sqlLines.push('-- ====================================================================\n');

sqlLines.push('-- Step 1: Ensure student_profiles allows imported members without requiring pre-registered auth accounts');
sqlLines.push('ALTER TABLE public.student_profiles ALTER COLUMN user_id DROP NOT NULL;');
sqlLines.push('ALTER TABLE public.student_profiles ADD COLUMN IF NOT EXISTS email TEXT;\n');

// 1. Collect all distinct units and programs
const unitsSet = new Set();
const programsSet = new Set();

rows.forEach(r => {
  unitsSet.add(normalizeUnit(r['Which ESKULTURA unit would you like to join?']));
  programsSet.add(normalizeProgram(r['COURSE:']));
});

sqlLines.push('-- Step 2: Insert distinct ESKULTURA Units');
unitsSet.forEach(u => {
  const esc = u.replace(/'/g, "''");
  sqlLines.push(`INSERT INTO public.eskultura_units (name, is_active) VALUES ('${esc}', true) ON CONFLICT (name) DO NOTHING;`);
});

sqlLines.push('\n-- Step 3: Insert distinct Programs');
programsSet.forEach(p => {
  const esc = p.replace(/'/g, "''");
  sqlLines.push(`INSERT INTO public.programs (name, is_active) VALUES ('${esc}', true) ON CONFLICT (name) DO NOTHING;`);
});

sqlLines.push('\n-- Step 4: Insert Members into student_profiles\n');

// Build member records
rows.forEach((r, idx) => {
  const email = (r['Email'] || r['EMAIL:'] || `member${idx + 1}@eskultura.edu.ph`).trim().toLowerCase();
  const rawName = r['COMPLETE NAME (SN, FN, MI):'];
  const { surname, firstName, middleInitial } = parseName(rawName, email);
  const studentNumber = normalizeStudentNumber(r['STUDENT NUMBER:'], idx + 1);
  const course = normalizeProgram(r['COURSE:']);
  const unit = normalizeUnit(r['Which ESKULTURA unit would you like to join?']);
  const yearLevel = normalizeYearLevel(r['YEAR LEVEL:']);
  const gender = normalizeGender(r['GENDER:']);
  const dateOfBirth = parseBirthDate(r['DATE BIRTH:'], r['AGE:']);
  const address = (r['COMPLETE ADDRESS:'] || 'Laguna, Philippines').toString().replace(/'/g, "''").trim();
  const contactNumber = (r['CONTACT NUMBER:'] || '09000000000').toString().trim();
  const facebook = (r['FB PROFILE LINK:'] || 'https://facebook.com').toString().replace(/'/g, "''").trim();
  const achievements = (r['ACHIEVEMENT(S) / AWARD(S) RECEIVED (Write NONE, if not applicable):'] || 'NONE').toString().replace(/'/g, "''").trim();
  const photoUrl = (r['1 x 1 Formal Picture'] || '').toString().trim();
  const signatureUrl = (r['E-Signature'] || '').toString().trim();
  const status = 'submitted';

  const escSurname = surname.replace(/'/g, "''");
  const escFirstName = firstName.replace(/'/g, "''");
  const escMiddleInitial = middleInitial.replace(/'/g, "''");
  const escEmail = email.replace(/'/g, "''");
  const escStudentNumber = studentNumber.replace(/'/g, "''");
  const escCourse = course.replace(/'/g, "''");
  const escUnit = unit.replace(/'/g, "''");

  const block = `
DO $$
DECLARE
  v_prog_id UUID;
  v_unit_id UUID;
BEGIN
  SELECT id INTO v_prog_id FROM public.programs WHERE name = '${escCourse}' LIMIT 1;
  SELECT id INTO v_unit_id FROM public.eskultura_units WHERE name = '${escUnit}' LIMIT 1;

  INSERT INTO public.student_profiles (
    email,
    surname,
    first_name,
    middle_initial,
    student_number,
    program_id,
    year_level,
    gender,
    date_of_birth,
    complete_address,
    contact_number,
    facebook_profile,
    achievements,
    eskultura_unit_id,
    photo_url,
    signature_url,
    status
  )
  VALUES (
    '${escEmail}',
    '${escSurname}',
    '${escFirstName}',
    '${escMiddleInitial}',
    '${escStudentNumber}',
    v_prog_id,
    '${yearLevel}',
    '${gender}',
    '${dateOfBirth}',
    '${address}',
    '${contactNumber}',
    '${facebook}',
    '${achievements}',
    v_unit_id,
    '${photoUrl}',
    '${signatureUrl}',
    '${status}'
  )
  ON CONFLICT (student_number) DO UPDATE
  SET 
    email = EXCLUDED.email,
    surname = EXCLUDED.surname,
    first_name = EXCLUDED.first_name,
    middle_initial = EXCLUDED.middle_initial,
    program_id = EXCLUDED.program_id,
    year_level = EXCLUDED.year_level,
    gender = EXCLUDED.gender,
    date_of_birth = EXCLUDED.date_of_birth,
    complete_address = EXCLUDED.complete_address,
    contact_number = EXCLUDED.contact_number,
    facebook_profile = EXCLUDED.facebook_profile,
    achievements = EXCLUDED.achievements,
    eskultura_unit_id = EXCLUDED.eskultura_unit_id,
    photo_url = EXCLUDED.photo_url,
    signature_url = EXCLUDED.signature_url,
    status = EXCLUDED.status;
END $$;
`;
  sqlLines.push(block);
});

fs.writeFileSync('supabase/import_members.sql', sqlLines.join('\n'));
console.log('Regenerated supabase/import_members.sql (Foreign Key-safe) with ' + rows.length + ' member entries!');
