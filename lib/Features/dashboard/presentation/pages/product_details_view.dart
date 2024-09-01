import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/manager/cubit/dashboard_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/title_dot_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(context)
        .getProductDetails(widget.productModel.id.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Details",
          style: MyTextStyles.titleSmall,
        ),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          var data = BlocProvider.of<DashboardCubit>(context).data;
          if (state is DetailsSuccess) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Gap(20),
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: data.picture!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Text(
                          data.name!,
                          style: MyTextStyles.title.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.productModel.description!,
                          style: MyTextStyles.body.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            TitleDotInfo(
                              title: "Product ID :",
                              value: data.id.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            TitleDotInfo(
                              title: "Quantity :",
                              value: data.quantity.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            TitleDotInfo(
                              title: "Price :",
                              value: data.price.toString(),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const TitleDotInfo(
                              title: "Category",
                              value: "",
                            ),
                            SubTitleDotInfo(
                                title: "Name :", value: data.category!.name!),
                            SubTitleDotInfo(
                                title: "KeyWords :",
                                value: data.category!.keywords!),
                            const Divider(
                              color: Colors.white,
                            ),
                            const TitleDotInfo(
                              title: "Brand",
                              value: "",
                            ),
                            SubTitleDotInfo(
                                title: "Name :", value: data.brand!.name!),
                            SubTitleDotInfo(
                              title: "KeyWords :",
                              value: data.brand!.description!,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const Gap(20)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailsFailure) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
