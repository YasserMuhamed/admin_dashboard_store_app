import 'package:equatable/equatable.dart';

class AllBrands extends Equatable {
	final int? id;
	final String? name;

	const AllBrands({this.id, this.name});

	factory AllBrands.fromJson(Map<String, dynamic> json) => AllBrands(
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
