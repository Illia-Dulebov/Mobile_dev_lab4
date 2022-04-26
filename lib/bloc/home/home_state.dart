part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Map<String, List<BookModel>> bookMap;

  const HomeSuccess({required this.bookMap});

  @override
  List<Object> get props => [bookMap];
}

class HomeFailure extends HomeState {}
