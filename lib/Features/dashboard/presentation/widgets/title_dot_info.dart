import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class TitleDotInfo extends StatelessWidget {
  const TitleDotInfo({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "\u2022 $title",
          style: MyTextStyles.subtitle.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: MyTextStyles.subtitleSmall.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class SubTitleDotInfo extends StatelessWidget {
  const SubTitleDotInfo({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "- $title ",
                style: MyTextStyles.body.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: value,
                style: MyTextStyles.bodySmall.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
