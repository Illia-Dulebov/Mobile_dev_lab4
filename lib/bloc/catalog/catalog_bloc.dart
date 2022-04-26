import 'package:bloc/bloc.dart';
import 'package:edu_books_flutter/models/subject_model.dart';
import 'package:edu_books_flutter/network/network_repository.dart';
import 'package:equatable/equatable.dart';

import '../../models/book_model.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<LoadAllToCatalog>(_onLoadAllToCatalog);
    on<LoadPopularToCatalog>(_onLoadPopularToCatalog);
    on<LoadShareToCatalog>(_onLoadShareToCatalog);
    on<ToggleKeyTempFilter>(_onToggleKeyTempFilter);
    on<LoadRecentToCatalog>(_onLoadRecentToCatalog);
    on<SearchFromCatalog>(_onSearchFromCatalog);
    on<ConfirmFilters>(_onConfirmFilters);
  }

  void _onConfirmFilters(
    ConfirmFilters event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogSuccess) {
      emit((state as CatalogSuccess).copyWith(
        filters: Map.from((state as CatalogSuccess).unconfirmedFilters),
      ));
    }
  }

  void _onToggleKeyTempFilter(
    ToggleKeyTempFilter event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogSuccess) {
      Map<String, dynamic> newUnconfirmedFiltersCopy =
          Map.from((state as CatalogSuccess).unconfirmedFilters);
      Map<String, dynamic> newUnconfirmedFilters = {};

      if (!newUnconfirmedFiltersCopy.containsKey(event.key) ||
          newUnconfirmedFiltersCopy[event.key] == null) {
        newUnconfirmedFilters[event.key] = <int>[event.optionId];
      } else {
        if (!(newUnconfirmedFiltersCopy[event.key] as List<int>)
            .contains(event.optionId)) {
          newUnconfirmedFilters[event.key] = List<int>.from(
              (newUnconfirmedFiltersCopy[event.key] as List<int>))
            ..add(event.optionId);
        } else {
          newUnconfirmedFilters[event.key] = List<int>.from(
              (newUnconfirmedFiltersCopy[event.key] as List<int>))
            ..remove(event.optionId);
          if ((newUnconfirmedFiltersCopy[event.key] as List<int>).isEmpty) {
            newUnconfirmedFilters.remove(event.key);
          }
        }
      }
      for (String key in newUnconfirmedFiltersCopy.keys
          .where((element) => element != event.key)) {
        newUnconfirmedFilters[key] =
            List<int>.from(newUnconfirmedFiltersCopy[key]);
      }
      emit((state as CatalogSuccess)
          .copyWith(unconfirmedFilters: Map.from(newUnconfirmedFilters)));
    }
  }

  void _onSearchFromCatalog(
    SearchFromCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      if (state is CatalogSuccess) {
        var cat = (state as CatalogSuccess).loadedBookList;
        List<BookModel> result = [];

        // text search
        if (event.input == '' || event.input == null) {
          result = cat;
        } else {
          result = await NetworkRepository().searchBooks(event.input!);
          result = result
              .where((element) => cat.map((e) => e.id).contains(element.id))
              .toList();
        }

        // filters
        if ((state as CatalogSuccess).filters.containsKey('class_id') ||
            (state as CatalogSuccess).filters['class_id'] != null) {
          if (((state as CatalogSuccess).filters['class_id'] as List<int>)
              .isNotEmpty) {
            result = result
                .where((element) =>
                    ((state as CatalogSuccess).filters['class_id'] as List<int>)
                        .contains(element.classId))
                .toList();
          }
        }
        if ((state as CatalogSuccess).filters.containsKey('subject_id') ||
            (state as CatalogSuccess).filters['subject_id'] != null) {
          if (((state as CatalogSuccess).filters['subject_id'] as List<int>)
              .isNotEmpty) {
            result = result
                .where((element) => ((state as CatalogSuccess)
                        .filters['subject_id'] as List<int>)
                    .contains(element.categorySubjectId))
                .toList();
          }
        }

        emit((state as CatalogSuccess).copyWith(
            loadedBookList: cat,
            filteredBookList: result,
            currentInput: event.input ?? ''));
      }
    } catch (_) {
      throw ("Search error");
    }
  }

  void _onLoadRecentToCatalog(
    LoadRecentToCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    List<BookModel> allBooksList = await NetworkRepository().getBooks();
    List<SubjectModel> subjects = await NetworkRepository().getSubjects();
    List<int> viewedBooks = await NetworkRepository().getViewed();
    List<BookModel> result = allBooksList
        .where((element) => viewedBooks.contains(element.id))
        .toList();
    emit(CatalogSuccess(
        loadedBookList: result,
        filteredBookList: result,
        subjectList: subjects));
  }

  void _onLoadShareToCatalog(
    LoadShareToCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      List<BookModel> allBooks = await NetworkRepository().getBooks();
      List<SubjectModel> subjects = await NetworkRepository().getSubjects();
      List<BookModel> result =
          allBooks.where((element) => element.sailPrice != null).toList();
      emit(CatalogSuccess(
          loadedBookList: result,
          filteredBookList: result,
          subjectList: subjects));
    } catch (err) {
      emit(CatalogFailure());
    }
  }

  void _onLoadPopularToCatalog(
    LoadPopularToCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      List<BookModel> allBooks = await NetworkRepository().getBooks();
      List<SubjectModel> subjects = await NetworkRepository().getSubjects();
      List<BookModel> result = allBooks
          .where((element) => element.popularityCoefficient > 3)
          .toList();
      emit(CatalogSuccess(
          loadedBookList: result,
          filteredBookList: result,
          subjectList: subjects));
    } catch (err) {
      emit(CatalogFailure());
    }
  }

  void _onLoadAllToCatalog(
    LoadAllToCatalog event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      List<BookModel> allBooks = await NetworkRepository().getBooks();
      List<SubjectModel> subjects = await NetworkRepository().getSubjects();
      emit(CatalogSuccess(
          loadedBookList: allBooks,
          filteredBookList: allBooks,
          subjectList: subjects));
    } catch (err) {
      emit(CatalogFailure());
    }
  }
}
