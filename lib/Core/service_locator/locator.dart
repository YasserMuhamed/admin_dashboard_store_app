// import 'package:dio/dio.dart';
import 'package:admin_dashboard_store_app/Core/api/api_manager.dart';
import 'package:admin_dashboard_store_app/Core/api/dio_factory.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/repository/auth_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/repositories/brand_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/repositories/categories_repo_impl.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void getItSetup() {
  getIt.registerSingleton<ApiManager>(ApiManager(dio: DioFactory.getDio()));
  getIt.registerSingleton<DashboardRepoImpl>(
      DashboardRepoImpl(apiManager: getIt.get<ApiManager>()));
  getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(apiManager: getIt.get<ApiManager>()));
  getIt.registerSingleton<CategoriesRepoImpl>(
      CategoriesRepoImpl(getIt.get<ApiManager>()));
  getIt.registerSingleton<BrandRepoImpl>(
      BrandRepoImpl(apiManager: getIt.get<ApiManager>()));
}
