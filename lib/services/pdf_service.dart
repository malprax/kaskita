import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  // Membuat PDF rekap pembayaran satu periode
  Future<Uint8List> buildPeriodRecap({
    required String groupName,
    required String cycleLabel,
    required DateTime generatedAt,
    required List<PaymentRow> rows,
    String?
    brandTitle, // Logo/branding Pro (teks sederhana – bisa diganti image)
  }) async {
    final doc = pw.Document();
    final dateStr = DateFormat('dd MMM yyyy', 'id_ID').format(generatedAt);

    final totalPaid = rows
        .where((e) => e.paidAt != null)
        .fold<num>(0, (sum, e) => sum + e.amount);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (ctx) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                brandTitle ?? 'RT–Arisan Manager',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Rekap Iuran – $groupName'),
              pw.Text('Periode: $cycleLabel  •  Dicetak: $dateStr'),
              pw.SizedBox(height: 12),
              pw.Table(
                border: pw.TableBorder.all(width: 0.3),
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(2),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(3),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Member'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Nominal'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Status'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Tanggal Bayar'),
                      ),
                    ],
                  ),
                  ...rows.map(
                    (r) => pw.TableRow(
                      children: [
                        cell(r.memberName),
                        cell(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(r.amount),
                        ),
                        cell(r.paidAt != null ? 'Lunas' : 'Belum'),
                        cell(
                          r.paidAt != null
                              ? DateFormat(
                                  'dd MMM yyyy',
                                  'id_ID',
                                ).format(r.paidAt!)
                              : '-',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Total Lunas: ' +
                    NumberFormat.currency(
                      locale: 'id_ID',
                      symbol: 'Rp',
                      decimalDigits: 0,
                    ).format(totalPaid),
              ),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  pw.Widget cell(String text) =>
      pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(text));
}

class PaymentRow {
  final String memberName;
  final num amount;
  final DateTime? paidAt;
  PaymentRow({required this.memberName, required this.amount, this.paidAt});
}
