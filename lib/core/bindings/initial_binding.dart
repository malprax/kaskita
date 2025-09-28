import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';
import '../../services/firestore_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirestoreService(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
