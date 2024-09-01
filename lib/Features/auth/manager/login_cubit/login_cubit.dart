import 'package:admin_dashboard_store_app/Core/api/dio_factory.dart';
import 'package:admin_dashboard_store_app/Core/helpers/shared_pref_helper.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/model/login_admin_model/login_admin_model.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(_LoginInitial());

  final AuthRepo authRepo;
  LoginAdminModel? loginAdminModel;

  // ************ Login Implementation in Cubit ************
  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final response = await authRepo.login(email, password);
    response.fold(
      (left) {
        emit(LoginFailure(left.error));
      },
      (right) async {
        loginAdminModel = right;
        await saveToken(right.data!.token!);
        emit(LoginSuccess());
      },
    );
  }

  // ************ Save Token implementation ************
  Future<void> saveToken(String token) async {
    await SharedPrefHelper.setData("userToken", token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  // ************ Logout implementation ************
  void logout() async {
    await SharedPrefHelper.clearAllSecuredData();
    debugPrint('token has been removed');
  }
}
