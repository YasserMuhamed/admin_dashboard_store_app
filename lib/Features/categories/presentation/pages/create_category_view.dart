import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/titled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateCategoryView extends StatefulWidget {
  const CreateCategoryView({super.key});

  @override
  State<CreateCategoryView> createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateCategoryView> {
  // controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController keyWordController = TextEditingController();

  // form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
            'Add Category',
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
              _createButton(),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Center _createButton() {
    return Center(
              child: BlocConsumer<CategoriesCubit, CategoriesState>(
                listenWhen: (previous, current) =>
                    current is CategoriesSuccess ||
                    current is CategoriesFailedCreating,
                listener: (context, state) => {
                  if (state is CategoriesSuccess)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.greenAccent, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          content: const Text('Category Created Successfully',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green.shade800,
                        ),
                      ),
                      GoRouter.of(context).pop(),
                      BlocProvider.of<CategoriesCubit>(context)
                          .getAllCategories(isPaginationLoading: false),
                    }
                  else if (state is CategoriesFailedCreating)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.red.shade800, width: 1),
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
                          context.read<CategoriesCubit>().createCategory(
                                name: nameController.text,
                                iconImage: imageController.text,
                                keywords: keyWordController.text,
                              );
                        } else {
                          setState(() {
                            autovalidateMode =
                                AutovalidateMode.onUserInteraction;
                          });
                        }
                      },
                      child: state is CategoriesLoadingCreating
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Gap(10),
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          : const Text(
                              "Create",
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
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                TitledTextField(
                  controller: imageController,
                  title: "Image",
                  hintText: "Category Image",
                  validator: (value) {
                    if (value.isEmpty || !value.contains("http")) {
                      return "Image is required";
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
                    if (value.isEmpty) {
                      return "keywords are required";
                    }
                    return null;
                  },
                ),
              ],
            );
  }
}
