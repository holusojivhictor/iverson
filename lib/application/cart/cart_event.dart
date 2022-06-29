part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.init() = _Init;

  const factory CartEvent.addProduct({
    required int key,
    required int quantity,
  }) = _AddProduct;

  const factory CartEvent.deleteProduct({
    required int key,
  }) = _DeleteProduct;

  const factory CartEvent.updateProduct({
    required int key,
    required int quantity,
  }) = _UpdateProduct;

  const factory CartEvent.clearAllProducts() = _ClearAllProducts;

  const factory CartEvent.refresh({required ItemType type}) = _Refresh;
}