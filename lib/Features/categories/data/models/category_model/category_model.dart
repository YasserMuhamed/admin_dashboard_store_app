import 'package:equatable/equatable.dart';

import 'count.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? name;
  final String? icon;
  final String? keywords;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Count? count;

  const CategoryModel({
    this.id,
    this.name,
    this.icon,
    this.keywords,
    this.createdAt,
    this.updatedAt,
    this.count,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        icon: json['icon'] as String?,
        keywords: json['keywords'] as String?,
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
        'icon': icon,
        'keywords': keywords,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '_count': count?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      icon,
      keywords,
      createdAt,
      updatedAt,
      count,
    ];
  }
}
