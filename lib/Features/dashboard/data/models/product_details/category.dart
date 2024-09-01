import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String? icon;
  final String? name;
  final String? keywords;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Category({
    this.id,
    this.icon,
    this.name,
    this.keywords,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        icon: json['icon'] as String?,
        name: json['name'] as String?,
        keywords: json['keywords'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'icon': icon,
        'name': name,
        'keywords': keywords,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      icon,
      name,
      keywords,
      createdAt,
      updatedAt,
    ];
  }
}
