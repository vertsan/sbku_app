import 'package:flutter/material.dart';
import 'package:sbku_app/domain/entities/syllabus_entity.dart';
import 'package:sbku_app/model/syllabus_model.dart';

class SyllabusFormController {
  final TextEditingController idController;
  final TextEditingController classIdController;
  final TextEditingController teacherIdController;
  final TextEditingController subjectIdController;

  SyllabusFormController({SyllabusModel? syllabus})
      : idController = TextEditingController(text: syllabus?.id ?? ''),
        classIdController =
            TextEditingController(text: syllabus?.classid ?? ''),
        teacherIdController =
            TextEditingController(text: syllabus?.teacherid ?? ''),
        subjectIdController =
            TextEditingController(text: syllabus?.subjectid ?? '');

  SyllabusModel toSyllabusModel() {
    return SyllabusModel(
      entity: SyllabusEntity(
        id: idController.text.trim(),
        classid: classIdController.text.trim(),
        teacherid: teacherIdController.text.trim(),
        subjectid: subjectIdController.text.trim(),
      ),
      id: idController.text.trim(),
      classid: classIdController.text.trim(),
      teacherid: teacherIdController.text.trim(),
      subjectid: subjectIdController.text.trim(),
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
