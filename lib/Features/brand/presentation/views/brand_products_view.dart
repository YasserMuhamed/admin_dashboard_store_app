import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/loading_effect.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/product_item.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BrandProductsView extends StatefulWidget {
  const BrandProductsView({super.key, required this.brandModel});
  final BrandModel brandModel;

  @override
  State<BrandProductsView> createState() => _BrandProductsViewState();
}

class _BrandProductsViewState extends State<BrandProductsView> {
  @override
  void initState() {
    BlocProvider.of<BrandCubit>(context).brandProductsList.clear();
    BlocProvider.of<BrandCubit>(context).brandProductsPageNum = 0;
    BlocProvider.of<BrandCubit>(context).getBrandProducts(
        id: widget.brandModel.id!, isPaginationLoading: false);
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
                imageUrl: widget.brandModel.logo!,
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
            Text('${widget.brandModel.name} Products'),
          ],
        ),
      ),
      body: BlocBuilder<BrandCubit, BrandState>(
          buildWhen: (previous, current) =>
              current is BrandProductLoading ||
              current is BrandProductFailure ||
              current is BrandProductSuccess,
          builder: (context, state) {
            if (state is BrandProductLoading) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => const LoadingEffect(),
                itemCount: 10,
              );
            } else if (state is BrandProductSuccess) {
              return context.read<BrandCubit>().brandProductsList.isEmpty
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
                          if (widget.brandModel.count!.products! >
                              context
                                  .read<BrandCubit>()
                                  .brandProductsList
                                  .length) {
                            context.read<BrandCubit>().getBrandProducts(
                                isPaginationLoading: true,
                                id: widget.brandModel.id!);
                          } else {}
                        }
                        return true;
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                                AppRoutes.kProductDetailsView,
                                extra: BlocProvider.of<BrandCubit>(context)
                                    .brandProductsList[index]);
                          },
                          child: ProductItem(
                            productModel: BlocProvider.of<BrandCubit>(context)
                                .brandProductsList[index],
                          ),
                        ),
                        itemCount: BlocProvider.of<BrandCubit>(context)
                            .brandProductsList
                            .length,
                      ),
                    );
            } else if (state is BrandProductFailure) {
              return Center(
                child: Text(state.error),
              );
            }
            return const SizedBox.shrink();
          }),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<BrandCubit, BrandState>(
          buildWhen: (previous, current) =>
              current is BrandProductLoadingPagination ||
              current is BrandProductSuccess ||
              current is BrandProductFailurePagination,
          builder: (context, state) {
            if (state is BrandProductLoadingPagination) {
              return const LinearProgressIndicator(
                color: Colors.white,
              );
            } else if (state is BrandProductFailurePagination) {
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
