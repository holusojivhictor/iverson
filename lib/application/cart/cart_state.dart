part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.loaded({
    required List<ProductCardModel> products,
  }) = _LoadedState;
}