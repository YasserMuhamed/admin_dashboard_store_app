import 'package:admin_dashboard_store_app/Core/api/api_manager.dart';
import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/all_brands.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/repositories/brand_repo.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BrandRepoImpl implements BrandRepo {
  BrandRepoImpl({required this.apiManager});

  final ApiManager apiManager;
  final int limit = 12;

  //****************** Get All Brands Implementation ******************
  @override
  Future<Either<Failures, List<BrandModel>>> getAllBrand(int page) async {
    try {
      Response response =
          await apiManager.get(endPoint: "/brands?page=$page&limit=$limit");
      List<BrandModel> brands = (response.data["data"] as List)
          .map((e) => BrandModel.fromJson(e))
          .toList();
      if (brands.isEmpty) {
        return Left(ServerFailure(error: "No brands available"));
      }
      return Right(brands);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //****************** Get Brand Implementation ******************
  @override
  Future<Either<Failures, List<ProductModel>>> getBrandProducts(
      int id, int page) async {
    try {
      Response response = await apiManager.get(
          endPoint: '/brands/$id/products?limit=10&page=$page');

      final brandProducts = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return Right(brandProducts);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(error: e.toString()));
    }
  }

  //****************** Get Brands Count Implementation ******************
  @override
  Future<Either<Failures, int>> getBrandsCount() async {
    try {
      Response response = await apiManager.get(endPoint: "/brands/counts");
      int brandsCount = (response.data["data"]["brands"]);

      return Right(brandsCount);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //****************** Delete Brand Implementation ******************
  @override
  Future<Either<Failures, BrandModel>> deleteBrand(
      BrandModel brandModel) async {
    try {
      var response =
          await apiManager.delete(endPoint: "/brands/${brandModel.id}/delete");
      BrandModel brand = BrandModel.fromJson(response.data["data"]);
      return Right(brand);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //****************** Update Brand Implementation ******************
  @override
  Future<Either<Failures, BrandModel>> updateBrand(String name, String image,
      String description, BrandModel brandModel) async {
    try {
      Response response = await apiManager
          .patch(endPoint: "/brands/${brandModel.id}/update", data: {
        "name": name,
        "logo": image,
        "description": description,
      });
      return Right(BrandModel.fromJson(response.data["data"]));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //****************** Create Brand Implementation ******************
  @override
  Future<Either<Failures, BrandModel>> createBrand(
      String name, String image, String description) async {
    try {
      Response response =
          await apiManager.post(endPoint: "/brands/create", data: {
        "name": name,
        "logo": image,
        "description": description,
      });
      return Right(BrandModel.fromJson(response.data["data"]));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  //****************** Get Brands Names Implementation ******************
  @override
  Future<Either<Failures, List<AllBrands>>> getBrandsNames() async {
    try {
      Response response = await apiManager.get(endPoint: "/brands/all");
      List<AllBrands> brands = (response.data['data'] as List)
          .map((e) => AllBrands.fromJson(e))
          .toList();
      return Right(brands);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}
