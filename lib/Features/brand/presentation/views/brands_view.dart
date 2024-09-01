import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/widgets/bottom_loading_paginate.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/widgets/brand_item.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/widgets/brand_item_loading.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  @override
  void initState() {
    BlocProvider.of<BrandCubit>(context).getBrandsCount();
    BlocProvider.of<BrandCubit>(context).page = 0;
    BlocProvider.of<BrandCubit>(context).brandsList.clear();
    BlocProvider.of<BrandCubit>(context)
        .getAllBrands(isPaginationLoading: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Brands',
          style: MyTextStyles.titleSmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.kAddBrandView);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<BrandCubit, BrandState>(
        buildWhen: (previous, current) =>
            current is BrandSuccess ||
            current is BrandLoading ||
            current is BrandFailure,
        builder: (context, state) {
          if (state is BrandLoading) {
            return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: 13,
                itemBuilder: (context, index) => const BrandItemLoading());
          } else if (state is BrandSuccess) {
            return context.read<BrandCubit>().brandsList.isEmpty
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
                          'No Brands Found',
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
                        if (context.read<BrandCubit>().brandsCount >
                            context.read<BrandCubit>().brandsList.length) {
                          context
                              .read<BrandCubit>()
                              .getAllBrands(isPaginationLoading: true);
                        } else {}
                      }
                      return true;
                    },
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: context.read<BrandCubit>().brandsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => GoRouter.of(context).push(
                              AppRoutes.kBrandProductsView,
                              extra:
                                  context.read<BrandCubit>().brandsList[index]),
                          child: BrandItem(
                              index: index,
                              edit: () {
                                GoRouter.of(context).pop();
                                GoRouter.of(context).push(
                                    AppRoutes.kEditBrandView,
                                    extra: context
                                        .read<BrandCubit>()
                                        .brandsList[index]);
                              },
                              delete: () {
                                GoRouter.of(context).pop();
                                GoRouter.of(context).push(
                                    AppRoutes.kDeleteBrandView,
                                    extra: context
                                        .read<BrandCubit>()
                                        .brandsList[index]);
                              }),
                        );
                      },
                    ),
                  );
          } else if (state is BrandFailure) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: const BottomLoadingPaginate(),
    );
  }
}
