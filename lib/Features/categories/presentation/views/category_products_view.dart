import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/loading_effect.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/product_item.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CategoryProductsView extends StatefulWidget {
  const CategoryProductsView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).categoryProductsList.clear();
    BlocProvider.of<CategoriesCubit>(context).categoryProductsPageNum = 0;
    BlocProvider.of<CategoriesCubit>(context).getCategoryProducts(
        id: widget.categoryModel.id!, isPaginationLoading: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: widget.categoryModel.icon!,
                height: 35,
                width: 35,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(10),
            Text('${widget.categoryModel.name} Products'),
          ],
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
          buildWhen: (previous, current) =>
              current is CategoryProductLoading ||
              current is CategoryProductFailure ||
              current is CategoryProductSuccess,
          builder: (context, state) {
            if (state is CategoryProductLoading) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const LoadingEffect(),
                itemCount: 10,
              );
            } else if (state is CategoryProductSuccess) {
              return context
                      .read<CategoriesCubit>()
                      .categoryProductsList
                      .isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/noData2.svg",
                            height: MediaQuery.sizeOf(context).height * .4,
                          ),
                          const Gap(10),
                          const Text(
                            'No Products Found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification &&
                            notification.metrics.pixels ==
                                notification.metrics.maxScrollExtent) {
                          // if (widget.categoryModel.count!.products! >
                          //     context
                          //         .read<CategoriesCubit>()
                          //         .categoryProductsList
                          //         .length) {
                          context.read<CategoriesCubit>().getCategoryProducts(
                              isPaginationLoading: true,
                              id: widget.categoryModel.id!);
                          // } else {}
                        }
                        return true;
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                                AppRoutes.kProductDetailsView,
                                extra: BlocProvider.of<CategoriesCubit>(context)
                                    .categoryProductsList[index]);
                          },
                          child: ProductItem(
                            productModel:
                                BlocProvider.of<CategoriesCubit>(context)
                                    .categoryProductsList[index],
                          ),
                        ),
                        itemCount: BlocProvider.of<CategoriesCubit>(context)
                            .categoryProductsList
                            .length,
                      ),
                    );
            } else if (state is CategoryProductFailure) {
              return Center(
                child: Text(state.error),
              );
            }
            return const SizedBox.shrink();
          }),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          buildWhen: (previous, current) =>
              current is CategoryProductLoadingPagination ||
              current is CategoryProductSuccess ||
              current is CategoryProductFailurePagination,
          builder: (context, state) {
            if (state is CategoryProductLoadingPagination) {
              return const LinearProgressIndicator(
                color: Colors.white,
              );
            } else if (state is CategoryProductFailurePagination) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
