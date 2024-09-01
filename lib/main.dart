import 'package:admin_dashboard_store_app/Core/constants/constant.dart';
import 'package:admin_dashboard_store_app/Core/helpers/shared_pref_helper.dart';
import 'package:admin_dashboard_store_app/Core/service_locator/locator.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/repository/auth_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/auth/manager/register_cubit/register_cubit.dart';
import 'package:admin_dashboard_store_app/Features/auth/manager/login_cubit/login_cubit.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/repositories/brand_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/brand/manager/cubit/brand_cubit.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/repositories/categories_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/categories/manager/categories/categories_cubit.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/manager/cubit/dashboard_cubit.dart';
import 'package:admin_dashboard_store_app/configs/router/router.dart';
import 'package:admin_dashboard_store_app/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkIfUserLoggedIn();
  getItSetup();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginCubit(getIt.get<AuthRepoImpl>())),
    BlocProvider(create: (context) => RegisterCubit(getIt.get<AuthRepoImpl>())),
    BlocProvider(
      create: (context) =>
          DashboardCubit(dashboardRepo: getIt.get<DashboardRepoImpl>()),
    ),
    BlocProvider(
      create: (context) =>
          CategoriesCubit(categoriesRepo: getIt.get<CategoriesRepoImpl>()),
    ),
    BlocProvider(
        create: (context) => BrandCubit(brandRepo: getIt.get<BrandRepoImpl>())),
  ], child: const MyApp()));
}

checkIfUserLoggedIn() async {
  String? userToken = await SharedPrefHelper.getString("userToken");
  if (userToken != null && userToken.isNotEmpty) {
    return isLoggedIn = true;
  } else {
    return isLoggedIn = false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppThemes.themeData,
    );
  }
}
