import 'package:admin_dashboard_store_app/Core/constants/constant.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/views/login_view.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/views/register_view.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/views/create_brands_view.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/views/delete_brands_view.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/views/edit_brands_view.dart';
import 'package:admin_dashboard_store_app/Features/brand/presentation/views/brands_view.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/pages/category_products_view.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/pages/category_view.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/pages/create_category_view.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/pages/delete_category_view.dart';
import 'package:admin_dashboard_store_app/Features/categories/presentation/pages/edit_category_view.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/pages/create_product_view.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/pages/dashboard_view.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/pages/edit_product_view.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/presentation/pages/product_details_view.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kInitialRoute,
        builder: (context, state) =>
            isLoggedIn ? const DashboardView() : const LoginView(),
      ),

      // *************************** Auth Routes ***************************
      GoRoute(
        path: AppRoutes.kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),

      // *************************** Dashboard && Product Routes ***************************

      GoRoute(
        path: AppRoutes.kDashboardView,
        builder: (context, state) => const DashboardView(),
      ),

      GoRoute(
        path: AppRoutes.kProductDetailsView,
        builder: (context, state) => ProductDetailsView(
          productModel: state.extra as ProductModel,
        ),
      ),

      GoRoute(
        path: AppRoutes.kCreateProductView,
        builder: (context, state) => const CreateProductView(),
      ),

      GoRoute(
        path: AppRoutes.kEditProductView,
        builder: (context, state) => EditProductView(
          product: state.extra as ProductModel,
        ),
      ),

      // *************************** Category Routes ***************************

      GoRoute(
        path: AppRoutes.kCategoryView,
        builder: (context, state) => const CategoryView(),
      ),
      GoRoute(
        path: AppRoutes.kCategoryProductsView,
        builder: (context, state) => CategoryProductsView(
          categoryModel: state.extra as CategoryModel,
        ),
      ),
      GoRoute(
        path: AppRoutes.kEditCategoryView,
        builder: (context, state) => EditCategoryView(
          categoryModel: state.extra as CategoryModel,
        ),
      ),
      GoRoute(
        path: AppRoutes.kCreateCategoryView,
        builder: (context, state) => const CreateCategoryView(),
      ),
      GoRoute(
        path: AppRoutes.kDeleteCategoryView,
        builder: (context, state) => DeleteCategoryView(
          categoryModel: state.extra as CategoryModel,
        ),
      ),

      // *************************** Brand Routes ***************************
      GoRoute(
        path: AppRoutes.kBrandView,
        builder: (context, state) => const BrandsView(),
      ),
      GoRoute(
        path: AppRoutes.kEditBrandView,
        builder: (context, state) => EditBrandsView(
          brandModel: state.extra as BrandModel,
        ),
      ),
      GoRoute(
        path: AppRoutes.kAddBrandView,
        builder: (context, state) => const CreateBrandView(),
      ),
      GoRoute(
        path: AppRoutes.kDeleteBrandView,
        builder: (context, state) => DeleteBrandsView(
          brandModel: state.extra as BrandModel,
        ),
      ),
    ],
  );
}
