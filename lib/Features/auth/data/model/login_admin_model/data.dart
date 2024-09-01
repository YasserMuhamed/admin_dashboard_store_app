import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? token;

  const Data({this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };

  @override
  List<Object?> get props => [token];
}
