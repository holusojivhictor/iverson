part of 'inventory_bloc.dart';

@freezed
class InventoryState with _$InventoryState {
  const factory InventoryState.loaded({
    required List<ProductCardModel> products,
  }) = _LoadedState;
}