part of 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class _CategoriesInitial extends CategoriesState {}

// ************* Categories Simple States *************

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {}

final class CategoriesFailure extends CategoriesState {
  const CategoriesFailure({required this.error});
  final String error;
}

// ************* Categories Editing States *************

final class CategoriesLoadingEditing extends CategoriesState {}

final class CategoriesFailedEditing extends CategoriesState {
  final String error;
  const CategoriesFailedEditing({required this.error});
}

// ************* Categories Deleting States *************

final class CategoriesFailedDeleting extends CategoriesState {
  final String error;
  const CategoriesFailedDeleting({required this.error});
}

// ************* Categories Creating States *************

final class CategoriesLoadingCreating extends CategoriesState {}

final class CategoriesFailedCreating extends CategoriesState {
  final String error;
  const CategoriesFailedCreating({required this.error});
}

// ************* Categories Pagination States *************

final class CategoriesLoadingPagination extends CategoriesState {}

final class CategoriesFailurePagination extends CategoriesState {
  const CategoriesFailurePagination({required this.error});
  final String error;
}

// ************* Category products States *************

final class CategoryProductLoading extends CategoriesState {}

final class CategoryProductSuccess extends CategoriesState {}

final class CategoryProductFailure extends CategoriesState {
  const CategoryProductFailure({required this.error});
  final String error;
}

// pagination states for products
final class CategoryProductLoadingPagination extends CategoriesState {}

final class CategoryProductFailurePagination extends CategoriesState {
  const CategoryProductFailurePagination({required this.error});
  final String error;
}
