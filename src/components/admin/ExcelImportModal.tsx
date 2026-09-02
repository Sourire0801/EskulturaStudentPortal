import React, { useState } from 'react';
import * as XLSX from 'xlsx';
import { supabase } from '../../lib/supabase';
import { useToast } from '../ui/Toast';
import { Modal } from '../ui/Modal';
import { Button } from '../ui/Button';
import { Badge } from '../ui/Badge';
import { UploadCloud, CheckCircle2, FileSpreadsheet, Loader2, Sparkles } from 'lucide-react';
import type { Program, EskulturaUnit } from '../../types/database';

interface ExcelImportModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
  programs: Program[];
  units: EskulturaUnit[];
}

interface ParsedMemberRow {
  email: string;
  surname: string;
  firstName: string;
  middleInitial: string;
  studentNumber: string;
  programName: string;
  yearLevel: string;
  gender: string;
  dateOfBirth: string;
  completeAddress: string;
  contactNumber: string;
  facebookProfile: string;
  achievements: string;
  unitName: string;
  photoUrl: string;
  signatureUrl: string;
}

export const ExcelImportModal: React.FC<ExcelImportModalProps> = ({
  isOpen,
  onClose,
  onSuccess,
  programs,
  units,
}) => {
  const toast = useToast();
  const [file, setFile] = useState<File | null>(null);
  const [parsedRows, setParsedRows] = useState<ParsedMemberRow[]>([]);
  const [parsing, setParsing] = useState(false);
  const [importing, setImporting] = useState(false);
  const [importProgress, setImportProgress] = useState(0);
  const [importStats, setImportStats] = useState<{ success: number; failed: number } | null>(null);

  const resetState = () => {
    setFile(null);
    setParsedRows([]);
    setParsing(false);
    setImporting(false);
    setImportProgress(0);
    setImportStats(null);
  };

  const handleClose = () => {
    if (importing) return;
    resetState();
    onClose();
  };

  const parseExcelFile = async (selectedFile: File) => {
    try {
      setParsing(true);
      setFile(selectedFile);

      const buffer = await selectedFile.arrayBuffer();
      const workbook = XLSX.read(buffer, { type: 'array' });
      const firstSheetName = workbook.SheetNames[0];
      const worksheet = workbook.Sheets[firstSheetName];
      const rawData = XLSX.utils.sheet_to_json<Record<string, any>>(worksheet, { defval: '' });

      if (rawData.length === 0) {
        toast.error('Empty File', 'The selected spreadsheet has no data rows.');
        setParsing(false);
        return;
      }

      const rows: ParsedMemberRow[] = rawData.map((row, idx) => {
        // Find email
        const emailKey = Object.keys(row).find((k) => /email/i.test(k));
        const email = (emailKey ? row[emailKey] : `member${idx + 1}@eskultura.edu.ph`)
          .toString()
          .trim()
          .toLowerCase();

        // Find Name
        const nameKey = Object.keys(row).find((k) => /name|complete name/i.test(k));
        const rawName = nameKey ? row[nameKey].toString().trim() : '';
        let surname = '';
        let firstName = '';
        let middleInitial = '';

        if (rawName.includes(',')) {
          const parts = rawName.split(',').map((p: string) => p.trim());
          surname = parts[0] || '';
          firstName = parts[1] || '';
          middleInitial = (parts[2] || '').replace(/\./g, '').trim();
        } else {
          const words = rawName.split(' ').filter(Boolean);
          if (words.length === 1) {
            surname = words[0];
            firstName = words[0];
          } else if (words.length > 1) {
            surname = words[words.length - 1];
            firstName = words.slice(0, -1).join(' ');
          } else {
            surname = email.split('@')[0] || 'Member';
            firstName = 'Student';
          }
        }

        // Student Number
        const snKey = Object.keys(row).find((k) => /student\s*number|id\s*number/i.test(k));
        let studentNumber = snKey ? row[snKey].toString().replace(/\s+/g, '').trim() : '';
        if (!studentNumber) studentNumber = `2024-${String(1000 + idx)}`;

        // Course / Program
        const progKey = Object.keys(row).find((k) => /course|program/i.test(k));
        const programName = progKey ? row[progKey].toString().trim() : 'General Education';

        // Year Level
        const ylKey = Object.keys(row).find((k) => /year\s*level|year/i.test(k));
        const rawYl = ylKey ? row[ylKey].toString().toLowerCase() : '';
        let yearLevel = 'First Year';
        if (rawYl.includes('2') || rawYl.includes('second')) yearLevel = 'Second Year';
        else if (rawYl.includes('3') || rawYl.includes('third')) yearLevel = 'Third Year';
        else if (rawYl.includes('4') || rawYl.includes('fourth')) yearLevel = 'Fourth Year';

        // Gender
        const genderKey = Object.keys(row).find((k) => /gender|sex/i.test(k));
        const rawGender = genderKey ? row[genderKey].toString().toLowerCase().trim() : '';
        let gender = 'Prefer not to say';
        if (rawGender === 'female' || rawGender.startsWith('f')) gender = 'Female';
        else if (rawGender === 'male' || rawGender.startsWith('m')) gender = 'Male';

        // Date of Birth / Age
        const dobKey = Object.keys(row).find((k) => /birth|dob/i.test(k));
        const ageKey = Object.keys(row).find((k) => /age/i.test(k));
        const rawDob = dobKey ? row[dobKey].toString().trim() : '';
        const rawAge = ageKey ? parseInt(row[ageKey]) || 20 : 20;
        let dateOfBirth = `${new Date().getFullYear() - rawAge}-01-01`;

        if (rawDob.includes('/')) {
          const parts = rawDob.split('/');
          if (parts.length === 3) {
            let [m, d, y] = parts;
            if (y.length === 2) y = '20' + y;
            dateOfBirth = `${y}-${m.padStart(2, '0')}-${d.padStart(2, '0')}`;
          }
        }

        // Address
        const addrKey = Object.keys(row).find((k) => /address/i.test(k));
        const completeAddress = addrKey ? row[addrKey].toString().trim() : 'Laguna, Philippines';

        // Contact Number
        const contactKey = Object.keys(row).find((k) => /contact|phone|mobile/i.test(k));
        const contactNumber = contactKey ? row[contactKey].toString().trim() : '09000000000';

        // Facebook
        const fbKey = Object.keys(row).find((k) => /fb|facebook/i.test(k));
        const facebookProfile = fbKey ? row[fbKey].toString().trim() : 'https://facebook.com';

        // Unit
        const unitKey = Object.keys(row).find((k) => /unit|eskultura/i.test(k));
        const unitName = unitKey ? row[unitKey].toString().trim() : 'LIKHA ESKULTURA';

        // Achievements
        const achKey = Object.keys(row).find((k) => /achievement|award/i.test(k));
        const achievements = achKey ? row[achKey].toString().trim() : 'NONE';

        // Photo & Signature URLs
        const photoKey = Object.keys(row).find((k) => /picture|photo|1\s*x\s*1/i.test(k));
        const photoUrl = photoKey ? row[photoKey].toString().trim() : '';

        const sigKey = Object.keys(row).find((k) => /signature|e-signature/i.test(k));
        const signatureUrl = sigKey ? row[sigKey].toString().trim() : '';

        return {
          email,
          surname,
          firstName,
          middleInitial,
          studentNumber,
          programName,
          yearLevel,
          gender,
          dateOfBirth,
          completeAddress,
          contactNumber,
          facebookProfile,
          achievements,
          unitName,
          photoUrl,
          signatureUrl,
        };
      });

      setParsedRows(rows);
      toast.success('Spreadsheet Parsed', `Found ${rows.length} member records ready for import.`);
    } catch (err: any) {
      console.error('Parse Excel Error:', err);
      toast.error('Parsing Failed', err.message || 'Could not parse Excel file.');
    } finally {
      setParsing(false);
    }
  };

  const handleStartImport = async () => {
    if (parsedRows.length === 0) return;

    setImporting(true);
    setImportProgress(0);
    let successCount = 0;
    let failedCount = 0;

    // Cache or create missing programs & units
    const programMap = new Map<string, string>();
    programs.forEach((p) => programMap.set((p.name || '').toLowerCase(), p.id));

    const unitMap = new Map<string, string>();
    units.forEach((u) => unitMap.set((u.name || '').toLowerCase(), u.id));

    for (let i = 0; i < parsedRows.length; i++) {
      const row = parsedRows[i];

      try {
        const progKey = (row.programName || 'General Education').toLowerCase();
        let progId: string | undefined = programMap.get(progKey);
        if (!progId) {
          const { data: newProg } = await supabase
            .from('programs')
            .insert({ name: row.programName || 'General Education', is_active: true })
            .select('id')
            .single();
          if (newProg?.id) {
            progId = newProg.id;
            programMap.set(progKey, newProg.id);
          }
        }

        const unitLookupKey = (row.unitName || 'LIKHA ESKULTURA').toLowerCase();
        let unitId: string | undefined = unitMap.get(unitLookupKey);
        if (!unitId) {
          const { data: newUnit } = await supabase
            .from('eskultura_units')
            .insert({ name: row.unitName || 'LIKHA ESKULTURA', is_active: true })
            .select('id')
            .single();
          if (newUnit?.id) {
            unitId = newUnit.id;
            unitMap.set(unitLookupKey, newUnit.id);
          }
        }

        // 3. Create or Update Profile
        let userId: string | null = null;
        const { data: existingProfile } = await supabase
          .from('profiles')
          .select('id')
          .eq('email', row.email)
          .maybeSingle();

        if (existingProfile) {
          userId = existingProfile.id;
        } else {
          const newUserId = crypto.randomUUID();
          const { error: profileErr } = await supabase.from('profiles').insert({
            id: newUserId,
            email: row.email,
            role: 'student',
          });
          if (!profileErr) {
            userId = newUserId;
          }
        }

        if (userId) {
          // 4. Upsert student profile
          await supabase.from('student_profiles').upsert(
            {
              user_id: userId,
              surname: row.surname,
              first_name: row.firstName,
              middle_initial: row.middleInitial,
              student_number: row.studentNumber,
              program_id: progId,
              year_level: row.yearLevel,
              gender: row.gender,
              date_of_birth: row.dateOfBirth,
              complete_address: row.completeAddress,
              contact_number: row.contactNumber,
              facebook_profile: row.facebookProfile,
              achievements: row.achievements,
              eskultura_unit_id: unitId,
              photo_url: row.photoUrl || null,
              signature_url: row.signatureUrl || null,
              status: 'submitted',
            },
            { onConflict: 'student_number' }
          );
          successCount++;
        } else {
          failedCount++;
        }
      } catch (err) {
        console.error(`Row ${i} import error:`, err);
        failedCount++;
      }

      setImportProgress(Math.round(((i + 1) / parsedRows.length) * 100));
    }

    setImportStats({ success: successCount, failed: failedCount });
    setImporting(false);
    toast.success('Import Completed', `Successfully imported ${successCount} member records.`);
    onSuccess();
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={handleClose}
      title="Bulk Import Members from Excel / CSV"
      description="Upload an .xlsx or .csv spreadsheet to automatically add members into the ESKULTURA system."
      maxWidth="3xl"
    >
      <div className="space-y-6 text-left">
        {!file && (
          <div className="border-2 border-dashed border-slate-300 rounded-3xl p-8 text-center hover:border-indigo-500 hover:bg-indigo-50/30 transition-all cursor-pointer relative">
            <input
              type="file"
              accept=".xlsx, .xls, .csv"
              onChange={(e) => {
                if (e.target.files && e.target.files[0]) {
                  parseExcelFile(e.target.files[0]);
                }
              }}
              className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
            />
            <div className="w-14 h-14 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center mx-auto mb-3">
              <UploadCloud className="w-7 h-7" />
            </div>
            <h4 className="text-sm font-bold text-slate-800">
              Drag & Drop your Excel (.xlsx / .csv) file here
            </h4>
            <p className="text-xs text-slate-500 mt-1">
              Supports Google Forms responses, enrollment exports, or standard member spreadsheets
            </p>
            <div className="mt-4">
              <Button size="sm" variant="outline" type="button">
                Browse Files
              </Button>
            </div>
          </div>
        )}

        {parsing && (
          <div className="py-8 text-center space-y-3">
            <Loader2 className="w-8 h-8 text-indigo-600 animate-spin mx-auto" />
            <p className="text-xs font-semibold text-slate-600">Reading and mapping Excel columns...</p>
          </div>
        )}

        {parsedRows.length > 0 && !parsing && (
          <div className="space-y-4">
            {/* File Info Bar */}
            <div className="flex flex-wrap items-center justify-between gap-3 p-3.5 rounded-2xl bg-slate-50 border border-slate-200">
              <div className="flex items-center gap-3">
                <div className="w-9 h-9 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center">
                  <FileSpreadsheet className="w-5 h-5" />
                </div>
                <div>
                  <span className="text-xs font-bold text-slate-900 block truncate max-w-xs">
                    {file?.name}
                  </span>
                  <span className="text-[11px] text-slate-500">
                    {parsedRows.length} Rows Detected & Mapped
                  </span>
                </div>
              </div>

              {!importing && !importStats && (
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={resetState}
                  className="text-xs text-slate-600"
                >
                  Choose Different File
                </Button>
              )}
            </div>

            {/* Progress Bar */}
            {importing && (
              <div className="space-y-2 p-4 rounded-2xl bg-indigo-50/50 border border-indigo-100">
                <div className="flex items-center justify-between text-xs font-bold text-indigo-900">
                  <span className="flex items-center gap-2">
                    <Loader2 className="w-3.5 h-3.5 animate-spin text-indigo-600" />
                    Importing member records into Supabase...
                  </span>
                  <span>{importProgress}%</span>
                </div>
                <div className="w-full h-2 bg-slate-200 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-indigo-600 rounded-full transition-all duration-300"
                    style={{ width: `${importProgress}%` }}
                  />
                </div>
              </div>
            )}

            {/* Import Stats Summary */}
            {importStats && (
              <div className="p-4 rounded-2xl bg-emerald-50 border border-emerald-200 flex items-center justify-between">
                <div className="flex items-center gap-2.5 text-emerald-900">
                  <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0" />
                  <div>
                    <span className="text-xs font-bold block">
                      Import Complete: {importStats.success} members imported successfully!
                    </span>
                    {importStats.failed > 0 && (
                      <span className="text-[11px] text-amber-700 block">
                        {importStats.failed} records could not be imported.
                      </span>
                    )}
                  </div>
                </div>
                <Button variant="primary" size="sm" onClick={handleClose}>
                  Done & View Directory
                </Button>
              </div>
            )}

            {/* Data Preview Table */}
            {!importStats && (
              <div className="border border-slate-200 rounded-2xl overflow-hidden max-h-64 overflow-y-auto">
                <table className="w-full text-left text-xs border-collapse">
                  <thead className="bg-slate-100 sticky top-0 border-b border-slate-200 text-slate-600 font-bold uppercase tracking-wider">
                    <tr>
                      <th className="py-2 px-3">Student Name</th>
                      <th className="py-2 px-3">Student #</th>
                      <th className="py-2 px-3">Program / Course</th>
                      <th className="py-2 px-3">ESKULTURA Unit</th>
                      <th className="py-2 px-3">Year</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {parsedRows.slice(0, 8).map((r, i) => (
                      <tr key={i} className="hover:bg-slate-50">
                        <td className="py-2 px-3 font-semibold text-slate-900">
                          {r.surname}, {r.firstName} {r.middleInitial ? r.middleInitial + '.' : ''}
                        </td>
                        <td className="py-2 px-3 font-mono text-indigo-600">{r.studentNumber}</td>
                        <td className="py-2 px-3 text-slate-600 truncate max-w-[150px]">{r.programName}</td>
                        <td className="py-2 px-3">
                          <Badge variant="primary" size="sm">
                            {r.unitName}
                          </Badge>
                        </td>
                        <td className="py-2 px-3 text-slate-500">{r.yearLevel}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                {parsedRows.length > 8 && (
                  <div className="p-2 text-center text-[11px] font-semibold text-slate-500 bg-slate-50 border-t border-slate-200">
                    + {parsedRows.length - 8} more member records ready for import
                  </div>
                )}
              </div>
            )}
          </div>
        )}

        {/* Footer Actions */}
        <div className="flex items-center justify-end gap-3 pt-4 border-t border-slate-100">
          <Button variant="outline" size="sm" onClick={handleClose} disabled={importing}>
            {importStats ? 'Close' : 'Cancel'}
          </Button>

          {parsedRows.length > 0 && !importStats && (
            <Button
              variant="primary"
              size="sm"
              onClick={handleStartImport}
              isLoading={importing}
              leftIcon={<Sparkles className="w-4 h-4" />}
            >
              Confirm & Import {parsedRows.length} Members
            </Button>
          )}
        </div>
      </div>
    </Modal>
  );
};
