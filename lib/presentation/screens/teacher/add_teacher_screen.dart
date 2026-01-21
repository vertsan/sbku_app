import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbku_app/model/teacher_model.dart' as tm;

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  final _id = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  String? gender, specialization, userid, facultyid;
  File? image;

  final genders = ['ប្រុស', 'ស្រី'];
  final specializations = ['Computer Science', 'Math', 'Physics'];
  final userids = ['U001', 'U002'];
  final faculties = ['F001', 'F002'];

  Future<void> _pick(ImageSource src) async {
    Navigator.pop(context);
    final img = await _picker.pickImage(source: src);
    if (img != null) setState(() => image = File(img.path));
  }

  void _pickImage() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pickTile(Icons.photo, 'វិចិត្រសាល', ImageSource.gallery),
          _pickTile(Icons.camera_alt, 'ថតរូប', ImageSource.camera),
        ],
      ),
    );
  }

  ListTile _pickTile(IconData i, String t, ImageSource s) => ListTile(
        leading: Icon(i, color: const Color(0xFFFF5722)),
        title: Text(t),
        onTap: () => _pick(s),
      );

  void _save() {
    if (!_formKey.currentState!.validate() ||
        [gender, specialization, userid, facultyid].contains(null)) {
      _snack('សូមបំពេញព័ត៌មានទាំងអស់', Colors.red);
      return;
    }

    Navigator.pop(
      context,
      tm.TeacherModel(
        teacherid: DateTime.now().millisecondsSinceEpoch.toString(),
        id: _id.text,
        fullName: _name.text,
        gender: gender!,
        specalization: specialization!,
        phone: _phone.text,
        email: _email.text,
        userid: userid!,
        facultyid: facultyid!,
        imagePath: image?.path,
      ),
    );
  }

  void _snack(String m, Color c) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(m), backgroundColor: c),
      );

  @override
  void dispose() {
    _id.dispose();
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5722),
        title: const Text('បន្ថែមគ្រូបង្រៀន'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _text(_id, 'អត្តលេខ'),
            _text(_name, 'ឈ្មោះពេញ'),
            _drop('ភេទ', gender, genders, (v) => setState(() => gender = v)),
            _drop('ឯកទេស', specialization, specializations,
                (v) => setState(() => specialization = v)),
            _text(_phone, 'លេខទូរសព្ទ'),
            _text(_email, 'អ៊ីមែល'),
            _drop(
                'User ID', userid, userids, (v) => setState(() => userid = v)),
            _drop('Faculty ID', facultyid, faculties,
                (v) => setState(() => facultyid = v)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: Text(image == null ? 'បញ្ចូលរូបភាព' : 'រូបភាពបានជ្រើស'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722)),
            ),
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.file(image!, height: 200, fit: BoxFit.cover),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D4C41)),
              child:
                  const Text('រក្សាទុក', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(TextEditingController c, String l) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: c,
          decoration: InputDecoration(labelText: l, filled: true),
          validator: (v) => v!.isEmpty ? 'សូមបំពេញព័ត៌មាននេះ' : null,
        ),
      );

  Widget _drop(String l, String? v, List<String> items,
          Function(String?) onChanged) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButtonFormField<String>(
          value: v,
          decoration: InputDecoration(labelText: l, filled: true),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          validator: (v) => v == null ? 'សូមជ្រើសរើស' : null,
        ),
      );
}
