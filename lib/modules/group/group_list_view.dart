import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import 'group_controller.dart';

class GroupListView extends StatelessWidget {
  const GroupListView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: Obx(() {
        if (c.loading.value)
          return const Center(child: CircularProgressIndicator());
        if (c.groups.isEmpty) return const Center(child: Text('No groups yet'));
        return ListView.builder(
          itemCount: c.groups.length,
          itemBuilder: (_, i) {
            final g = c.groups[i];
            return ListTile(
              title: Text(g.name),
              subtitle: Text('${g.typeToStr(g.type)} • ${g.period}'),
              onTap: () => Get.toNamed(Routes.groupDetail, arguments: g),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.groupForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
