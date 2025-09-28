import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'members_controller.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key});
  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  final c = Get.put(MembersController());
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: pass real groupId via arguments
    c.init('demo-group-id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: phoneCtrl,
                    decoration: const InputDecoration(
                      labelText: 'WA Phone (62...)',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () =>
                      c.add(name: nameCtrl.text, phone: phoneCtrl.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (c.loading.value)
                return const Center(child: CircularProgressIndicator());
              return ListView.builder(
                itemCount: c.members.length,
                itemBuilder: (_, i) {
                  final m = c.members[i];
                  return ListTile(
                    title: Text(m['name']),
                    subtitle: Text(m['phone']),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
