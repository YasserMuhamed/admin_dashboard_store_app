import 'package:admin_dashboard_store_app/configs/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:validators/validators.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.preicon,
      this.hintText,
      this.onChange,
      this.suficon,
      this.obscure,
      this.validate,
      this.key_type,
      this.label,
      this.controller,
      this.maxLines,
      this.floatingLabelBehavior});
  final bool? obscure;
  final Icon? preicon;
  final IconButton? suficon;
  final String? hintText;
  final int? maxLines;
  final Widget? label;
  final Function(String)? onChange;
  final FormFieldValidator? validate;
  final TextInputType? key_type;
  final TextEditingController? controller;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      keyboardType: key_type ?? TextInputType.name,
      validator: validate,
      obscureText: obscure ?? false,
      onChanged: onChange,
      autofocus: true,
      decoration: InputDecoration(
        // suffixIconColor: MaterialStateColor.resolveWith((states) =>
        //     states.contains(MaterialState.focused) ? Colors.blue : Colors.grey),
        fillColor: MyColors.darkGrey.withOpacity(.5),
        filled: true,
        suffixIcon: suficon,
        prefixIcon: preicon,
        hintText: hintText,
        alignLabelWithHint: true,
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        label: label ?? const Text(""),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey.shade700),
        ),
        // ignore: prefer_const_constructors
        errorBorder: OutlineInputBorder(
          borderSide: (const BorderSide(
            color: Colors.red,
            width: 1,
          )),
        ),

        // ignore: prefer_const_constructors
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: Colors.red.shade700,
                style: BorderStyle.solid)),
      ),
    );
  }
}
