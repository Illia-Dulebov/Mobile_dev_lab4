part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class LoadAllToCatalog extends CatalogEvent {}

class LoadPopularToCatalog extends CatalogEvent {}

class LoadShareToCatalog extends CatalogEvent {}

class LoadRecentToCatalog extends CatalogEvent {}


class ConfirmFilters extends CatalogEvent{}


class ToggleKeyTempFilter extends CatalogEvent{
  final int optionId;
  final String key;

  const ToggleKeyTempFilter({required this.optionId, required this.key});
}

class SearchFromCatalog extends CatalogEvent {
  final String? input;

  const SearchFromCatalog({this.input});
}
