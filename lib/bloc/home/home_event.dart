part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAllToHome extends HomeEvent {}


class UpdateVisited extends HomeEvent {
  final int bookId;

  const UpdateVisited({required this.bookId});
}


class DeleteVisited extends HomeEvent {}
