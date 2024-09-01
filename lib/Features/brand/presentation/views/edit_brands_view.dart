import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/titled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditBrandsView extends StatefulWidget {
  const EditBrandsView({super.key, required this.brandModel});
  final BrandModel brandModel;

  @override
  State<EditBrandsView> createState() => _EditBrandsViewState();
}

class _EditBrandsViewState extends State<EditBrandsView> {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    nameController.text = widget.brandModel.name!;
    imageController.text = widget.brandModel.logo!;
    descriptionController.text = widget.brandModel.description!;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Scaffold(
        appBar: _appBar(),
        body: ListView(
          children: [
            _textFieldsSection(),
            const Gap(40),
            _editButton(),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Edit Brand',
        style: MyTextStyles.titleSmall,
      ),
      centerTitle: true,
    );
  }

  Center _editButton() {
    return Center(
      child: BlocConsumer<BrandCubit, BrandState>(
        listener: (context, state) => {
          if (state is BrandSuccess)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.greenAccent, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  content: const Text('Brand Updated',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green.shade800,
                ),
              ),
              GoRouter.of(context).pop(),
              BlocProvider.of<BrandCubit>(context)
                  .getAllBrands(isPaginationLoading: false),
            }
          else if (state is BrandFailureEditing)
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
                  context.read<BrandCubit>().updateBrand(
                      brandModel: widget.brandModel,
                      name: nameController.text.isNotEmpty
                          ? nameController.text
                          : widget.brandModel.name!,
                      image: widget.brandModel.logo != null
                          ? imageController.text.isNotEmpty
                              ? imageController.text
                              : widget.brandModel.logo!
                          : "https://placehold.jp/3d4070/ffffff/150x150.png",
                      description: descriptionController.text.isNotEmpty
                          ? descriptionController.text
                          : widget.brandModel.description!);
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                }
              },
              child: state is BrandLoadingEditing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Update",
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
          hintText: "Brand Name",
          validator: (value) {
            if (value.isEmpty) {
              return "One parameter must be filled";
            }
            return null;
          },
        ),
        TitledTextField(
          controller: imageController,
          title: 'Image',
          hintText: "Brand Image",
          validator: (value) {
            if (value.isEmpty) {
              return "One parameter must be filled";
            }
            return null;
          },
        ),
        TitledTextField(
            controller: descriptionController,
            maxLines: 3,
            title: "Description",
            hintText: "Brand Description",
            validator: (value) {
              if (value.isEmpty) {
                return "One parameter must be filled";
              }
              return null;
            }),
      ],
    );
  }
}
