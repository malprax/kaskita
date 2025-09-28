import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'group_model.dart';

class GroupDetailView extends StatelessWidget {
  const GroupDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final g = Get.arguments as GroupModel;
    return Scaffold(
      appBar: AppBar(title: Text(g.name)),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Members'),
            subtitle: Text('Manage members in this group'),
          ), // TODO
          ListTile(
            title: Text('Bills'),
            subtitle: Text('Generate & track periodic bills'),
          ), // TODO
        ],
      ),
    );
  }
}
