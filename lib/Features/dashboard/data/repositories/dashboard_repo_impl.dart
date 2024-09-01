import 'package:admin_dashboard_store_app/Core/api/api_manager.dart';
import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_details/product_details.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/repositories/dashboard_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DashboardRepoImpl implements DashboardRepo {
  DashboardRepoImpl({required this.apiManager});
  final ApiManager apiManager;
  List<ProductModel> products = [];

  // ************* Get all products implementation *************
  @override
  Future<Either<Failures, List<ProductModel>>> getAllProducts(int page) async {
    try {
      Response response =
          await apiManager.get(endPoint: 'products?page=$page&limit=10');
      products = (response.data["data"] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return Right(products);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //************* Delete product implementation *************
  @override
  Future<Either<Failures, ProductModel>> deleteProduct(
      ProductModel productModel) async {
    try {
      Response response = await apiManager.delete(
          endPoint: 'products/${productModel.id}/delete');
      ProductModel product = ProductModel.fromJson(response.data["data"]);
      return Right(product);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //************* Get product by id implementation *************
  @override
  Future<Either<Failures, ProductDetails>> getProductByID(String id) async {
    try {
      Response response = await apiManager.get(endPoint: 'products/$id');
      ProductDetails productDetails =
          ProductDetails.fromJson(response.data["data"]);
      return Right(productDetails);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //************* Get products count implementation *************
  @override
  Future<Either<Failures, int>> getProductsCount() async {
    try {
      Response response = await apiManager.get(endPoint: 'products/counts');
      int count = response.data["data"]["countAll"];
      return Right(count);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //************* Create product implementation *************
  @override
  Future<Either<Failures, ProductModel>> createProduct(
      {required String name,
      required String imageUrl,
      required int price,
      required int quantity,
      required String description,
      required int categoryId,
      required int brandId}) async {
    try {
      Response response =
          await apiManager.post(endPoint: "/products/create", data: {
        "name": name,
        "price": price,
        "quantity": quantity,
        "picture": imageUrl,
        "description": description,
        "categoryId": categoryId,
        "brandId": brandId
      });
      ProductModel product = ProductModel.fromJson(response.data["data"]);
      return Right(product);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //************* Edit product by ID implementation *************
  @override
  Future<Either<Failures, ProductModel>> editProduct(
      {required String name,
      required String imageUrl,
      required String description,
      required int id,
      required int price,
      required int quantity,
      required int categoryId,
      required int brandId}) async {
    try {
      Response response =
          await apiManager.patch(endPoint: "/products/$id/update", data: {
        "name": name,
        "price": price,
        "quantity": quantity,
        "picture": imageUrl,
        "description": description,
        "categoryId": categoryId,
        "brandId": brandId
      });
      ProductModel product = ProductModel.fromJson(response.data["data"]);
      return Right(product);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}
