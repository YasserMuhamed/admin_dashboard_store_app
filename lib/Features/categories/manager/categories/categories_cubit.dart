import 'package:admin_dashboard_store_app/Features/categories/data/models/all_categories.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/models/category_model/category_model.dart';
import 'package:admin_dashboard_store_app/Features/categories/data/repositories/categories_repo.dart';
import 'package:admin_dashboard_store_app/Features/dashboard/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.categoriesRepo}) : super(_CategoriesInitial());
  final CategoriesRepo categoriesRepo;

  // Cubit Main Variables
  int page = 0;
  int categoryProductsPageNum = 0;
  int categoriesCount = 0;
  List<CategoryModel> categoriesList = [];
  List<AllCategories> categoriesNames = [];
  List<ProductModel> categoryProductsList = [];

  // Get all categories cubit function
  void getAllCategories({bool isPaginationLoading = false}) async {
    if (!isPaginationLoading) {
      emit(CategoriesLoading());
    } else {
      emit(CategoriesLoadingPagination());
    }

    final categories = await categoriesRepo.getAllCategories(page);
    categories.fold(
      (l) {
        if (!isPaginationLoading) {
          emit(CategoriesFailure(error: l.error));
        } else {
          emit(CategoriesFailurePagination(error: l.error));
        }
      },
      (r) {
        if (r.isNotEmpty) {
          page++;
          categoriesList.addAll(r);
        }
        emit(CategoriesSuccess());
      },
    );
  }

  // Get categories count cubit function
  void getCategoriesCount() async {
    final count = await categoriesRepo.getCategoriesCount();
    count.fold(
      (failure) => emit(CategoriesFailure(error: failure.error)),
      (count) {
        emit(CategoriesSuccess());
        categoriesCount = count;
        // print(count);
      },
    );
  }

  // Delete category cubit function
  void deleteCategory(CategoryModel categoryModel) async {
    emit(CategoriesLoading());
    final category = await categoriesRepo.deleteCategory(categoryModel);
    categoriesList.remove(categoryModel);
    getCategoriesCount();
    category.fold(
      (failure) => emit(CategoriesFailedDeleting(error: failure.error)),
      (category) {
        // categoriesList.clear();
        // page = 0;
        emit(CategoriesSuccess());
      },
    );
  }

  // Update category cubit function
  void updateCategory({
    required String name,
    required String keywords,
    required String iconImage,
    required CategoryModel categoryModel,
  }) async {
    emit(CategoriesLoadingEditing());
    final category = await categoriesRepo.updateCategory(
        name, keywords, iconImage, categoryModel);
    category.fold(
      (failure) => {
        emit(CategoriesFailedEditing(error: failure.error)),
        print("error:   Cubiitttt  IMPLLLLLLLLLLLLLLL")
      },
      (category) {
        categoriesList.clear();
        page = 0;
        emit(CategoriesSuccess());
      },
    );
  }

  // Create category cubit function
  void createCategory({
    required String name,
    required String keywords,
    required String iconImage,
  }) async {
    emit(CategoriesLoadingCreating());
    final category =
        await categoriesRepo.createCategory(name, keywords, iconImage);
    category.fold(
      (failure) => emit(CategoriesFailedCreating(error: failure.error)),
      (category) {
        categoriesList.clear();
        page = 0;
        emit(CategoriesSuccess());
      },
    );
  }

  // Get categories names cubit function
  void getCategoriesNames() async {
    final categories = await categoriesRepo.getCategoriesNames();
    categories.fold(
      (l) => emit(CategoriesFailure(error: l.error)),
      (r) {
        if (r.isNotEmpty) {
          categoriesNames = r;
        }
        emit(CategoriesSuccess());
      },
    );
  }

  // Get category products cubit function
  void getCategoryProducts(
      {required int id, bool isPaginationLoading = false}) async {
    if (isPaginationLoading) {
      emit(CategoryProductLoadingPagination());
    } else {
      emit(CategoryProductLoading());
    }
    final products =
        await categoriesRepo.getCategoryProducts(id, categoryProductsPageNum);
    products.fold(
      (l) {
        if (isPaginationLoading) {
          emit(CategoryProductFailurePagination(error: l.error));
        } else {
          emit(CategoryProductFailure(error: l.error));
        }
      },
      (r) {
        if (r.isNotEmpty) {
          categoryProductsPageNum++;
          categoryProductsList.addAll(r);
        }

        emit(CategoryProductSuccess());
      },
    );
  }
}
