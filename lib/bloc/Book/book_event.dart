part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class BookIdLoad extends BookEvent {
  final int id;

  const BookIdLoad({required this.id});
}

class BookPublishingHouseLoad extends BookEvent {
  final int id;

  const BookPublishingHouseLoad({required this.id});
}




