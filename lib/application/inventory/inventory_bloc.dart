import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

part 'inventory_bloc.freezed.dart';
part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final DataService _dataService;
  late final List<StreamSubscription> _streamSubscriptions;

  InventoryBloc(this._dataService) : super(const InventoryState.loaded(products: [])) {
   _streamSubscriptions = [
     _dataService.productAddedToInventory.stream.listen((type) => add(InventoryEvent.refresh(type: type))),
     _dataService.productDeletedFromInventory.stream.listen((type) => add(InventoryEvent.refresh(type: type))),
   ];
   on<_Init>(_mapInitToState);
   on<_AddProduct>(_mapAddProductToState);
   on<_DeleteProduct>(_mapDeleteProductToState);
   on<_ClearAllProducts>(_mapClearAllProductsToState);
   on<_Refresh>(_mapRefreshToState);
  }

  @override
  Future<void> close() async {
    await Future.wait(_streamSubscriptions.map((e) => e.cancel()));
    await super.close();
  }

  void _mapInitToState(_Init event, Emitter<InventoryState> emit) {
    final products = _dataService.getAllProductsInInventory();
    emit(InventoryState.loaded(products: products));
  }

  Future<void> _mapAddProductToState(_AddProduct event, Emitter<InventoryState> emit) async {
    await _dataService.addProductToInventory(event.key, raiseEvent: false);
    emit(_refreshItems(ItemType.product));
  }

  Future<void> _mapDeleteProductToState(_DeleteProduct event, Emitter<InventoryState> emit) async {
    await _dataService.deleteProductFromInventory(event.key, raiseEvent: false);
    emit(_refreshItems(ItemType.product));
  }

  Future<void> _mapClearAllProductsToState(_ClearAllProducts event, Emitter<InventoryState> emit) async {
    await _dataService.deleteProductsFromInventory(raiseEvent: false);
    emit(state.copyWith.call(products: []));
  }

  void _mapRefreshToState(_Refresh event, Emitter<InventoryState> emit) {
    emit(_refreshItems(event.type));
  }

  InventoryState _refreshItems(ItemType type) {
    switch (type) {
      case ItemType.product:
        return state.copyWith.call(products: _dataService.getAllProductsInInventory());
    }
  }

  List<int> getItemsKeysToExclude() {
    return state.maybeMap(
      loaded: (state) => state.products.map((e) => e.id).toList(),
      orElse: () => [],
    );
  }
}