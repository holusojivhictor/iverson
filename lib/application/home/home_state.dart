part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required List<ProductCardModel> products,
    String? search,
    ProductCategoryType? productType,
    ProductCategoryType? tempProductType,
  }) = _LoadedState;
}
