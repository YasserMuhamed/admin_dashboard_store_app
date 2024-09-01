import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/widgets/small_loading_widget.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/titled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  // controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController keyWordController = TextEditingController();

  // form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    nameController.text = widget.categoryModel.name!;
    imageController.text = widget.categoryModel.icon!;
    keyWordController.text = widget.categoryModel.keywords!;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    keyWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Category',
            style: MyTextStyles.titleSmall,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              _textFieldsSection(),
              const Gap(50),
              _updateButton(),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Center _updateButton() {
    return Center(
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) => {
          if (state is CategoriesSuccess)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.greenAccent, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  content: const Text('Category Edited Successfully',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green.shade800,
                ),
              ),
              GoRouter.of(context).pop(),
              BlocProvider.of<CategoriesCubit>(context)
                  .getAllCategories(isPaginationLoading: false),
            }
          else if (state is CategoriesFailedEditing)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  content: Text(state.error,
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red.shade800,
                ),
              ),
            }
        },
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<CategoriesCubit>().updateCategory(
                      name: nameController.text.isNotEmpty
                          ? nameController.text
                          : widget.categoryModel.name!,
                      keywords: keyWordController.text.isNotEmpty
                          ? keyWordController.text
                          : widget.categoryModel.keywords!,
                      iconImage: imageController.text.isNotEmpty
                          ? imageController.text
                          : widget.categoryModel.icon!,
                      categoryModel: widget.categoryModel);
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              },
              child: state is CategoriesLoadingEditing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Update",
                          style: TextStyle(fontSize: 18),
                        ),
                        Gap(10),
                        SmallLoadingWidget()
                      ],
                    )
                  : const Text(
                      "Update",
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          );
        },
      ),
    );
  }

  Column _textFieldsSection() {
    return Column(
      children: [
        TitledTextField(
          controller: nameController,
          title: "Name",
          hintText: "Category Name",
          validator: (value) {
            if (value.isEmpty) {
              return "Name must not be empty";
            }
            return null;
          },
        ),
        TitledTextField(
          controller: imageController,
          title: "Image",
          hintText: "Category Image",
          validator: (value) {
            if (value!.isEmpty) {
              return "Image must not be empty";
            }
            return null;
          },
        ),
        TitledTextField(
          controller: keyWordController,
          maxLines: 3,
          title: "Keywords",
          hintText: "Category Keywords",
          validator: (value) {
            if (value!.isEmpty) {
              return "Keywords must not be empty";
            }
            return null;
          },
        ),
      ],
    );
  }
}
