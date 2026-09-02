import XLSX from 'xlsx';

const filename = 'ESKULTURA MEMBER RENEWAL AND RECRUITMENT FORM 2026-2027 (Responses).xlsx';
const workbook = XLSX.readFile(filename);
const sheet = workbook.Sheets[workbook.SheetNames[0]];
const jsonData = XLSX.utils.sheet_to_json(sheet, { defval: '' });

const courses = new Set();
const units = new Set();
const yearLevels = new Set();
const genders = new Set();

jsonData.forEach(row => {
  if (row['COURSE:']) courses.add(row['COURSE:'].toString().trim());
  if (row['Which ESKULTURA unit would you like to join?']) units.add(row['Which ESKULTURA unit would you like to join?'].toString().trim());
  if (row['YEAR LEVEL:']) yearLevels.add(row['YEAR LEVEL:'].toString().trim());
  if (row['GENDER:']) genders.add(row['GENDER:'].toString().trim());
});

console.log('Distinct Courses (' + courses.size + '):', Array.from(courses));
console.log('Distinct ESKULTURA Units (' + units.size + '):', Array.from(units));
console.log('Distinct Year Levels:', Array.from(yearLevels));
console.log('Distinct Genders:', Array.from(genders));
