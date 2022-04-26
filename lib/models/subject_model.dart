import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  final int id;
  final String name;

  const SubjectModel({
    required this.id,
    required this.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }

  SubjectModel copyWith({
    int? id,
    String? name,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props =>
      [id, name];
}
