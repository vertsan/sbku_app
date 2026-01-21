import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbku_app/model/teacher_model.dart';

class EditTeacherScreen extends StatefulWidget {
  final TeacherModel teacher;
  const EditTeacherScreen({super.key, required this.teacher});

  @override
  State<EditTeacherScreen> createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController id;
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController userid;
  late TextEditingController facultyid;

  String? gender;
  String? specialization;

  File? image;
  String? oldImage;

  final genders = ['ប្រុស', 'ស្រី'];
  final specializations = [
    'Computer Science',
    'Mathematics',
    'Physics',
    'Chemistry'
  ];

  @override
  void initState() {
    super.initState();
    final t = widget.teacher;
    id = TextEditingController(text: t.id);
    name = TextEditingController(text: t.fullName);
    phone = TextEditingController(text: t.phone);
    email = TextEditingController(text: t.email);
    userid = TextEditingController(text: t.userid);
    facultyid = TextEditingController(text: t.facultyid);
    gender = t.gender;
    specialization = t.specalization;
    oldImage = t.imagePath;
  }

  Future<void> _pick(ImageSource src) async {
    Navigator.pop(context);
    final img = await _picker.pickImage(source: src);
    if (img != null)
      setState(() {
        image = File(img.path);
        oldImage = null;
      });
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

  ListTile _pickTile(IconData i, String t, ImageSource s) =>
      ListTile(leading: Icon(i), title: Text(t), onTap: () => _pick(s));

  void _update() {
    if (!_formKey.currentState!.validate() ||
        gender == null ||
        specialization == null) {
      _snack('សូមបំពេញព័ត៌មានទាំងអស់');
      return;
    }

    Navigator.pop(
      context,
      widget.teacher.copyWith(
        id: id.text,
        fullName: name.text,
        gender: gender,
        specalization: specialization,
        phone: phone.text,
        email: email.text,
        userid: userid.text,
        facultyid: facultyid.text,
        imagePath: image?.path ?? oldImage,
      ),
    );
  }

  void _snack(String m) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(m), backgroundColor: Colors.red));

  @override
  void dispose() {
    id.dispose();
    name.dispose();
    phone.dispose();
    email.dispose();
    userid.dispose();
    facultyid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5722),
        title: const Text('កែប្រែព័ត៌មានគ្រូបង្រៀន'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _text(id, 'អត្តលេខ'),
            _text(name, 'ឈ្មោះពេញ'),
            _drop('ភេទ', gender, genders, (v) => setState(() => gender = v)),
            _drop('ឯកទេស', specialization, specializations,
                (v) => setState(() => specialization = v)),
            _text(phone, 'លេខទូរសព្ទ'),
            _text(email, 'អ៊ីមែល'),
            _text(userid, 'User ID'),
            _text(facultyid, 'Faculty ID'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('ប្តូររូបភាព'),
            ),
            if (image != null || oldImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.file(
                  image ?? File(oldImage!),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _update,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722)),
              child:
                  const Text('កែប្រែ', style: TextStyle(color: Colors.white)),
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
