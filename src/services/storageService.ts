import { supabase } from '../lib/supabase';

export const storageService = {
  /**
   * Convert a base64 Data URL to a Blob
   */
  dataUrlToBlob(dataUrl: string): Blob {
    const arr = dataUrl.split(',');
    const mimeMatch = arr[0].match(/:(.*?);/);
    const mime = mimeMatch ? mimeMatch[1] : 'image/png';
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);
    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], { type: mime });
  },

  /**
   * Upload 1x1 Student Photo
   */
  async uploadPhoto(userId: string, file: File): Promise<string> {
    const fileExt = file.name.split('.').pop() || 'jpg';
    const filePath = `${userId}/photo_${Date.now()}.${fileExt}`;

    const { error: uploadError } = await supabase.storage
      .from('student-photos')
      .upload(filePath, file, {
        upsert: true,
        contentType: file.type,
      });

    if (uploadError) {
      throw uploadError;
    }

    const { data } = supabase.storage
      .from('student-photos')
      .getPublicUrl(filePath);

    return data.publicUrl;
  },

  /**
   * Upload Student E-Signature (from Data URL or Blob)
   */
  async uploadSignature(userId: string, signatureDataUrl: string): Promise<string> {
    const blob = this.dataUrlToBlob(signatureDataUrl);
    const filePath = `${userId}/signature_${Date.now()}.png`;

    const { error: uploadError } = await supabase.storage
      .from('student-signatures')
      .upload(filePath, blob, {
        upsert: true,
        contentType: 'image/png',
      });

    if (uploadError) {
      throw uploadError;
    }

    const { data } = supabase.storage
      .from('student-signatures')
      .getPublicUrl(filePath);

    return data.publicUrl;
  },
};
