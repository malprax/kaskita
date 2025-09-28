import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firestore_service.dart';
import '../auth/auth_controller.dart';
import 'group_model.dart';

class GroupController extends GetxController {
  final fs = Get.find<FirestoreService>();
  final auth = Get.find<AuthController>();

  RxList<GroupModel> groups = <GroupModel>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    loading.value = true;
    final q = await fs.groupsRef
        .where('createdBy', isEqualTo: auth.userId.value)
        .get();
    groups.value = q.docs
        .map((d) => GroupModel.fromMap(d.id, d.data() as Map<String, dynamic>))
        .toList();
    loading.value = false;
  }

  Future<String?> validateFreeLimit() async {
    // Free plan: 1 group max
    if (!auth.userIsPro && groups.length >= 1) {
      return 'Free plan allows only 1 group. Upgrade to Pro for unlimited groups.';
    }
    return null;
  }

  Future<void> createGroup({
    required String name,
    required GroupType type,
    required String period,
    DateTime? nextCycleAt,
  }) async {
    final err = await validateFreeLimit();
    if (err != null) throw err;

    final data = {
      'name': name,
      'type': type == GroupType.rt
          ? 'RT'
          : (type == GroupType.arisan ? 'Arisan' : 'Kajian'),
      'period': period,
      'nextCycleAt': nextCycleAt?.toIso8601String(),
      'createdBy': auth.userId.value,
    };
    final doc = await fs.groupsRef.add(data);
    await fs.logAction(
      userId: auth.userId.value,
      action: 'create',
      module: 'group',
      payload: {'id': doc.id, ...data},
    );
    await fetchGroups();
  }
}
