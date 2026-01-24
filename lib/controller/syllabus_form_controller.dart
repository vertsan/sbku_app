import 'package:flutter/material.dart';
import 'package:sbku_app/model/syllabus_model.dart';

class SyllabusFormController {
  final TextEditingController idController;
  final TextEditingController classController;
  final TextEditingController teacherController;
  final TextEditingController subjectController;
  final TextEditingController shiftController;
  final TextEditingController semesterController;
  final TextEditingController yearController;

  SyllabusFormController({SyllabusModel? syllabus})
      : idController = TextEditingController(text: syllabus?.id ?? ''),
        classController =
            TextEditingController(text: syllabus?.className ?? ''),
        teacherController =
            TextEditingController(text: syllabus?.teacherName ?? ''),
        subjectController =
            TextEditingController(text: syllabus?.subjectName ?? ''),
        shiftController =
            TextEditingController(text: syllabus?.shiftName ?? ''),
        semesterController =
            TextEditingController(text: syllabus?.semesterName ?? ''),
        yearController = TextEditingController(text: syllabus?.yearName ?? '');

  // Convert form → UI model
  SyllabusModel toSyllabusModel() {
    return SyllabusModel(
      id: idController.text.trim(),
      className: classController.text.trim(),
      teacherName: teacherController.text.trim(),
      subjectName: subjectController.text.trim(),
      shiftName: shiftController.text.trim(),
      semesterName: semesterController.text.trim(),
      yearName: yearController.text.trim(),
    );
  }

  void clearAll() {
    idController.clear();
    classController.clear();
    teacherController.clear();
    subjectController.clear();
    shiftController.clear();
    semesterController.clear();
    yearController.clear();
  }

  bool validateAllFields() {
    return idController.text.trim().isNotEmpty &&
        classController.text.trim().isNotEmpty &&
        teacherController.text.trim().isNotEmpty &&
        subjectController.text.trim().isNotEmpty &&
        shiftController.text.trim().isNotEmpty &&
        semesterController.text.trim().isNotEmpty &&
        yearController.text.trim().isNotEmpty;
  }

  void dispose() {
    idController.dispose();
    classController.dispose();
    teacherController.dispose();
    subjectController.dispose();
    shiftController.dispose();
    semesterController.dispose();
    yearController.dispose();
  }
}
