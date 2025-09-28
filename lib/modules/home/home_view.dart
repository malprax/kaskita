import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../auth/auth_controller.dart';

class HomeView extends GetView<AuthController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RT–Arisan Manager'),
        actions: [
          IconButton(
            onPressed: controller.togglePro,
            icon: const Icon(Icons.workspace_premium_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          _Tile(
            icon: Icons.group,
            title: 'Groups',
            onTap: () => Get.toNamed(Routes.groupList),
          ),
          _Tile(
            icon: Icons.people,
            title: 'Members',
            onTap: () => Get.toNamed(Routes.members),
          ),
          _Tile(
            icon: Icons.receipt_long,
            title: 'Billing',
            onTap: () => Get.toNamed(Routes.billing),
          ),
          _Tile(
            icon: Icons.picture_as_pdf,
            title: 'Export',
            onTap: () => Get.toNamed(Routes.export),
          ),
          _Tile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Get.toNamed(Routes.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.groupForm),
        icon: const Icon(Icons.add),
        label: const Text('New Group'),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
