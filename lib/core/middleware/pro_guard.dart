import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';

class ProGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    return (auth.userIsPro) ? null : const RouteSettings(name: '/paywall');
  }
}
