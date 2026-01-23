import 'package:flutter/material.dart';
import 'package:sbku_app/domain/entities/syllabus_entity.dart';
import 'package:sbku_app/model/syllabus_model.dart';

class SyllabusFormController {
  final TextEditingController idController;
  final TextEditingController classNameController;
  final TextEditingController teacherNameController;
  final TextEditingController subjectNameController;

  SyllabusFormController({SyllabusModel? syllabus})
      : idController = TextEditingController(text: syllabus?.id ?? ''),
        classNameController =
            TextEditingController(text: syllabus?.classId ?? ''),
        teacherNameController =
            TextEditingController(text: syllabus?.teacherId ?? ''),
        subjectNameController =
            TextEditingController(text: syllabus?.subjectId ?? '');

  SyllabusModel toSyllabusModel() {
    return SyllabusModel(
      id: idController.text.trim(),
      classId: classNameController.text.trim(),
      teacherId: teacherNameController.text.trim(),
      subjectId: subjectNameController.text.trim(),
    );
  }

  void clearAll() {
    idController.clear();
    classNameController.clear();
    teacherNameController.clear();
    subjectNameController.clear();
  }

  // ---------------------------
  // Dispose
  // ---------------------------

  bool validateAllFields() {
    return idController.text.trim().isNotEmpty &&
        classNameController.text.trim().isNotEmpty &&
        teacherNameController.text.trim().isNotEmpty &&
        subjectNameController.text.trim().isNotEmpty;
  }

  void dispose() {
    idController.dispose();
    classNameController.dispose();
    teacherNameController.dispose();
    subjectNameController.dispose();
  }
}
