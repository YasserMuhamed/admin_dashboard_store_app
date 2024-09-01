import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/all_categories.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepo {
  // Get all categories
  Future<Either<Failures, List<CategoryModel>>> getAllCategories(int page);

  // Get category Products
  Future<Either<Failures, List<ProductModel>>> getCategoryProducts(int id,int page);

  // Get categories count
  Future<Either<Failures, int>> getCategoriesCount();

  // Get category names
  Future<Either<Failures, List<AllCategories>>> getCategoriesNames();

  // Create category
  Future<Either<Failures, CategoryModel>> createCategory(
      String name, String keywords, String iconImage);

  // Update category
  Future<Either<Failures, CategoryModel>> updateCategory(String name,
      String keywords, String iconImage, CategoryModel categoryModel);

  // Delete category
  Future<Either<Failures, CategoryModel>> deleteCategory(
      CategoryModel categoryModel);
}
