import 'dart:async';

import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';

abstract class DataService {
  StreamController<ItemType> get productAddedToInventory;

  StreamController<ItemType> get productDeletedFromInventory;

  StreamController<ItemType> get productAddedToCart;

  StreamController<ItemType> get productUpdatedInCart;

  StreamController<ItemType> get productDeletedFromCart;

  Future<void> init({String dir = 'iverson_data'});

  Future<void> deleteThemAll();

  Future<void> closeThemAll();

  List<ProductCardModel> getAllProductsInInventory();

  List<ProductCardModel> getAllProductsInCart();

  Future<void> addProductToInventory(int key, {bool raiseEvent = true});

  Future<void> deleteProductFromInventory(int key, {bool raiseEvent = true});

  Future<void> deleteProductsFromInventory({bool raiseEvent = true});

  bool isProductInInventory(int key, ItemType type);

  Future<void> addProductToCart(int key, int quantity, {bool raiseEvent = true});

  Future<void> updateProductInCart(int key, ItemType type, int quantity, {bool raiseEvent = true});

  Future<void> deleteProductFromCart(int key, {bool raiseEvent = true});

  Future<void> deleteProductsFromCart(ItemType type, {bool raiseEvent = true});

  bool isProductInCart(int key, ItemType type);
}