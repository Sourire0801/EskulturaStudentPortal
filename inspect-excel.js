import XLSX from 'xlsx';
import path from 'path';
import { fileURLToPath } from 'url';

const filename = 'ESKULTURA MEMBER RENEWAL AND RECRUITMENT FORM 2026-2027 (Responses).xlsx';
const workbook = XLSX.readFile(filename);

console.log('Sheet Names:', workbook.SheetNames);
const sheetName = workbook.SheetNames[0];
const sheet = workbook.Sheets[sheetName];
const jsonData = XLSX.utils.sheet_to_json(sheet, { defval: '' });

console.log('Total Rows:', jsonData.length);
if (jsonData.length > 0) {
  console.log('Columns:', Object.keys(jsonData[0]));
  console.log('First 2 rows sample:', JSON.stringify(jsonData.slice(0, 2), null, 2));
}
