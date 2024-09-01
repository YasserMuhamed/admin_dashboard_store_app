import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_details/product_details.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/repositories/dashboard_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.dashboardRepo}) : super(_DashboardInitial());

  // cubit variables
  int page = 0;
  int productsCount = 0;
  List<ProductModel> productsList = [];
  DashboardRepo dashboardRepo;
  ProductDetails data = const ProductDetails();

  // get all products cubit function
  void getProducts({bool isPaginationLoading = false}) async {
    if (!isPaginationLoading) {
      emit(DashboardLoading());
    } else {
      emit(DashboardLoadingPagination());
    }
    final products = await dashboardRepo.getAllProducts(page);
    products.fold(
      (failure) {
        if (!isPaginationLoading) {
          emit(DashboardFailure(error: failure.error));
        } else {
          emit(DashboardFailurePagination(error: failure.error));
        }
      },
      (products) {
        if (products.isNotEmpty) {
          page++;
          productsList.addAll(products);
        }
        emit(DashboardSuccess());
      },
    );
  }

  // get product details by id cubit function
  void getProductDetails(String id) async {
    emit(DetailsLoading());
    final productDetails = await dashboardRepo.getProductByID(id);
    productDetails.fold(
      (failure) => emit(DetailsFailure(error: failure.error)),
      (product) {
        emit(DetailsSuccess());
        data = product;
      },
    );
  }

  // get products count cubit function
  void getProductCount() async {
    emit(DashboardLoading());
    final count = await dashboardRepo.getProductsCount();
    count.fold(
      (failure) => emit(DashboardFailure(error: failure.error)),
      (count) {
        productsCount = count;
      },
    );
  }

  // delete product cubit function
  void deleteProduct(ProductModel productModel) async {
    emit(DashboardLoading());
    final product = await dashboardRepo.deleteProduct(productModel);
    productsList.remove(productModel);
    getProductCount();
    product.fold(
      (failure) => emit(DashboardFailure(error: failure.error)),
      (product) {
        emit(DashboardSuccess());
      },
    );
  }

  // create product cubit function
  void createProduct(
      {required String name,
      required String imageUrl,
      required String description,
      required int price,
      required int quantity,
      required int categoryId,
      required int brandId}) async {
    emit(ProductLoadingCreating());
    final product = await dashboardRepo.createProduct(
      name: name,
      imageUrl: imageUrl,
      description: description,
      price: price,
      quantity: quantity,
      categoryId: categoryId,
      brandId: brandId,
    );
    product.fold(
      (failure) => emit(ProductFailureCreating(error: failure.error)),
      (product) {
        productsList.clear();
        page = 0;
        emit(ProductSuccessCreating());
      },
    );
  }

  // edit product cubit function
  void editProduct(
      {required String name,
      required String imageUrl,
      required String description,
      required int id,
      required int price,
      required int quantity,
      required int categoryId,
      required int brandId}) async {
    emit(ProductLoadingCreating());
    final product = await dashboardRepo.editProduct(
      name: name,
      imageUrl: imageUrl,
      description: description,
      id: id,
      price: price,
      quantity: quantity,
      categoryId: categoryId,
      brandId: brandId,
    );
    product.fold(
      (failure) => emit(ProductFailureCreating(error: failure.error)),
      (product) {
        productsList.clear();
        page = 0;
        emit(ProductSuccessCreating());
      },
    );
  }
}
