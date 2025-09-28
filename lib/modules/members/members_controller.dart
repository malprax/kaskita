import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';
import '../auth/auth_controller.dart';
import '../group/group_model.dart';

class MembersController extends GetxController {
  final fs = Get.find<FirestoreService>();
  final auth = Get.find<AuthController>();

  late final String groupId;
  RxList<Map<String, dynamic>> members = <Map<String, dynamic>>[].obs;
  RxBool loading = false.obs;

  void init(String gid) {
    groupId = gid;
    fetch();
  }

  Future<void> fetch() async {
    loading.value = true;
    final snap = await fs.db
        .collection('groups')
        .doc(groupId)
        .collection('members')
        .get();
    members.value = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
    loading.value = false;
  }

  Future<void> add({required String name, required String phone}) async {
    await fs.db.collection('groups').doc(groupId).collection('members').add({
      'name': name,
      'phone': phone,
      'status': 'active',
    });
    await fs.logAction(
      userId: auth.userId.value,
      action: 'add_member',
      module: 'members',
      payload: {'groupId': groupId, 'name': name},
    );
    await fetch();
  }
}
