import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DataService _dataService;
  late final List<StreamSubscription> _streamSubscriptions;

  CartBloc(this._dataService) : super(const CartState.loaded(products: [])) {
    _streamSubscriptions = [
      _dataService.productAddedToCart.stream.listen((type) => add(CartEvent.refresh(type: type))),
      _dataService.productUpdatedInCart.stream.listen((type) => add(CartEvent.refresh(type: type))),
      _dataService.productDeletedFromCart.stream.listen((type) => add(CartEvent.refresh(type: type))),
    ];
    on<_Init>(_mapInitToState);
    on<_AddProduct>(_mapAddProductToState);
    on<_DeleteProduct>(_mapDeleteProductToState);
    on<_UpdateProduct>(_mapUpdateProductToState);
    on<_ClearAllProducts>(_mapClearAllProductsToState);
    on<_Refresh>(_mapRefreshToState);
  }

  @override
  Future<void> close() async {
    await Future.wait(_streamSubscriptions.map((e) => e.cancel()));
    await super.close();
  }

  void _mapInitToState(_Init event, Emitter<CartState> emit) {
    final products = _dataService.getAllProductsInCart();
    emit(CartState.loaded(products: products));
  }

  Future<void> _mapAddProductToState(_AddProduct event, Emitter<CartState> emit) async {
    await _dataService.addProductToCart(event.key, event.quantity, raiseEvent: false);
    emit(_refreshItems(ItemType.product));
  }

  Future<void> _mapDeleteProductToState(_DeleteProduct event, Emitter<CartState> emit) async {
    await _dataService.deleteProductFromCart(event.key, raiseEvent: false);
    emit(_refreshItems(ItemType.product));
  }

  Future<void> _mapUpdateProductToState(_UpdateProduct event, Emitter<CartState> emit) async {
    await _dataService.updateProductInCart(event.key, ItemType.product,event.quantity, raiseEvent: false);
    emit(_refreshItems(ItemType.product));
  }

  Future<void> _mapClearAllProductsToState(_ClearAllProducts event, Emitter<CartState> emit) async {
    await _dataService.deleteProductsFromCart(ItemType.product, raiseEvent: false);
    emit(state.copyWith.call(products: []));
  }

  void _mapRefreshToState(_Refresh event, Emitter<CartState> emit) {
    emit(_refreshItems(event.type));
  }

  CartState _refreshItems(ItemType type) {
    switch (type) {
      case ItemType.product:
        return state.copyWith.call(products: _dataService.getAllProductsInCart());
    }
  }

  List<int> getItemsKeysToExclude() {
    return state.maybeMap(
      loaded: (state) => state.products.map((e) => e.id).toList(),
      orElse: () => [],
    );
  }
}