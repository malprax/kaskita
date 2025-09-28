import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    return auth.isLoggedIn ? null : const RouteSettings(name: Routes.login);
  }
}
