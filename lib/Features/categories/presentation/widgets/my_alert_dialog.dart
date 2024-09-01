import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController iconController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    keywordsController.dispose();
    iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextFormField(
              controller: nameController,
              label: const Text('Category Name'),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter category name';
                }
                return null;
              },
            ),
            const Gap(10),
            CustomTextFormField(
              controller: keywordsController,
              label: const Text('keywords Name'),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter keywords';
                }
                return null;
              },
            ),
            const Gap(10),
            CustomTextFormField(
              controller: iconController,
              label: const Text('Icon Image Url'),
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image url';
                }
                return null;
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Navigator.of(context).pop();
                // BlocProvider.of<CategoriesCubit>(context).createCategory(
                //     nameController.text,
                //     keywordsController.text,
                //     iconController.text);
                // BlocProvider.of<CategoriesCubit>(context).getAllCategories();
              }
            },
            child: const FittedBox(child: Text('Create')),
          ),
        ),
      ],
    );
  }
}
