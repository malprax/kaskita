import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  // Helper ref
  CollectionReference get groupsRef => db.collection('groups');
  CollectionReference get auditLogsRef => db.collection('audit_logs');

  Future<void> logAction({
    required String userId,
    required String action,
    required String module,
    Map<String, dynamic>? payload,
  }) async {
    await auditLogsRef.add({
      'userId': userId,
      'action': action,
      'module': module,
      'at': FieldValue.serverTimestamp(),
      'payload': payload ?? {},
    });
  }
}
