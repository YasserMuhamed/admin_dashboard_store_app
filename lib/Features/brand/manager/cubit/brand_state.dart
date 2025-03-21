part of 'brand_cubit.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class _BrandInitial extends BrandState {}

// ****************** Brand Basics States ******************

class BrandSuccess extends BrandState {}

class BrandLoading extends BrandState {}

class BrandFailure extends BrandState {
  final String error;
  const BrandFailure({required this.error});
}

// ****************** Brand Creating States ******************

class BrandLoadingCreating extends BrandState {}

class BrandFailureCreating extends BrandState {
  final String error;
  const BrandFailureCreating({required this.error});
}

// ****************** Brand Editing States ******************

class BrandLoadingEditing extends BrandState {}

class BrandFailureEditing extends BrandState {
  final String error;
  const BrandFailureEditing({required this.error});
}

// ****************** Brand Pagination States ******************

class BrandLoadingPagination extends BrandState {}

class BrandFailurePagination extends BrandState {
  final String error;
  const BrandFailurePagination({required this.error});
}

// ************* Brand products States *************

final class BrandProductLoading extends BrandState {}

final class BrandProductSuccess extends BrandState {}

final class BrandProductFailure extends BrandState {
  const BrandProductFailure({required this.error});
  final String error;
}

// pagination states for products
final class BrandProductLoadingPagination extends BrandState {}

final class BrandProductFailurePagination extends BrandState {
  const BrandProductFailurePagination({required this.error});
  final String error;
}

// brand extra states
final class BrandSuccessExtra extends BrandState {}

final class BrandFailureExtra extends BrandState {
  const BrandFailureExtra({required this.error});
  final String error;
}
