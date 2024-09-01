import 'package:admin_dashboard_store_app/Features/auth/manager/login_cubit/login_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/widgets/drawer_item.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.woo_commerce,
              size: 100,
            ),
          ),
          const DrawerItem(
            icon: Icons.home_rounded,
            title: 'D A S H B O A R D',
            color: Colors.white,
          ),
          DrawerItem(
            onTap: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).push(AppRoutes.kCategoryView);
            },
            icon: Icons.category_rounded,
            title: 'C A T E G O R Y',
            color: Colors.white,
          ),
          DrawerItem(
            onTap: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).push(AppRoutes.kBrandView);
            },
            icon: Icons.shopping_bag_outlined,
            title: 'B R A N D',
            color: Colors.white,
          ),
          const DrawerItem(
            icon: Icons.settings,
            title: 'S E T T I N G S',
            color: Colors.white,
          ),
          const Spacer(),
          DrawerItem(
            onTap: () {
              BlocProvider.of<LoginCubit>(context).logout();
              GoRouter.of(context).go(AppRoutes.kLoginView);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content:
                      Text('Logged out', style: TextStyle(color: Colors.white)),
                ),
              );
            },
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            icon: Icons.logout,
            title: 'L O G O U T',
            color: const Color.fromARGB(255, 175, 44, 34),
          )
        ],
      ),
    );
  }
}
