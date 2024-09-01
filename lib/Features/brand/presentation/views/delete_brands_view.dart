import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DeleteBrandsView extends StatelessWidget {
  const DeleteBrandsView({super.key, required this.brandModel});

  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Brand',
          style: MyTextStyles.titleSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            imagePlusTextSection(context),
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
      child: BlocConsumer<BrandCubit, BrandState>(
        listenWhen: (previous, current) =>
            current is BrandSuccess || current is BrandFailure,
        listener: (context, state) {
          if (state is BrandFailure) {
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
            );
          } else if (state is BrandSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                content: const Text('Brand Deleted',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green.shade800,
              ),
            );
            Navigator.pop(context);
            // BlocProvider.of<BrandCubit>(context)
            //     .getAllBrands(isPaginationLoading: false);
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              BlocProvider.of<BrandCubit>(context).deleteBrand(brandModel);
            },
            child: state is! BrandLoading
                ? const Text('Delete')
                : const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Center(
                      child: SizedBox(
                        height: 17,
                        width: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Column imagePlusTextSection(BuildContext context) {
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
                text: '${brandModel.name}',
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
                    '\u2022 This brand will be permanently deleted with it\'s ${brandModel.count!.products!} Products.',
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
                    '\u2022 Are you sure you want to delete this brand and it\'s products?',
                style: MyTextStyles.titleSmall.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
