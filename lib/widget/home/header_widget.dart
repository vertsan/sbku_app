import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Scale factor (adjust values if needed)
    final double scaleFactor = screenWidth < 360
        ? 0.85
        : screenWidth < 420
            ? 0.95
            : 1.0;

    return Transform.scale(
      scale: scaleFactor,
      alignment: Alignment.topCenter,
      child: AppBar(
        toolbarHeight: 80,
        leadingWidth: 70,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6A00), Color(0xFF9C3701)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Logo
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 4),
          child: SvgPicture.asset(
            'assets/images/sbku-logo.svg',
            fit: BoxFit.contain,
          ),
        ),

        // Title
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'សាកលវិទ្យាល័យសម្តេចព្រះមហាសង្ឃរាជ បួរ គ្រី',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Samdech Preah Mahasangharajah Bour Kry University',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.white70,
                height: 1.2,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 26),
            color: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
