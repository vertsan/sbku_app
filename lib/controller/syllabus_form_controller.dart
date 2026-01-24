import 'package:flutter/material.dart';
import 'package:sbku_app/model/syllabus_model.dart';

class SyllabusFormController {
  final TextEditingController idController;
  final TextEditingController classIdController;
  final TextEditingController teacherIdController;
  final TextEditingController subjectIdController;
  final TextEditingController shiftIdController;
  final TextEditingController semesterIdController;
  final TextEditingController yearIdController;

  SyllabusFormController({SyllabusModel? syllabus})
      : idController = TextEditingController(text: syllabus?.id ?? ''),
        classIdController =
            TextEditingController(text: syllabus?.classId ?? ''),
        teacherIdController =
            TextEditingController(text: syllabus?.teacherId ?? ''),
        subjectIdController =
            TextEditingController(text: syllabus?.subjectId ?? ''),
        shiftIdController =
            TextEditingController(text: syllabus?.shiftId ?? ''),
        semesterIdController =
            TextEditingController(text: syllabus?.semesterId ?? ''),
        yearIdController = TextEditingController(text: syllabus?.yearId ?? '');

  SyllabusModel toSyllabusModel() {
    return SyllabusModel(
      id: idController.text.trim(),
      classId: classIdController.text.trim(),
      teacherId: teacherIdController.text.trim(),
      subjectId: subjectIdController.text.trim(),
      shiftId: shiftIdController.text.trim(),
      semesterId: semesterIdController.text.trim(),
      yearId: yearIdController.text.trim(),
    );
  }

  void clearAll() {
    idController.clear();
    classIdController.clear();
    teacherIdController.clear();
    subjectIdController.clear();
  }

  // ---------------------------
  // Dispose
  // ---------------------------

  bool validateAllFields() {
    return idController.text.trim().isNotEmpty &&
        classIdController.text.trim().isNotEmpty &&
        teacherIdController.text.trim().isNotEmpty &&
        subjectIdController.text.trim().isNotEmpty;
  }

  void dispose() {
    idController.dispose();
    classIdController.dispose();
    teacherIdController.dispose();
    subjectIdController.dispose();
  }
}
