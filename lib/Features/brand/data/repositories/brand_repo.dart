import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/all_brands.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:dartz/dartz.dart';

abstract class BrandRepo {
  // Get brand's Products by id
  Future<Either<Failures, BrandModel>> getBrandProducts(int id);

  // Get all brands
  Future<Either<Failures, List<BrandModel>>> getAllBrand(int page);

  // Get brands count
  Future<Either<Failures, int>> getBrandsCount();

  // Get brands names
  Future<Either<Failures, List<AllBrands>>> getBrandsNames();

  // Create brand
  Future<Either<Failures, BrandModel>> createBrand(
      String name, String image, String description);

  // Update brand
  Future<Either<Failures, BrandModel>> updateBrand(
      String name, String image, String description, BrandModel brandModel);

  // Delete brand
  Future<Either<Failures, BrandModel>> deleteBrand(BrandModel brandModel);
}
