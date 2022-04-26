part of 'comment_bloc.dart';

enum CommentStatus { loading, success, failure }

class CommentState extends Equatable {
  final CommentStatus status;
  final List<CommentModel> comments;

  const CommentState({
    this.status = CommentStatus.loading,
    this.comments = const [],
  });

  CommentState copyWith({
    CommentStatus? status,
    List<CommentModel>? comments,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [comments, status];
}