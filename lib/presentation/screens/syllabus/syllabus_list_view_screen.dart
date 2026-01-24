import 'package:flutter/material.dart';
import 'package:sbku_app/data/dummy_staff.dart';
import 'package:sbku_app/data/dummy_syllabus.dart';
import 'package:sbku_app/model/syllabus_model.dart';
import 'package:sbku_app/presentation/screens/syllabus/add_syllabus.dart';
import 'package:sbku_app/presentation/screens/syllabus/show_syllabus.dart';
import 'package:sbku_app/presentation/widgets/appbar_widget.dart';
import 'package:sbku_app/presentation/widgets/filter_row_widget.dart';
import 'package:sbku_app/presentation/widgets/list_item_widget.dart';

class SyllabusListViewScreen extends StatefulWidget {
  const SyllabusListViewScreen({super.key});

  @override
  State<SyllabusListViewScreen> createState() => _SyllabusListViewScreenState();
}

class _SyllabusListViewScreenState extends State<SyllabusListViewScreen> {
  String? _selectedClass;
  String? _selectedDepartment;

  /// ENTITY → MODEL (UI ONLY)
  List<SyllabusModel> get _syllabusModels =>
      dummySyllabus.map(SyllabusModel.fromEntity).toList();

  List<SyllabusModel> get _filteredSyllabus {
    return _syllabusModels.where((s) {
      if (_selectedClass != null && s.className != _selectedClass) {
        return false;
      }
      return true;
    }).toList();
  }

  void _navigateToAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddSyllabusScreen()),
    ).then((_) => setState(() {}));
  }

  void _navigateToEdit(SyllabusModel syllabus) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddSyllabusScreen(syllabus: syllabus),
      ),
    ).then((_) => setState(() {}));
  }

  void _showDeleteDialog(SyllabusModel syllabus) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('លុប'),
        content: Text('តើអ្នកប្រាកដថាចង់លុប ${syllabus.subjectName} ឬទេ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('បោះបង់'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                dummySyllabus.removeWhere(
                  (e) => e.id == syllabus.id,
                );
              });
              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${syllabus.subjectName} ត្រូវបានលុបដោយជោគជ័យ',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('លុប'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final syllabusList = _filteredSyllabus;
    final hasFilter = _selectedClass != null;

    return Scaffold(
      appBar: AppBarWidget.simple(
        title: 'បញ្ជីមុខវិជ្ជា',
        actions: [
          IconButton(
            onPressed: _navigateToAdd,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          /// FILTERS
          FilterRowWidget(
            filters: [
              FilterConfig(
                hint: 'ថ្នាក់',
                value: _selectedClass,
                items: _syllabusModels.map((s) => s.className).toSet().toList(),
                onChanged: (value) => setState(() => _selectedClass = value),
              ),
              FilterConfig(
                hint: 'នាយកដ្ឋាន',
                value: _selectedDepartment,
                items: dummyStaffs.map((s) => s.department).toSet().toList(),
                onChanged: (value) =>
                    setState(() => _selectedDepartment = value),
              ),
            ],
          ),

          /// LIST
          Expanded(
            child: syllabusList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
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
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: syllabusList.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      final syllabus = syllabusList[index];

                      return ListItemWidget<SyllabusModel>(
                        item: syllabus,
                        title: syllabus.className,
                        subtitle: syllabus.teacherName,
                        avatarBackgroundColor: Colors.deepOrange,
                        avatarTextColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShowSyllabusScreen(
                                syllabusId: syllabus.id,
                              ),
                            ),
                          );
                        },
                        actions: [
                          ItemAction.text(
                            label: 'កែ',
                            color: Colors.green,
                            onPressed: () => _navigateToEdit(syllabus),
                          ),
                          ItemAction.text(
                            label: 'លុប',
                            color: Colors.red,
                            onPressed: () => _showDeleteDialog(syllabus),
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
