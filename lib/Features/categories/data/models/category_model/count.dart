import 'package:equatable/equatable.dart';

class Count extends Equatable {
  final int? products;

  const Count({this.products});

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        products: json['products'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'products': products,
      };

  @override
  List<Object?> get props => [products];
}
