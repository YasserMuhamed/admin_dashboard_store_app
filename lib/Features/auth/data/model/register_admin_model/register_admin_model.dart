import 'package:equatable/equatable.dart';

import 'data.dart';

class RegisterAdminModel extends Equatable {
  final String? message;
  final int? status;
  final String? token;
  final Data? data;

  const RegisterAdminModel({
    this.message,
    this.status,
    this.token,
    this.data,
  });

  factory RegisterAdminModel.fromJson(Map<String, dynamic> json) {
    return RegisterAdminModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      token: json['token'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
        'token': token,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [message, status, token, data];
}
