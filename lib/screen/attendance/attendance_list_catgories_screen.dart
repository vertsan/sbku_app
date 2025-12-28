// import 'package:flutter/material.dart';
// import 'package:sbku_app/data/dummy_attendance.dart';
// import 'package:sbku_app/screen/attendance/attendance_list_view_screen.dart';

// import 'package:sbku_app/widget/appbar_widget.dart';
// import 'package:sbku_app/widget/list_card_widget.dart';

// class AttendanceListCategoryScreen extends StatelessWidget {
//   const AttendanceListCategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: AppBarWidget(
//           enableScaling: true,
//           title: 'ប្រភេទអវត្តមាន',
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: ListCardList(
//             items: [
//               ListCardItem(
//                 icon: Icons.check_circle,
//                 label: 'វត្តមានទាំងអស់',
//                 onTap: () {
//                   // Navigate to all attendance list screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AttendanceItemWidget(attendance: dummyAttendances[0]),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
