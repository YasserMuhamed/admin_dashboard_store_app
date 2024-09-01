import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/widgets/category_item.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/widgets/shimmer_category_item.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    BlocProvider.of<CategoriesCubit>(context).getCategoriesCount();
    BlocProvider.of<CategoriesCubit>(context).categoriesList.clear();
    BlocProvider.of<CategoriesCubit>(context).page = 0;
    BlocProvider.of<CategoriesCubit>(context)
        .getAllCategories(isPaginationLoading: false);
    super.initState();
  }

  Offset? _tapDownPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categories',
          style: MyTextStyles.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.kCreateCategoryView);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _categoryViewBody(),
      bottomNavigationBar: _bottomLoadingPagination(),
    );
  }

  BlocBuilder<CategoriesCubit, CategoriesState> _categoryViewBody() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) =>
          current is CategoriesSuccess ||
          current is CategoriesLoading ||
          current is CategoriesFailure,
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .75,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3),
              itemCount: 21,
              itemBuilder: (context, index) => const ShimmerCategoryItem());
        } else if (state is CategoriesSuccess) {
          return context.read<CategoriesCubit>().categoriesList.isEmpty
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
                        'No Categories Found',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : _successUIWithData(context);
        } else if (state is CategoriesFailure) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return Center(
            child: SvgPicture.asset(
              "assets/svg/noData.svg",
              height: MediaQuery.sizeOf(context).height * 5,
            ),
          );
        }
      },
    );
  }

  NotificationListener<ScrollNotification> _successUIWithData(
      BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification &&
            notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
          if (context.read<CategoriesCubit>().categoriesCount >
              context.read<CategoriesCubit>().categoriesList.length) {
            context
                .read<CategoriesCubit>()
                .getAllCategories(isPaginationLoading: true);
          } else {}
        }
        return true;
      },
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3),
        itemCount: (context).read<CategoriesCubit>().categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                // if (context
                //         .read<CategoriesCubit>()
                //         .categoriesList[index]
                //         .count!
                //         .products ==
                //     0) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       behavior: SnackBarBehavior.floating,
                //       content: const Text(
                //         'No Products in this Category',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       backgroundColor: Colors.blueGrey[900],
                //     ),
                //   );
                // } else {
                GoRouter.of(context).push(AppRoutes.kCategoryProductsView,
                    extra:
                        context.read<CategoriesCubit>().categoriesList[index]);
                // }
              },
              onTapDown: (TapDownDetails details) {
                _tapDownPosition = details.globalPosition;
              },
              onLongPress: () async {
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                showMenu(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.grey[800],
                  context: context,
                  items: [
                    PopupMenuItem(
                      value: 'edit',
                      onTap: () {
                        GoRouter.of(context).push(AppRoutes.kEditCategoryView,
                            extra: context
                                .read<CategoriesCubit>()
                                .categoriesList[index]);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Edit'),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        GoRouter.of(context).push(AppRoutes.kDeleteCategoryView,
                            extra: context
                                .read<CategoriesCubit>()
                                .categoriesList[index]);
                      },
                      value: 'delete',
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                  position: RelativeRect.fromLTRB(
                    _tapDownPosition!.dx,
                    _tapDownPosition!.dy,
                    overlay.size.width - _tapDownPosition!.dx,
                    overlay.size.height - _tapDownPosition!.dy,
                  ),
                );
              },
              child: CategoryItem(index: index));
        },
      ),
    );
  }

  SafeArea _bottomLoadingPagination() {
    return SafeArea(
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        buildWhen: (previous, current) =>
            current is CategoriesLoadingPagination ||
            current is CategoriesSuccess ||
            current is CategoriesFailurePagination,
        builder: (context, state) {
          if (state is CategoriesLoadingPagination) {
            return const LinearProgressIndicator(
              color: Colors.white,
            );
          } else if (state is CategoriesFailurePagination) {
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
    );
  }
}
