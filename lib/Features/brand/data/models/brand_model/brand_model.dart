import 'package:equatable/equatable.dart';

import 'count.dart';

class BrandModel extends Equatable {
  final int? id;
  final String? name;
  final String? logo;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Count? count;

  const BrandModel({
    this.id,
    this.name,
    this.logo,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        logo: json['logo'] as String?,
        description: json['description'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        count: json['_count'] == null
            ? null
            : Count.fromJson(json['_count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo,
        'description': description,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '_count': count?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      logo,
      description,
      createdAt,
      updatedAt,
      count,
    ];
  }
}
