import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    this.textStyle,
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final Color color;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      titleTextStyle: textStyle ?? MyTextStyles.subtitle,
      textColor: color,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(title),
    );
  }
}
