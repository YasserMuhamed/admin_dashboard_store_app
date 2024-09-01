import 'package:admin_dashboard_store_app/Features/auth/data/model/register_admin_model/register_admin_model.dart';
import 'package:admin_dashboard_store_app/Features/auth/data/repository/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());

  final AuthRepo authRepo;
  RegisterAdminModel? registerAdminModel;

  //************ register implementation in cubit ************
  void register({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());
    final response =
        await authRepo.register(username, email, password, phoneNumber);
    response.fold(
      (left) => emit(RegisterFailure(left.error)),
      (right) {
        emit(RegisterSuccess());
        registerAdminModel = right;
      },
    );
  }
}
