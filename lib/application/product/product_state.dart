part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.loading() = _LoadingState;

  const factory ProductState.loaded({
    required int id,
    required String title,
    required double price,
    required String description,
    required ProductCategoryType category,
    required String image,
    required double rating,
    required int ratingCount,
    required bool isInInventory,
    required bool isInCart,
    required List<ProductCardModel> relatedProducts,
    required bool isASmallImage,
  }) = _LoadedState;
}