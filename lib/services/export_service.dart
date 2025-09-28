// Placeholder: Anda bisa integrasi excel: ^4.x (paket alternatif),
// atau gunakan CSV sederhana untuk versi awal.
// Disiapkan interface agar mudah diganti ke excel nanti.
import 'dart:typed_data';

class ExportService {
  Future<Uint8List> buildCsvBytes({required List<List<String>> rows}) async {
    final csv = rows.map((r) => r.map(_escape).join(',')).join('\n');
    return Uint8List.fromList(csv.codeUnits);
  }

  String _escape(String v) {
    final needsQuote = v.contains(',') || v.contains('"') || v.contains('\n');
    final q = v.replaceAll('"', '""');
    return needsQuote ? '"$q"' : q;
  }
}
