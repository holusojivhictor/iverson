part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.loading() = _LoadingState;

  const factory ProductsState.loaded({
    required List<ProductCardModel> products,
    String? search,
    required List<ProductCategoryType> productTypes,
    required List<ProductCategoryType> tempProductTypes,
    required ProductFilterType productFilterType,
    required ProductFilterType tempProductFilterType,
    required SortDirectionType sortDirectionType,
    required SortDirectionType tempSortDirectionType,
    @Default(<int>[]) List<int> excludeKeys,
  }) = _LoadedState;
}