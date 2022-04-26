part of 'book_bloc.dart';

enum BookStatus { loading, success, failure }

class BookState extends Equatable {
  final BookStatus status;
  final String publishingHouse;

  const BookState({
    this.status = BookStatus.loading,
    this.publishingHouse = '',
  });

  BookState copyWith({
    BookStatus? status,
    String? publishingHouse,
  }) {
    return BookState(
      status: status ?? this.status,
      publishingHouse: publishingHouse ?? this.publishingHouse,
    );
  }

  @override
  List<Object> get props => [publishingHouse];
}
