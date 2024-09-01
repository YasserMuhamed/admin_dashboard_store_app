import 'package:equatable/equatable.dart';

class AllCategories extends Equatable {
	final int? id;
	final String? name;

	const AllCategories({this.id, this.name});

	factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
				id: json['id'] as int?,
				name: json['name'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
			};

	@override
	List<Object?> get props => [id, name];
}
