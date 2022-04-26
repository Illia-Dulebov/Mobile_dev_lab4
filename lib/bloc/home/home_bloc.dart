import 'package:edu_books_flutter/models/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/network_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadAllToHome>(_onLoadAllToHome);
    on<UpdateVisited>(_onUpdateVisited);
    on<DeleteVisited>(_onDeleteVisited);
  }

  void _onDeleteVisited(
    DeleteVisited event,
    Emitter<HomeState> emit,
  ) async {
    await NetworkRepository().removeViewed();
    Map<String, List<BookModel>> homeBooks = Map.from((state as HomeSuccess).bookMap);
    homeBooks['visited'] = [];
    emit(HomeSuccess(bookMap: homeBooks));
  } 

  void _onUpdateVisited(
    UpdateVisited event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeSuccess) {
      List<BookModel> allBooksList = await NetworkRepository().getBooks();
      Map<String, List<BookModel>> homeBooks = Map.from((state as HomeSuccess).bookMap);
      List<int> viewedBooks = await NetworkRepository().addNewViewed(event.bookId);
      homeBooks['visited'] = [];
      for (var item in viewedBooks) {
        homeBooks['visited']?.add(allBooksList
          .where((element) => element.id == item)
          .toList()[0]);
      }
      emit(HomeSuccess(bookMap: homeBooks));
    }
  }

  void _onLoadAllToHome(
    LoadAllToHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      await NetworkRepository().loadSession();
      List<BookModel> allBooksList = await NetworkRepository().getBooks();
      List<int> viewedBooks = await NetworkRepository().getViewed();

      Map<String, List<BookModel>> homeBooks = {
        "popular": allBooksList
            .where((element) => element.popularityCoefficient > 3)
            .toList(),
        "sale":
            allBooksList.where((element) => element.sailPrice != null).toList(),
        "visited": allBooksList
            .where((element) => viewedBooks.contains(element.id))
            .toList()
      };
      emit(HomeSuccess(bookMap: homeBooks));
    } catch (err) {
      emit(HomeFailure());
      throw ("Problem Home book loading");
    }
  }
}
