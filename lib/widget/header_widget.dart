import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final VoidCallback? onBackPressed;
  final List<Color>? gradientColors;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final TextStyle? titleStyle;

  const HeaderWidget({
    super.key,
    required this.title,
    this.height = 80,
    this.onBackPressed,
    this.gradientColors,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradientColors =
        gradientColors ?? [const Color(0xFFFF6A00), const Color(0xFF9C3701)];

    final defaultTitleStyle = titleStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        );

    return AppBar(
      toolbarHeight: height,
      leadingWidth: 70,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: defaultGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading ??
          (automaticallyImplyLeading && Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                )
              : null),
      title: Text(
        title,
        style: defaultTitleStyle,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
