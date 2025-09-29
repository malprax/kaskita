import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'group_controller.dart';
import 'group_model.dart';

class GroupFormView extends StatefulWidget {
  const GroupFormView({super.key});
  @override
  State<GroupFormView> createState() => _GroupFormViewState();
}

class _GroupFormViewState extends State<GroupFormView> {
  final _form = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  GroupType type = GroupType.rt;
  String period = 'monthly';

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GroupController>();
    return Scaffold(
      appBar: AppBar(title: const Text('New Group')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Group name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<GroupType>(
                value: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: GroupType.rt, child: Text('RT')),
                  DropdownMenuItem(
                    value: GroupType.arisan,
                    child: Text('Arisan'),
                  ),
                  DropdownMenuItem(
                    value: GroupType.keamanan,
                    child: Text('Keamanan'),
                  ),
                ],
                onChanged: (v) => setState(() => type = v ?? GroupType.rt),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: period,
                decoration: const InputDecoration(labelText: 'Period'),
                items: const [
                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                ],
                onChanged: (v) => setState(() => period = v ?? 'monthly'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_form.currentState!.validate()) return;
                    try {
                      await c.createGroup(
                        name: nameCtrl.text.trim(),
                        type: type,
                        period: period,
                      );
                      Get.back();
                    } catch (e) {
                      Get.snackbar(
                        'Limit',
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
