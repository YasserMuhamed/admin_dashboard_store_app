import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_details/product_details.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepo {
  // ************* get all products *************
  Future<Either<Failures, List<ProductModel>>> getAllProducts(int page);

  // ************* get product by id *************
  Future<Either<Failures, ProductDetails>> getProductByID(String id);

  // ************* get products count *************
  Future<Either<Failures, int>> getProductsCount();

  // ************* delete product *************
  Future<Either<Failures, ProductModel>> deleteProduct(
      ProductModel productModel);

  // ************* create product *************
  Future<Either<Failures, ProductModel>> createProduct(
      {required String name,
      required String imageUrl,
      required String description,
      required int price,
      required int quantity,
      required int categoryId,
      required int brandId});

  // ************* edit product by ID*************
  Future<Either<Failures, ProductModel>> editProduct(
      {required String name,
      required String imageUrl,
      required String description,
      required int id,
      required int price,
      required int quantity,
      required int categoryId,
      required int brandId});
}
