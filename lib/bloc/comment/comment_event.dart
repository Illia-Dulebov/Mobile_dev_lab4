part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}



class LoadComment extends CommentEvent {
  final int bookId;

  const LoadComment({required this.bookId});
}

class AddComment extends CommentEvent {
  final int bookId;
  final UserModel user;
  final String comment;
  final int rating;

  const AddComment({required this.bookId, required this.user, required this.comment, required this.rating});
}


class DeleteComment extends CommentEvent{
  final int id;


  const DeleteComment({required this.id});
}


class UpdateComment extends CommentEvent{
  final int id;
  final int bookId;
  final String comment;
  final int rating;

  const UpdateComment({required this.id, required this.comment, required this.rating, required this.bookId});
}


class StartUpdating extends CommentEvent{
  final int id;

  const StartUpdating({required this.id});
}

class FinishUpdating extends CommentEvent{}


