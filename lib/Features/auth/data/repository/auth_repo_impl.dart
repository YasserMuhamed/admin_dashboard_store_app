import 'package:admin_dashboard_store_app/Core/api/api_manager.dart';
import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/model/login_admin_model/login_admin_model.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/model/register_admin_model/register_admin_model.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.apiManager});

  final ApiManager apiManager;

  // ***************Login Implementation***************
  @override
  Future<Either<Failures, LoginAdminModel>> login(
      String email, String password) async {
    try {
      Response response = await apiManager.post(
          endPoint: 'admins/login',
          data: {'email': email, 'password': password});
      LoginAdminModel loginAdminModel = LoginAdminModel.fromJson(response.data);
      return Right(loginAdminModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }

  // ***************Register Implementation***************
  @override
  Future<Either<Failures, RegisterAdminModel>> register(String username,
      String email, String password, String phoneNumber) async {
    try {
      Response response = await apiManager.post(
          endPoint: 'admins/register',
          data: {
            'email': email,
            'password': password,
            "name": username,
            "phone": phoneNumber
          });
      RegisterAdminModel registerAdminModel =
          RegisterAdminModel.fromJson(response.data);

      return Right(registerAdminModel);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      } else {
        return Left(ServerFailure(error: e.toString()));
      }
    }
  }
}
