import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.home),
          child: const Text('Continue (Mock Login)'),
        ),
      ),
    );
  }
}
