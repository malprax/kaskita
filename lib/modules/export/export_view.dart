import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import '../../services/pdf_service.dart';

class ExportView extends StatelessWidget {
  const ExportView({super.key});
  @override
  Widget build(BuildContext context) {
    final pdf = PdfService();
    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: FutureBuilder(
        future: pdf.buildPeriodRecap(
          groupName: 'RT 05',
          cycleLabel: 'September 2025',
          generatedAt: DateTime.now(),
          rows: [
            PaymentRow(
              memberName: 'Pak Ahmad',
              amount: 20000,
              paidAt: DateTime.now(),
            ),
            PaymentRow(memberName: 'Bu Siti', amount: 20000, paidAt: null),
          ],
          brandTitle: 'RT 05 – Admin',
        ),
        builder: (ctx, snap) {
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          return PdfPreview(build: (fmt) async => snap.data!);
        },
      ),
    );
  }
}
