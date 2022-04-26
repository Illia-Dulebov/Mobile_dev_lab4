part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
  
  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}


class CatalogLoading extends CatalogState {}

class CatalogSuccess extends CatalogState {
  final String currentInput;
  final List<BookModel> loadedBookList;
  final List<BookModel> filteredBookList;
  final List<SubjectModel> subjectList;
  final Map<String, dynamic> filters;
  final Map<String, dynamic> unconfirmedFilters;

  const CatalogSuccess({
    this.currentInput = '',
    required this.loadedBookList,
    required this.subjectList,
    this.filteredBookList = const [],
    this.filters = const <String, dynamic>{}, 
    this.unconfirmedFilters = const <String, dynamic>{}, 
  });


  CatalogSuccess copyWith({
    String? currentInput,
    List<BookModel>? loadedBookList,
    List<BookModel>? filteredBookList,
    Map<String, dynamic>? filters,
    Map<String, dynamic>? unconfirmedFilters,
    List<SubjectModel>? subjectList
  }){
    return CatalogSuccess(
      loadedBookList: loadedBookList ?? this.loadedBookList,
      currentInput: currentInput ?? this.currentInput,
      subjectList: subjectList ?? this.subjectList,
      filters: filters ?? this.filters,
      unconfirmedFilters: unconfirmedFilters ?? this.unconfirmedFilters,
      filteredBookList: filteredBookList ?? this.filteredBookList,
    );
  } 

  @override
  List<Object> get props => [loadedBookList, filteredBookList, filters, unconfirmedFilters, subjectList, currentInput];

}

class CatalogFailure extends CatalogState {}