import 'package:admin_dashboard_store_app/Features/brand/data/models/all_brands.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/models/brand_model/brand_model.dart';
import 'package:admin_dashboard_store_app/Features/brand/data/repositories/brand_repo.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit({required this.brandRepo}) : super(_BrandInitial());
  final BrandRepo brandRepo;

  // Cubit Main Variables
  int page = 0;
  int brandProductsPageNum = 0;
  int brandsCount = 0;
  List<BrandModel> brandsList = [];
  List<AllBrands> brandsNames = [];
  List<ProductModel> brandProductsList = [];

  // Get all brands cubit function
  void getAllBrands({bool isPaginationLoading = false}) async {
    if (!isPaginationLoading) {
      emit(BrandLoading());
    } else {
      emit(BrandLoadingPagination());
    }
    final brands = await brandRepo.getAllBrand(page);
    brands.fold((l) {
      if (!isPaginationLoading) {
        emit(BrandFailure(error: l.error));
      } else {
        emit(BrandFailurePagination(error: l.error));
      }
    }, (r) {
      if (r.isNotEmpty) {
        page++;
        brandsList.addAll(r);
      }
      emit(BrandSuccess());
    });
  }

  // Get brands count cubit function
  void getBrandsCount() async {
    final count = await brandRepo.getBrandsCount();
    count.fold((l) {
      emit(BrandFailureExtra(error: l.error));
    }, (r) {
      brandsCount = r;
      emit(BrandSuccessExtra());
    });
  }

  // Delete brand cubit function
  void deleteBrand(BrandModel brandModel) async {
    emit(BrandLoading());
    final brand = await brandRepo.deleteBrand(brandModel);
    brandsList.remove(brandModel);

    getBrandsCount();
    brand.fold((l) {
      emit(BrandFailure(error: l.error));
    }, (r) {
      // brandsList.clear();
      // page = 0;
      emit(BrandSuccess());
    });
  }

  // Update brand cubit function
  void updateBrand(
      {required String name,
      required String image,
      required String description,
      required BrandModel brandModel}) async {
    emit(BrandLoadingEditing());
    final brand =
        await brandRepo.updateBrand(name, image, description, brandModel);
    brand.fold((l) {
      emit(BrandFailureEditing(error: l.error));
    }, (r) {
      brandsList.clear();
      page = 0;
      emit(BrandSuccess());
    });
  }

  // Create brand cubit function
  void createBrand({
    required String name,
    required String image,
    required String description,
  }) async {
    emit(BrandLoadingCreating());
    final brand = await brandRepo.createBrand(name, image, description);
    brand.fold((l) {
      emit(BrandFailureCreating(error: l.error));
    }, (r) {
      brandsList.clear();
      page = 0;
      emit(BrandSuccess());
    });
  }

  // Get brands names cubit function
  void getBrandsNames() async {
    final brands = await brandRepo.getBrandsNames();
    brands.fold((l) {
      emit(BrandFailure(error: l.error));
    }, (r) {
      emit(BrandSuccess());
      if (r.isNotEmpty) {
        brandsNames = r;
      }
    });
  }

  // Get Brand products cubit function
  void getBrandProducts(
      {required int id, bool isPaginationLoading = false}) async {
    if (isPaginationLoading) {
      emit(BrandProductLoadingPagination());
    } else {
      emit(BrandProductLoading());
    }
    final products = await brandRepo.getBrandProducts(id, brandProductsPageNum);
    products.fold(
      (l) {
        if (isPaginationLoading) {
          emit(BrandProductFailurePagination(error: l.error));
        } else {
          emit(BrandProductFailure(error: l.error));
        }
      },
      (r) {
        if (r.isNotEmpty) {
          brandProductsPageNum++;
          brandProductsList.addAll(r);
        }

        emit(BrandProductSuccess());
      },
    );
  }
}
