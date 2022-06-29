part of 'inventory_bloc.dart';

@freezed
class InventoryEvent with _$InventoryEvent {
  const factory InventoryEvent.init() = _Init;

  const factory InventoryEvent.addProduct({
    required int key,
  }) = _AddProduct;

  const factory InventoryEvent.deleteProduct({
    required int key,
  }) = _DeleteProduct;

  const factory InventoryEvent.clearAllProducts() = _ClearAllProducts;

  const factory InventoryEvent.refresh({required ItemType type}) = _Refresh;
}