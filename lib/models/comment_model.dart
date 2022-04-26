import 'package:edu_books_flutter/models/user_model.dart';

class CommentModel{
  final int id;
  final int bookId;
  final UserModel user;
  final String comment;
  final int rating;
  final String avatar;
  final bool isUpdating;
  final String? createdAt;
  final String? updatedAt;


  CommentModel({
    required this.id,
    required this.user,
    required this.bookId,
    required this.comment,
    required this.rating,
    required this.avatar,
    this.isUpdating = false,
    this.createdAt,
    this.updatedAt,
  });


  factory CommentModel.fromJson(dynamic json) {
    return CommentModel(
      id: json["id"] as int,
      bookId: json["book_id"] as int,
      rating: json["rating"] as int,
      user: UserModel.fromJson(json["user"]),
      avatar: json["user"]['avatar'],
      comment: json["comment"] as String,
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }


CommentModel copyWith({
  int? id,
  int? bookId,
  UserModel? user,
  String? comment,
  int? rating,
  String? avatar,
  bool? isUpdating,
  String? createdAt,
  String? updatedAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      user: user ?? this.user,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      avatar: avatar ?? this.avatar,
      isUpdating: isUpdating ?? this.isUpdating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}