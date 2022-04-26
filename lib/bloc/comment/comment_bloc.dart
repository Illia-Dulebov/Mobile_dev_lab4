import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/comment_model.dart';
import '../../models/user_model.dart';
import '../../network/network_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentState()) {
    on<AddComment>(_onAddComment);
    on<LoadComment>(_onLoadComment);
    on<DeleteComment>(_onDeleteComment);
    on<UpdateComment>(_onUpdateComment);
    on<StartUpdating>(_onStartUpdating);
    on<FinishUpdating>(_onFinishUpdating);
  }

  void _onStartUpdating(
    StartUpdating event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(
        comments: List<CommentModel>.from(state.comments)
            .map((e) => e.copyWith(isUpdating: event.id == e.id))
            .toList()));
  }

  void _onFinishUpdating(
    FinishUpdating event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(
        comments: List<CommentModel>.from(state.comments)
            .map((e) => e.copyWith(isUpdating: false))
            .toList()));
  }

  void _onUpdateComment(
    UpdateComment event,
    Emitter<CommentState> emit,
  ) async {
    try {
      Map<String, dynamic> data = {
        'comment': event.comment,
        'rating': event.rating,
        'book_id': event.bookId,
        'id': event.id,
      };
      CommentModel comment = await NetworkRepository().updateComment(data);
      emit(state.copyWith(
          comments: List<CommentModel>.from(state.comments)
              .map((e) => e.id == comment.id ? comment : e)
              .toList()));
    } catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }

  void _onDeleteComment(
    DeleteComment event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(
        comments: List.from(
            state.comments.where((element) => element.id != event.id))));
    await NetworkRepository().deleteComment(event.id);
  }

  void _onAddComment(
    AddComment event,
    Emitter<CommentState> emit,
  ) async {
    try {
      Map<String, dynamic> data = {
        'book_id': event.bookId,
        'user_id': event.user.id,
        'customer_email': event.user.email,
        'comment': event.comment,
        'rating': event.rating,
      };
      CommentModel comment = await NetworkRepository().createComment(data);

      emit(state.copyWith(
          comments: List.from(state.comments)..insert(0, comment)));
    } catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }

  void _onLoadComment(
    LoadComment event,
    Emitter<CommentState> emit,
  ) async {
    List<dynamic> bookData = await NetworkRepository().getBook(event.bookId);
    List<CommentModel> comments = List<dynamic>.from(bookData[0]['reviews'])
        .map((e) => CommentModel.fromJson(e))
        .toList();
    emit(state.copyWith(
        comments: comments.reversed.toList(), status: CommentStatus.success));
  }
}
