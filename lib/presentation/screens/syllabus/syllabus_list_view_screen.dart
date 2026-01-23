import 'package:flutter/material.dart';
import 'package:sbku_app/data/dummy_staff.dart'; // assuming this exports List<StaffModel> dummyStaffs
import 'package:sbku_app/data/dummy_syllabus.dart';
import 'package:sbku_app/model/staff_model.dart';
import 'package:sbku_app/model/syllabus_model.dart';
import 'package:sbku_app/presentation/screens/staff/add_staff.dart';
import 'package:sbku_app/presentation/screens/staff/show_staff.dart';
import 'package:sbku_app/presentation/screens/syllabus/add_syllabus.dart';
import 'package:sbku_app/presentation/screens/syllabus/show_syllabus.dart';
import 'package:sbku_app/presentation/widgets/appbar_widget.dart';
import 'package:sbku_app/presentation/widgets/filter_row_widget.dart';
import 'package:sbku_app/presentation/widgets/list_item_widget.dart';

class SyllabusListViewScreen extends StatefulWidget {
  const SyllabusListViewScreen({super.key});

  @override
  State<SyllabusListViewScreen> createState() => _StaffListViewScreenState();
}

class _StaffListViewScreenState extends State<SyllabusListViewScreen> {
  // Filter value
  String? _selectClass;
  String? _selectedDepartment;
  String? _selectedSubject;

  void _showDeleteDialog(SyllabusModel syllabus) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('លុបប្រតិបត្តិការ'),
        content: Text('តើអ្នកប្រាកដថាចង់លុប ${syllabus.subjectId} ឬទេ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('បោះបង់'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                dummySyllabus.removeWhere((s) => s.id == syllabus.id);
              });
              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${syllabus.subjectId} ត្រូវបានលុបដោយជោគជ័យ'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('លុប'),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(SyllabusModel syllabus) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddSyllabusScreen(syllabus: syllabus), // ← rename screen if needed
      ),
    ).then((_) => setState(() {})); // refresh after edit
  }

  void _navigateToAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddStaffScreen(),
      ),
    ).then((_) => setState(() {})); // refresh after add
  }

  @override
  Widget build(BuildContext context) {
    final hasFilter = _selectClass != null;
    _selectedDepartment != null;
    _selectedSubject != null;

    return Scaffold(
      appBar: AppBarWidget.simple(
        title: 'បញ្ជីបុគ្គលិក',
        actions: [
          IconButton(
            onPressed: () {
              // TODO: implement share / export functionality
            },
            icon: const Icon(Icons.share, color: Colors.white),
          ),
          IconButton(
            onPressed: _navigateToAdd,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Row – customize according to your needs
          FilterRowWidget(
            filters: [
              FilterConfig(
                value: _selectClass,
                hint: 'ថ្នាក់',
                items: Set<String>.from(
                  dummySyllabus.map((s) => s.classId),
                ).toList(),
                onChanged: (value) {
                  setState(() => _selectClass = value);
                },
              ),
              // Add more filters if your StaffModel has more filterable fields
              FilterConfig(
                value: _selectedDepartment,
                hint: 'នាយកដ្ឋាន',
                items: Set<String>.from(dummyStaffs.map((s) => s.department))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedDepartment = value),
              ),
            ],
          ),

          // Staff List
          Expanded(
            child: dummySyllabus.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          hasFilter
                              ? 'រកមិនឃើញតារាងមុខវិជ្ជា'
                              : 'មិនទាន់មានតារាងមុខវិជ្ជា',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (hasFilter) ...[
                          const SizedBox(height: 8),
                          Text(
                            'សូមកែប្រែការតម្រង',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: dummySyllabus.length,
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    itemBuilder: (context, index) {
                      final syllabus = dummySyllabus[index];

                      return ListItemWidget<SyllabusModel>(
                        item: syllabus,
                        title: syllabus.classId,
                        subtitle: syllabus.teacherId,
                        // trailingSubtitle: staff.phone,           // optional
                        avatarBackgroundColor: Colors.deepOrange,
                        avatarTextColor: Colors.white,
                        // showAvatarImage: staff has image url → can be extended later
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ShowSyllabusScreen(syllabusId: syllabus.id),
                            ),
                          );
                        },
                        actions: [
                          ItemAction.text(
                            label: 'កែ',
                            onPressed: () => _navigateToEdit(syllabus),
                            color: Colors.green,
                          ),
                          ItemAction.text(
                            label: 'លុប',
                            onPressed: () => _showDeleteDialog(syllabus),
                            color: Colors.red,
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
