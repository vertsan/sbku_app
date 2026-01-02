import 'package:flutter/material.dart';

// Attendance Model
class AttendanceModel {
  final String id;
  final String studentId;
  final String studentName;
  final String facultyId;
  final String facultyName;
  final String majorId;
  final String majorName;
  final String shiftId;
  final String shiftName;
  final String classId;
  final String className;
  final String yearId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isPresent;

  AttendanceModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.facultyId,
    required this.facultyName,
    required this.majorId,
    required this.majorName,
    required this.shiftId,
    required this.shiftName,
    required this.classId,
    required this.className,
    required this.yearId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isPresent,
  });

  String get avatarLetter =>
      studentName.isNotEmpty ? studentName[0].toUpperCase() : '?';

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
  String get timeRange => '$startTime - $endTime';
  String get statusLabel => isPresent ? 'មានវត្តមាន' : 'អវត្តមាន';
  Color get statusColor => isPresent ? Colors.green : Colors.red;
}
