// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';
import 'package:synchronized/synchronized.dart';

class DataServiceImpl implements DataService {
  final IversonService _iversonService;

  late Box<InventoryItem> _inventoryBox;
  late Box<CartItem> _cartBox;

  final _initLock = Lock();
  final _deleteAllLock = Lock();

  @override
  StreamController<ItemType> get productAddedToCart => StreamController.broadcast();

  @override
  StreamController<ItemType> get productAddedToInventory => StreamController.broadcast();

  @override
  StreamController<ItemType> get productDeletedFromCart => StreamController.broadcast();

  @override
  StreamController<ItemType> get productDeletedFromInventory => StreamController.broadcast();

  @override
  StreamController<ItemType> get productUpdatedInCart => StreamController.broadcast();

  DataServiceImpl(this._iversonService);

  @override
  Future<void> init({String dir = 'iverson_data'}) async {
    await _initLock.synchronized(() async {
      await Hive.initFlutter(dir);
      _registerAdapters();
      _inventoryBox = await Hive.openBox<InventoryItem>('inventory');
      _cartBox = await Hive.openBox<CartItem>('cart');
    });
  }

  @override
  Future<void> deleteThemAll() async {
    await _deleteAllLock.synchronized(() async {
      await _inventoryBox.clear();
      await _cartBox.clear();
    });
  }

  @override
  Future<void> closeThemAll() async {
    await _deleteAllLock.synchronized(() async {
      await Hive.close();
    });

    await Future.wait([
      productAddedToInventory.close(),
      productDeletedFromInventory.close(),
      productAddedToCart.close(),
      productUpdatedInCart.close(),
      productDeletedFromCart.close(),
    ]);
  }

  @override
  Future<void> addProductToCart(int key, int quantity, {bool raiseEvent = true}) async {
    if (isProductInCart(key, ItemType.product)) {
      return Future.value();
    }
    await _cartBox.add(CartItem(key, quantity, ItemType.product.index));
    if (raiseEvent) {
      productAddedToCart.add(ItemType.product);
    }
  }

  @override
  Future<void> addProductToInventory(int key, {bool raiseEvent = true}) async {
    if (isProductInInventory(key, ItemType.product)) {
      return Future.value();
    }
    await _inventoryBox.add(InventoryItem(key, ItemType.product.index));
    if (raiseEvent) {
      productAddedToInventory.add(ItemType.product);
    }
  }

  @override
  Future<void> deleteProductFromCart(int key, {bool raiseEvent = true}) async {
    final item = _getItemFromCart(key);

    if (item != null) {
      await _cartBox.delete(item.key);
    }

    if (raiseEvent) {
      productDeletedFromCart.add(ItemType.product);
    }
  }

  @override
  Future<void> deleteProductFromInventory(int key, {bool raiseEvent = true}) async {
    final item = _getItemFromInventory(key);

    if (item != null) {
      await _inventoryBox.delete(item.key);
    }

    if (raiseEvent) {
      productDeletedFromInventory.add(ItemType.product);
    }
  }

  @override
  Future<void> deleteProductsFromCart(ItemType type, {bool raiseEvent = true}) async {
    await deleteAllItemsInCart();

    if (raiseEvent) {
      productDeletedFromCart.add(ItemType.product);
    }
  }

  Future<void> deleteAllItemsInCart() async {
    final toDeleteKeys = _cartBox.values.where((el) => el.type == ItemType.product.index).map((e) => e.key).toList();
    if (toDeleteKeys.isNotEmpty) {
      await _cartBox.deleteAll(toDeleteKeys);
    }
  }

  @override
  Future<void> deleteProductsFromInventory({bool raiseEvent = true}) async {
    await deleteAllItemsInInventory();

    if (raiseEvent) {
      productDeletedFromInventory.add(ItemType.product);
    }
  }

  Future<void> deleteAllItemsInInventory() async {
    final toDeleteKeys = _inventoryBox.values.where((el) => el.type == ItemType.product.index).map((e) => e.key).toList();
    if (toDeleteKeys.isNotEmpty) {
      await _inventoryBox.deleteAll(toDeleteKeys);
    }
  }

  @override
  Future<void> updateProductInCart(int key, ItemType type, int quantity, {bool raiseEvent = true}) async {
    var item = _getItemFromCart(key);
    if (item == null) {
      item = CartItem(key, quantity, type.index);
      await _cartBox.add(item);
    } else {
      if (quantity == item.quantity) {
        return;
      }

      item.quantity = quantity;
      await item.save();
    }
    if (raiseEvent) {
      productUpdatedInCart.add(ItemType.product);
    }
  }

  @override
  List<ProductCardModel> getAllProductsInCart() {
    final products = _cartBox.values
        .where((el) => el.type == ItemType.product.index)
        .map((e) => _iversonService.getProductForCard(e.itemKey)).toList();

    return products..sort((x, y) => x.title.compareTo(y.title));
  }

  @override
  List<ProductCardModel> getAllProductsInInventory() {
    final products = _inventoryBox.values
        .where((el) => el.type == ItemType.product.index)
        .map((e) => _iversonService.getProductForCard(e.itemKey)).toList();

    return products..sort((x, y) => x.title.compareTo(y.title));
  }

  InventoryItem? _getItemFromInventory(int key) {
    return _inventoryBox.values.firstWhereOrNull((el) => el.itemKey == key);
  }

  CartItem? _getItemFromCart(int key) {
    return _cartBox.values.firstWhereOrNull((el) => el.itemKey == key);
  }

  @override
  bool isProductInCart(int key, ItemType type) {
    return _cartBox.values.any((el) => el.itemKey == key && el.type == type.index && el.quantity > 0);
  }

  @override
  bool isProductInInventory(int key, ItemType type) {
    return _inventoryBox.values.any((el) => el.itemKey == key && el.type == type.index);
  }

  void _registerAdapters() {
    Hive.registerAdapter(InventoryItemAdapter());
    Hive.registerAdapter(CartItemAdapter());
  }
}