part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadFromId({required int key}) = _LoadProductFromKey;

  const factory ProductEvent.addToInventory({required int key}) = _AddToInventory;

  const factory ProductEvent.deleteFromInventory({required int key}) = _DeleteFromInventory;

  const factory ProductEvent.addToCart({
    required int key,
    required int quantity,
  }) = _AddToCart;

  const factory ProductEvent.deleteFromCart({required int key}) = _DeleteFromCart;
}