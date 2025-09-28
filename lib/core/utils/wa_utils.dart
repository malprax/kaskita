import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class WaUtils {
  // Membuat deep-link WA per individu
  static Future<void> openWaIndividual({
    required String phone,
    required String name,
    required String groupName,
    required String periodLabel,
    required num amount,
    required DateTime dueDate,
  }) async {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final dateStr = DateFormat('dd MMM yyyy', 'id_ID').format(dueDate);
    final msg = Uri.encodeComponent(
      'Assalamu’alaikum $name, iuran $groupName periode $periodLabel sebesar ${currency.format(amount)} jatuh tempo $dateStr.\nMohon konfirmasi setelah transfer ya. Terima kasih 🙏',
    );
    final uri = Uri.parse('https://wa.me/$phone?text=$msg');
    if (await canLaunchUrl(uri))
      await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // Broadcast grup ringkas
  static Future<void> openWaBroadcast({
    required String phone, // admin sendiri; pesan untuk di-copy ke grup
    required String groupName,
    required String periodLabel,
    required DateTime dueDate,
    required int nPaid,
    required int nUnpaid,
  }) async {
    final dateStr = DateFormat('dd MMM yyyy', 'id_ID').format(dueDate);
    final msg = Uri.encodeComponent(
      'Pengumuman iuran $groupName periode $periodLabel: mohon diselesaikan sebelum $dateStr.\nYang sudah membayar: $nPaid orang ✅ | Belum: $nUnpaid orang.',
    );
    final uri = Uri.parse('https://wa.me/$phone?text=$msg');
    if (await canLaunchUrl(uri))
      await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
