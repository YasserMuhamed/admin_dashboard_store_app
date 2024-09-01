import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/widgets/cancel_button.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/widgets/small_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DeleteCategoryView extends StatelessWidget {
  const DeleteCategoryView({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Category',
          style: MyTextStyles.titleSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            _imagePlusTextSection(context),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CancelButton(),
                _deleteButton(context),
              ],
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  SizedBox _deleteButton(BuildContext context) {
    return SizedBox(
                width: MediaQuery.of(context).size.width * 0.38,
                child: BlocConsumer<CategoriesCubit, CategoriesState>(
                  listenWhen: (previous, current) =>
                      current is CategoriesSuccess ||
                      current is CategoriesFailedDeleting,
                  listener: (context, state) {
                    if (state is CategoriesFailedDeleting) {
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
                      );
                    } else if (state is CategoriesSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.greenAccent, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          content: const Text('Category Deleted',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green.shade800,
                        ),
                      );
                      Navigator.pop(context);
                      // BlocProvider.of<CategoriesCubit>(context)
                      //     .getAllCategories(isPaginationLoading: false);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        BlocProvider.of<CategoriesCubit>(context)
                            .deleteCategory(categoryModel);
                      },
                      child: state is! CategoriesLoading
                          ? const Text('Delete')
                          : const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Center(
                                child: SmallLoadingWidget(),
                              ),
                            ),
                    );
                  },
                ),
              );
  }

  Column _imagePlusTextSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.45,
          child: SvgPicture.asset('assets/svg/undraw_throw_away.svg'),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'You are about to delete ',
                style: MyTextStyles.titleSmall.copyWith(fontSize: 22),
              ),
              TextSpan(
                text: '${categoryModel.name}',
                style: MyTextStyles.titleSmall
                    .copyWith(fontSize: 22, color: Colors.red),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
          color: Colors.grey,
          thickness: 1,
        ),
        const Gap(12),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    '\u2022 This Category will be permanently deleted with it\'s ${categoryModel.count!.products!} Products.',
                style: MyTextStyles.titleSmall.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
        const Gap(8),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    '\u2022 Are you sure you want to delete this category and it\'s products?',
                style: MyTextStyles.titleSmall.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
