import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String? createdAt;
  final String? updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      avatar: json["avatar"] as String,
      createdAt: json["created_at"] as String,
      updatedAt: json["updated_at"] as String,
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["avatar"] = avatar;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? avatar,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, email, avatar, createdAt, updatedAt];
}
