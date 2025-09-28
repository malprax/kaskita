import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/wa_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'billing_controller.dart';

class BillingListView extends StatelessWidget {
  const BillingListView({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.put(BillingController());
    // NOTE: di MVP, gunakan argument / provider untuk groupId & nominal default
    final groupId = 'demo-group-id';
    final period = 'monthly';
    final amount = 20000;

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async => c.generateBill(
                    groupId: groupId,
                    period: period,
                    amount: amount,
                  ),
                  child: const Text('Generate Current Cycle'),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(child: Text('TODO: list bills & payments')),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Contoh WA individual (hardcoded demo)
          await WaUtils.openWaIndividual(
            phone: '62812XXXXXXX',
            name: 'Pak Ahmad',
            groupName: 'RT 05',
            periodLabel: 'September 2025',
            amount: amount,
            dueDate: DateTime.now().add(const Duration(days: 3)),
          );
        },
        icon: const Icon(FontAwesomeIcons.whatsapp),
        label: const Text('WA Reminder'),
      ),
    );
  }
}
