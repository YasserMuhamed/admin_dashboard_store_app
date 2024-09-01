import 'package:equatable/equatable.dart';

import 'brand.dart';
import 'category.dart';

class ProductDetails extends Equatable {
  final int? id;
  final String? name;
  final int? price;
  final int? quantity;
  final String? description;
  final String? picture;
  final int? categoryId;
  final int? brandId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final Brand? brand;
  final List<dynamic>? pictures;

  const ProductDetails({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.description,
    this.picture,
    this.categoryId,
    this.brandId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.brand,
    this.pictures,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      description: json['description'] as String?,
      picture: json['picture'] as String?,
      categoryId: json['categoryId'] as int?,
      brandId: json['brandId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      pictures: json['pictures'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'quantity': quantity,
        'description': description,
        'picture': picture,
        'categoryId': categoryId,
        'brandId': brandId,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'category': category?.toJson(),
        'brand': brand?.toJson(),
        'pictures': pictures,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      quantity,
      description,
      picture,
      categoryId,
      brandId,
      createdAt,
      updatedAt,
      category,
      brand,
      pictures,
    ];
  }
}
