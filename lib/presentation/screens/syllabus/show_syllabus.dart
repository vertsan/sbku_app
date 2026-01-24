import 'package:flutter/material.dart';
import 'package:sbku_app/data/dummy_staff.dart';
import 'package:sbku_app/data/dummy_syllabus.dart';
import 'package:sbku_app/presentation/widgets/appbar_widget.dart';

class ShowSyllabusScreen extends StatelessWidget {
  final String syllabusId;
  const ShowSyllabusScreen({super.key, required this.syllabusId});

  @override
  Widget build(BuildContext context) {
    final syllabus = dummySyllabus.firstWhere((s) => s.id == syllabusId);

    return Scaffold(
      appBar: AppBarWidget(
        title: "ព័ត៌មានមុខវិជ្ជា",
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person),
            ),
            const SizedBox(height: 20),
            _row('Syllabus ID', syllabus.id),
            _row('Class ID', syllabus.classId),
            _row('Subject ID', syllabus.subjectId),
            _row('Teacher ID', syllabus.teacherId),
            _row('Shift ID', syllabus.shiftId),
            _row('Semester ID', syllabus.semesterId),
            _row('Year ID', syllabus.yearId),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 2, child: Text(value)),
        ],
      ),
    );
  }
}
