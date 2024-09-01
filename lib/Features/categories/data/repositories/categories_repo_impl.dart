import 'package:admin_dashboard_store_app/Core/api/api_manager.dart';
import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/all_categories.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/repositories/categories_repo.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  CategoriesRepoImpl(this.apiManager);
  final ApiManager apiManager;

  // ***************** GetAllCategories implementation ********************
  @override
  Future<Either<Failures, List<CategoryModel>>> getAllCategories(
      int page) async {
    try {
      final response = await apiManager.get(
          endPoint: 'categories?orderType=desc&limit=15&page=$page');
      final categories = (response.data['data'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return right(categories);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  // ***************** CreateCategory implementation ********************
  @override
  Future<Either<Failures, CategoryModel>> createCategory(
      String name, String keyWords, String iconImage) async {
    try {
      final response = await apiManager.post(
        endPoint: 'categories/create',
        data: {"name": name, "keywords": keyWords, "icon": iconImage},
      );
      final category = CategoryModel.fromJson(response.data);
      return right(category);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }

  // ***************** GetCategoriesCount implementation ********************
  @override
  Future<Either<Failures, int>> getCategoriesCount() async {
    try {
      final response = await apiManager.get(
        endPoint: 'categories/counts',
      );
      final categoryCount = response.data['data']['categories'];
      return right(int.parse(categoryCount.toString()));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }

  // ***************** DeleteCategory implementation ********************
  @override
  Future<Either<Failures, CategoryModel>> deleteCategory(
      CategoryModel categoryModel) async {
    try {
      Response response = await apiManager.delete(
          endPoint: '/categories/${categoryModel.id}/delete');
      CategoryModel category = CategoryModel.fromJson(response.data['data']);
      return Right(category);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }

  // ***************** UpdateCategory implementation ********************
  @override
  Future<Either<Failures, CategoryModel>> updateCategory(String name,
      String keywords, String iconImage, CategoryModel categoryModel) async {
    try {
      Response response = await apiManager
          .patch(endPoint: "/categories/${categoryModel.id}/update", data: {
        "name": name,
        "keywords": keywords,
        "icon": iconImage,
      });
      return Right(CategoryModel.fromJson(response.data["data"]));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  // ***************** GetCategoriesNames implementation ********************
  @override
  Future<Either<Failures, List<AllCategories>>> getCategoriesNames() async {
    try {
      final response = await apiManager.get(endPoint: '/categories/all');
      final categories = (response.data['data'] as List)
          .map((e) => AllCategories.fromJson(e))
          .toList();
      return right(categories);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }

  // ***************** getCategoryProducts implementation ********************
  @override
  Future<Either<Failures, List<ProductModel>>> getCategoryProducts(
      int id, int page) async {
    try {
      Response response = await apiManager.get(
          endPoint: '/categories/$id/products?limit=15&page=$page');

      final categoryProducts = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return Right(categoryProducts);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
