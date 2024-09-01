import 'package:admin_dashboard_store_app/Core/utils/text_styles/text_styles.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/manager/cubit/dashboard_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/List_view_box_item.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/loading_effect.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/my_drawer.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/product_item.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<DashboardCubit>(context).getProductCount();
    BlocProvider.of<DashboardCubit>(context).page = 0;
    BlocProvider.of<DashboardCubit>(context).productsList.clear();
    BlocProvider.of<DashboardCubit>(context)
        .getProducts(isPaginationLoading: false);
  }

  // List of items to be displayed in the dashboard
  List<Widget> listItems = [
    ListViewBoxItem(
      onPressed: () {},
      icon: Icons.person,
      title: 'Users',
      percentage: '38%',
      number: '248',
      pageSubTitle: 'All Users',
      iconColor: Colors.red[400]!,
      iconBackGroundColor: Colors.red[800]!,
    ),
    const Gap(20),
    ListViewBoxItem(
      onPressed: () {},
      icon: Icons.shopping_cart_rounded,
      title: 'Orders',
      percentage: '25%',
      number: '1154',
      pageSubTitle: 'All Orders',
      iconColor: Colors.blueGrey[400]!,
      iconBackGroundColor: Colors.blueGrey[800]!,
    ),
    const Gap(20),
    ListViewBoxItem(
      onPressed: () {},
      icon: Icons.monetization_on_outlined,
      title: 'Earnings',
      percentage: '13%',
      number: '368',
      pageSubTitle: 'Net Earnings',
      iconColor: Colors.green[400]!,
      iconBackGroundColor: Colors.green[800]!,
    ),
    const Gap(20),
    ListViewBoxItem(
      onPressed: () {},
      icon: Icons.wallet,
      title: 'Balance',
      percentage: '8%',
      number: '785',
      pageSubTitle: 'See Details',
      iconColor: Colors.yellow[400]!,
      iconBackGroundColor: Colors.yellow[800]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: MyTextStyles.titleSmall,
        ),
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 190,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: listItems),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: MyTextStyles.title,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900]),
                        onPressed: () {
                          GoRouter.of(context)
                              .push(AppRoutes.kCreateProductView);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add),
                            Gap(10),
                            Text('Add Product'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: BlocBuilder<DashboardCubit, DashboardState>(
              buildWhen: (previous, current) =>
                  current is DashboardSuccess ||
                  current is DashboardFailure ||
                  current is DashboardLoading,
              builder: (context, state) {
                if (state is DashboardSuccess) {
                  return BlocProvider.of<DashboardCubit>(context)
                          .productsList
                          .isEmpty
                      ? const EmptyDashboardUI()
                      : NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification &&
                                notification.metrics.pixels ==
                                    notification.metrics.maxScrollExtent) {
                              if (context.read<DashboardCubit>().productsCount >
                                  context
                                      .read<DashboardCubit>()
                                      .productsList
                                      .length) {
                                context
                                    .read<DashboardCubit>()
                                    .getProducts(isPaginationLoading: true);
                              } else {}
                              // print(
                              //     "LISSSSSSSSSSSSSSSSST  ${(context.read<DashboardCubit>().productsList.length)}");
                              // print((context
                              //     .read<DashboardCubit>()
                              //     .productsCount));
                              // print((context.read<DashboardCubit>().page));
                            }
                            return true;
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                    AppRoutes.kProductDetailsView,
                                    extra:
                                        BlocProvider.of<DashboardCubit>(context)
                                            .productsList[index]);
                              },
                              child: ProductItem(
                                productModel:
                                    BlocProvider.of<DashboardCubit>(context)
                                        .productsList[index],
                              ),
                            ),
                            itemCount: BlocProvider.of<DashboardCubit>(context)
                                .productsList
                                .length,
                          ),
                        );
                } else if (state is DashboardLoading) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => const LoadingEffect(),
                    itemCount: 10,
                  );
                } else if (state is DashboardFailure) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          buildWhen: (previous, current) =>
              current is DashboardLoadingPagination ||
              current is DashboardSuccess ||
              current is DashboardFailurePagination,
          builder: (context, state) {
            if (state is DashboardLoadingPagination) {
              return const LinearProgressIndicator(
                color: Colors.white,
              );
            } else if (state is DashboardFailurePagination) {
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

class EmptyDashboardUI extends StatelessWidget {
  const EmptyDashboardUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              "assets/svg/empty.svg",
              height: MediaQuery.of(context).size.height * 0.28,
            ),
          ),
          const Gap(15),
          Text("No Products Found", style: MyTextStyles.title),
        ],
      ),
    );
  }
}
