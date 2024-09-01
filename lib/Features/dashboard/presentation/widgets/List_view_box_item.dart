import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class ListViewBoxItem extends StatelessWidget {
  const ListViewBoxItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.number,
    required this.pageSubTitle,
    required this.iconColor,
    required this.iconBackGroundColor,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String percentage;
  final String number;
  final String pageSubTitle;
  final Color iconColor;
  final Color iconBackGroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xff222222),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: MyTextStyles.subtitle.copyWith(
                      color: Colors.deepPurple[400],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.keyboard_arrow_up_rounded,
                          ),
                        ),
                        TextSpan(
                          text: percentage,
                          style: MyTextStyles.subtitle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FittedBox(
                child: Text(
                  number,
                  style: MyTextStyles.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent),
                      child: Text(pageSubTitle),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      icon,
                      color: iconBackGroundColor,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
