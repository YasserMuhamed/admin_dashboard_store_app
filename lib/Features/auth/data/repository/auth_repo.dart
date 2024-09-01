import 'package:admin_dashboard_store_app/Core/error/failures.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/model/login_admin_model/login_admin_model.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/model/register_admin_model/register_admin_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  ///Login requires (email , password)
  Future<Either<Failures, LoginAdminModel>> login(
      String email, String password);

  ///Register requires (username , email , password , phoneNumber)
  Future<Either<Failures, RegisterAdminModel>> register(
      String username, String email, String password, String phoneNumber);
}
