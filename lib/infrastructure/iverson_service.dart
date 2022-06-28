import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:iverson/domain/assets.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/domain/services/services.dart';

class IverServiceImpl implements IversonService {
  late ProductsFile _productsFile;

  IverServiceImpl();

  @override
  Future<void> init(AppLanguageType languageType) async {
    await Future.wait([
      initProducts(),
    ]);
  }

  @override
  Future<void> initProducts() async {
    final jsonStr = await rootBundle.loadString(Assets.productsDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _productsFile = ProductsFile.fromJson(json);
  }

  @override
  ProductFileModel getProduct(int id) {
    return _productsFile.products.firstWhere((element) => element.id == id);
  }

  @override
  ProductCardModel getProductForCard(int id) {
    final product = _productsFile.products.firstWhere((element) => element.id == id);
    return _toProductForCard(product);
  }

  @override
  List<ProductCardModel> getProductsForCard() {
    return _productsFile.products.map((e) => _toProductForCard(e)).toList();
  }


  ProductCardModel _toProductForCard(ProductFileModel product) {
    return ProductCardModel(
      id: product.id,
      title: product.title,
      price: product.price,
      category: product.category,
      image: product.image,
      rating: product.rating.rate,
      ratingCount: product.rating.count,
    );
  }

  @override
  Future<bool> isUserSignedIn() async {
    return false;
  }
}