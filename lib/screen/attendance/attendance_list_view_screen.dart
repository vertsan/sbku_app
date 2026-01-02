import 'package:sbku_app/data/dummy_attendance.dart';
import 'package:sbku_app/model/attendance.dart';
import 'package:flutter/material.dart';

class AttendanceListViewScreen extends StatefulWidget {
  const AttendanceListViewScreen({super.key});

  @override
  State<AttendanceListViewScreen> createState() =>
      _AttendanceListViewScreenState();
}

class _AttendanceListViewScreenState extends State<AttendanceListViewScreen> {
  String? _selectedFaculty;
  String? _selectedShift;
  String? _selectedGeneration;
  final List<AttendanceModel> _attendances = List.from(dummyAttendances);

  List<AttendanceModel> get filteredAttendance {
    var result = _attendances;

    if (_selectedFaculty != null) {
      result = result.where((s) => s.facultyId == _selectedFaculty).toList();
    }

    if (_selectedShift != null) {
      result = result.where((s) => s.shiftId == _selectedShift).toList();
    }

    if (_selectedGeneration != null) {
      result = result.where((s) => s.yearId == _selectedGeneration).toList();
    }

    return result;
  }

  void _clearFilters() {
    setState(() {
      _selectedFaculty = null;
      _selectedShift = null;
      _selectedGeneration = null;
    });
  }

  bool get _hasActiveFilters =>
      _selectedFaculty != null ||
      _selectedShift != null ||
      _selectedGeneration != null;

  void _showDeleteDialog(AttendanceModel attendance) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('លុបវត្តមាន'),
        content: Text(
            'តើអ្នកប្រាកដថាចង់លុបវត្តមានរបស់ ${attendance.studentName} ឬទេ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('បោះបង់'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _attendances.removeWhere((s) => s.id == attendance.id);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${attendance.studentName} ត្រូវបានលុបដោយជោគជ័យ'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('លុប', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(AttendanceModel attendance) {
    // Navigate to edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('កែសម្រួល ${attendance.studentName}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navigateToAdd() {
    // Navigate to add screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('បន្ថែមវត្តមានថ្មី'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
        elevation: 2,
        title: const Text('បញ្ជីវត្តមានសិស្ស'),
        actions: [
          IconButton(
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ចែករំលែក')),
              );
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: _navigateToAdd,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.filter_list,
                            size: 18, color: Colors.grey[700]),
                        const SizedBox(width: 8),
                        Text(
                          'តម្រង',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    if (_hasActiveFilters)
                      TextButton.icon(
                        onPressed: _clearFilters,
                        icon: const Icon(Icons.clear, size: 16),
                        label: const Text('សម្អាត'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.purple[600],
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        value: _selectedFaculty,
                        hint: 'មហាវិទ្យាល័យ',
                        items: _attendances
                            .map((s) => s.facultyId)
                            .toSet()
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedFaculty = value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildDropdown(
                        value: _selectedShift,
                        hint: 'វេន',
                        items:
                            _attendances.map((s) => s.shiftId).toSet().toList(),
                        onChanged: (value) =>
                            setState(() => _selectedShift = value),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildDropdown(
                        value: _selectedGeneration,
                        hint: 'ជំនាន់',
                        items:
                            _attendances.map((s) => s.yearId).toSet().toList(),
                        onChanged: (value) =>
                            setState(() => _selectedGeneration = value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Attendance List
          Expanded(
            child: filteredAttendance.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: filteredAttendance.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final attendance = filteredAttendance[index];
                      return _buildAttendanceCard(attendance);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(AttendanceModel attendance) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // print('Tapped on ${attendance.studentName}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.purple[50],
                child: Text(
                  attendance.avatarLetter,
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attendance.studentName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ថ្ងៃទី: ${attendance.formattedDate}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ម៉ោង: ${attendance.timeRange}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: attendance.statusColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        attendance.statusLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: attendance.statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Actions
              Column(
                children: [
                  InkWell(
                    onTap: () => _navigateToEdit(attendance),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Text(
                        'កែ',
                        style: TextStyle(
                          color: Colors.purple[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () => _showDeleteDialog(attendance),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Text(
                        'លុប',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'រកមិនឃើញវត្តមាន',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'សូមកែប្រែការតម្រង',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
