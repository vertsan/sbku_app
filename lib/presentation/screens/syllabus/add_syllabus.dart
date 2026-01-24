import 'package:flutter/material.dart';
import 'package:sbku_app/controller/syllabus_form_controller.dart';
import 'package:sbku_app/data/dummy_syllabus.dart';
import 'package:sbku_app/model/syllabus_model.dart';
import 'package:sbku_app/presentation/widgets/appbar_widget.dart';
import 'package:sbku_app/presentation/widgets/appbutton_widget.dart';
import 'package:sbku_app/presentation/widgets/custom_text_field.dart';

class AddSyllabusScreen extends StatefulWidget {
  final SyllabusModel? syllabus;

  const AddSyllabusScreen({super.key, this.syllabus});

  @override
  State<AddSyllabusScreen> createState() => _AddSyllabusScreenState();
}

class _AddSyllabusScreenState extends State<AddSyllabusScreen> {
  late final SyllabusFormController _formController;
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formController = SyllabusFormController(syllabus: widget.syllabus);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.syllabus != null;

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Optional: You can add more specific validation if needed
    if (!_formController.validateAllFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isEditing) {
        _updateSyllabus();
      } else {
        _addNewSyllabus();
      }

      if (mounted) {
        _showSuccessMessage();
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        _showErrorMessage(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _updateSyllabus() {
    // Update logic here

    final model = _formController.toSyllabusModel();
    final updateEnity = model.toEntity();

    final index = dummySyllabus.indexWhere((s) => s.id == updateEnity.id);
    if (index != -1) {
      dummySyllabus[index] = updateEnity;
    }
  }

  void _addNewSyllabus() {
    // Add logic here
    final model = _formController.toSyllabusModel();
    dummySyllabus.add(model.toEntity());
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Staff updated successfully'
              : 'Staff added successfully',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Future<void> _handleImageUpload() async {
  //   await _formController.showImageSourceDialog(context);
  //   if (mounted) setState(() {});
  // }

  // // Build profile image widget - supports both mobile & web
  // Widget _buildProfileImage() {
  //   ImageProvider? imageProvider;

  //   if (_formController.hasImage) {
  //     if (kIsWeb) {
  //       imageProvider = MemoryImage(_formController.profileImageBytes!);
  //     } else {
  //       imageProvider = FileImage(_formController.profileImage!);
  //     }
  //   }

  //   return CircleAvatar(
  //     radius: 60,
  //     backgroundColor: Colors.orange.shade100,
  //     backgroundImage: imageProvider,
  //     child: imageProvider == null
  //         ? Icon(
  //             Icons.person,
  //             size: 60,
  //             color: Colors.orange.shade300,
  //           )
  //         : null,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: _isEditing ? 'Edit Staff' : 'Add Staff',
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement share functionality if needed
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              // TODO: Implement profile or other action
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // // Profile Image Section
                // GestureDetector(
                //   onTap: _isLoading ? null : _handleImageUpload,
                //   child: Stack(
                //     alignment: Alignment.bottomRight,
                //     children: [
                //       _buildProfileImage(),
                //       Positioned(
                //         bottom: 0,
                //         right: 0,
                //         child: Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.orange,
                //             shape: BoxShape.circle,
                //             border: Border.all(color: Colors.white, width: 2),
                //           ),
                //           child: const Icon(
                //             Icons.camera_alt,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 8),
                // Text(
                //   'Tap to ${_formController.hasImage ? 'change' : 'add'} photo',
                //   style: TextStyle(
                //     color: Colors.grey.shade600,
                //     fontSize: 12,
                //   ),
                // ),

                // const SizedBox(height: 32),

                // Form Fields
                // CustomTextField(
                //   label: 'អត្តលេខ (ID)',
                //   controller: _formController.idController,
                //   enabled: !_isEditing, // usually ID shouldn't change
                //   // validator: (v) => _formController.validateRequired(v, 'ID'),
                // ),

                CustomTextField(
                  label: 'ថ្នាក់',
                  controller: _formController.classController,
                  // validator: (v) =>
                  //     _formController.validateRequired(v, 'Staff ID'),
                ),

                CustomTextField(
                  label: 'សាស្ត្រាចារ្យ',
                  controller: _formController.teacherController,
                  // validator: (v) =>
                  //     _formController.validateRequired(v, 'Full Name'),
                ),

                CustomTextField(
                  label: 'មុខវិជ្ជា',
                  controller: _formController.subjectController,
                  // validator: (v) =>
                  //     _formController.validateRequired(v, 'Specialization'),
                ),

                const SizedBox(height: 32),

                // Submit Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : AppButton(
                        label: _isEditing ? 'Update Staff' : 'Add Staff',
                        onPressed: _handleSave,
                      ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
