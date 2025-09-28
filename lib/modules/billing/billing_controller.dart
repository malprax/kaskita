import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../services/firestore_service.dart';

class BillingController extends GetxController {
  final fs = Get.find<FirestoreService>();
  RxBool loading = false.obs;
  RxList<Map<String, dynamic>> bills = <Map<String, dynamic>>[].obs;

  Future<void> generateBill({
    required String groupId,
    required String period,
    required num amount,
    DateTime? base,
  }) async {
    // Generate 1 siklus dari period (weekly/monthly)
    final now = base ?? DateTime.now();
    final due = period == 'weekly'
        ? now.add(const Duration(days: 7))
        : DateTime(now.year, now.month + 1, now.day);
    final label = period == 'weekly'
        ? 'Pekan ${weekOfYear(now)}'
        : DateFormat('MMMM yyyy', 'id_ID').format(now);

    final ref = fs.db.collection('groups').doc(groupId).collection('bills');
    final billDoc = await ref.add({
      'cycleLabel': label,
      'dueDate': due.toIso8601String(),
      'amount': amount,
      'createdAt': DateTime.now().toIso8601String(),
    });

    // Auto-generate payment stubs per member
    final members = await fs.db
        .collection('groups')
        .doc(groupId)
        .collection('members')
        .get();
    for (final m in members.docs) {
      await ref.doc(billDoc.id).collection('payments').doc(m.id).set({
        'memberId': m.id,
        'paidAt': null,
        'method': null,
        'note': null,
      });
    }
  }

  Future<void> togglePaid({
    required String groupId,
    required String billId,
    required String memberId,
    bool setPaid = true,
  }) async {
    await fs.db
        .collection('groups')
        .doc(groupId)
        .collection('bills')
        .doc(billId)
        .collection('payments')
        .doc(memberId)
        .update({'paidAt': setPaid ? DateTime.now().toIso8601String() : null});
  }

  int weekOfYear(DateTime d) {
    final firstDayOfYear = DateTime(d.year, 1, 1);
    final diff = d.difference(firstDayOfYear);
    return (diff.inDays / 7).ceil();
  }
}
