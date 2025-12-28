import 'package:flutter/material.dart';
import 'package:memory_cache/memory_cache.dart';

class AddEditAttendance extends StatefulWidget {
  final bool isEdit;

  const AddEditAttendance({
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<AddEditAttendance> createState() => _AddEditAttendanceState();
}

class _AddEditAttendanceState extends State<AddEditAttendance> {
  static const String attendanceKey = 'attendance_name';

  final TextEditingController _nameController = TextEditingController();
  final MemoryCache _cache = MemoryCache.instance;

  @override
  String? value;

  @override
  void initState() {
    super.initState();
    _readCache();
  }

  void _readCache() {
    setState(() {
      value = MemoryCache.instance.read<String>('attendance_name');
    });
  }

  void _saveAttendance() {
    final String name = _nameController.text.trim();
    if (name.isEmpty) return;

    // Always create if missing, otherwise update
    if (_cache.read<String>(attendanceKey) == null) {
      _cache.create(
        attendanceKey,
        name,
        expiry: const Duration(minutes: 10),
      );
    } else {
      _cache.update(attendanceKey, name);
    }

    Navigator.pop(context);
    _cache.create(attendanceKey, name);
    print('READ AFTER SAVE: ${_cache.read<String>(attendanceKey)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'កែប្រែអវត្តមាន' : 'បញ្ចីអវត្តមាន'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ឈ្មោះសិស្ស',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAttendance,
              child: Text(widget.isEdit ? 'Update' : 'Create'),
            ),
          ],
        ),
      ),
    );
  }
}
