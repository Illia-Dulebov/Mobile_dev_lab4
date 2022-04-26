import 'package:edu_books_flutter/network/network_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookState()) {
    on<BookPublishingHouseLoad>(_onBookPublishingHouseLoaded);
    on<BookIdLoad>(_onBookLoadFromId);
  }

  void _onBookLoadFromId(
    BookIdLoad event,
    Emitter<BookState> emit,
  ) async {
    try {
      await NetworkRepository().getBook(event.id);
    } catch (_) {
      emit(state.copyWith(
        status: BookStatus.failure,
      ));
    }
  }

  void _onBookPublishingHouseLoaded(
    BookPublishingHouseLoad event,
    Emitter<BookState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: BookStatus.loading,
        publishingHouse: '',
      ));
      final publishingHouse =
          await NetworkRepository().getPublishingHouse(event.id);
      emit(state.copyWith(
        status: BookStatus.success,
        publishingHouse: publishingHouse,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: BookStatus.failure,
      ));
    }
  }
}
