import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class TitledTextField extends StatelessWidget {
  const TitledTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
  
    this.maxLines = 1,
    required this.validator,
    this.keyType = TextInputType.text,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;

  final int maxLines;
  final FormFieldValidator validator;
  final TextInputType keyType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            title,
            style: MyTextStyles.titleSmall.copyWith(fontSize: 20),
          ),
        ),
        CustomTextFormField(
            key_type: keyType,
            maxLines: maxLines,
            hintText: hintText,
            label: Text(hintText),
            controller: controller,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            validate: validator),
      ],
    );
  }
}
