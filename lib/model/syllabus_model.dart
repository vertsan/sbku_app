import 'package:sbku_app/domain/entities/syllabus_entity.dart';

class SyllabusModel {
  final String id;
  final String className;
  final String teacherName;
  final String subjectName;
  final String shiftName;
  final String semesterName;
  final String yearName;

  SyllabusModel({
    required this.id,
    required this.className,
    required this.teacherName,
    required this.subjectName,
    required this.shiftName,
    required this.semesterName,
    required this.yearName,
  });

  /// 🔁 Convert MODEL → ENTITY (for saving / storage)
  SyllabusEntity toEntity() {
    return SyllabusEntity(
      id: id,
      classId: className,
      teacherId: teacherName,
      subjectId: subjectName,
      shiftId: shiftName,
      semesterId: semesterName,
      yearId: yearName,
    );
  }

  /// 🔁 Convert ENTITY → MODEL (for UI / forms)
  factory SyllabusModel.fromEntity(SyllabusEntity entity) {
    return SyllabusModel(
      id: entity.id,
      className: entity.classId,
      teacherName: entity.teacherId,
      subjectName: entity.subjectId,
      shiftName: entity.shiftId,
      semesterName: entity.semesterId,
      yearName: entity.yearId,
    );
  }

  /// 🧩 Copy with (useful for edit/update)
  SyllabusModel copyWith({
    String? id,
    String? className,
    String? teacherName,
    String? subjectName,
    String? shiftName,
    String? semesterName,
    String? yearName,
  }) {
    return SyllabusModel(
      id: id ?? this.id,
      className: className ?? this.className,
      teacherName: teacherName ?? this.teacherName,
      subjectName: subjectName ?? this.subjectName,
      shiftName: shiftName ?? this.shiftName,
      semesterName: semesterName ?? this.semesterName,
      yearName: yearName ?? this.yearName,
    );
  }
}
