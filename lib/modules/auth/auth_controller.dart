import 'package:get/get.dart';

class AuthController extends GetxController {
  // Simpel: mock state → ganti dengan FirebaseAuth pada integrasi
  final _loggedIn = true.obs; // set true untuk dev
  final _userIsPro = false.obs; // paywall default free
  final userId = 'demoUser'.obs;

  bool get isLoggedIn => _loggedIn.value;
  bool get userIsPro => _userIsPro.value;

  // Toggle untuk testing
  void togglePro() => _userIsPro.value = !_userIsPro.value;
}
