part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class _DashboardInitial extends DashboardState {}

//  ***************** Dashboard *****************

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {}

class DashboardFailure extends DashboardState {
  final String error;
  const DashboardFailure({required this.error});
}

//  ***************** Pagination *****************

class DashboardLoadingPagination extends DashboardState {}

class DashboardFailurePagination extends DashboardState {
  final String error;
  const DashboardFailurePagination({required this.error});
}

//  ***************** Creating Product *****************


class ProductSuccessCreating extends DashboardState {}

class ProductLoadingCreating extends DashboardState {}

class ProductFailureCreating extends DashboardState {
  final String error;
  const ProductFailureCreating({required this.error});
}

// ***************** Details of Product *****************
class DetailsLoading extends DashboardState {}

class DetailsSuccess extends DashboardState {}

class DetailsFailure extends DashboardState {
  final String error;
  const DetailsFailure({required this.error});
}
