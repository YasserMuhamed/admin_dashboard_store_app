import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final int? id;
  final String? name;
  final String? logo;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Brand({
    this.id,
    this.name,
    this.logo,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo,
        'description': description,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
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
    ];
  }
}
