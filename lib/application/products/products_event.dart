part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.init({
    @Default(<int>[]) List<int> excludeKeys,
  }) = _Init;

  const factory ProductsEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory ProductsEvent.productCategoryTypeChanged(ProductCategoryType productCategoryType) = _ProductCategoryTypeChanged;

  const factory ProductsEvent.productFilterTypeChanged(ProductFilterType filterType) = _ProductFilterTypeChanged;

  const factory ProductsEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory ProductsEvent.sortDirectionChanged(SortDirectionType sortDirectionType) = _SortDirectionTypeChanged;

  const factory ProductsEvent.cancelChanges() = _CancelChanges;

  const factory ProductsEvent.resetFilters() = _ResetFilters;
}