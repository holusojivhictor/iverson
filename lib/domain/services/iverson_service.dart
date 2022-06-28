import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';

abstract class IversonService {
  Future<void> init(AppLanguageType languageType);
  Future<void> initProducts();
  Future<void> initPopularProducts();

  List<ProductCardModel> getProductsForCard();
  ProductCardModel getProductForCard(int id);
  ProductFileModel getProduct(int id);

  List<ProductCardModel> getPopularProductsForCard();
  ProductCardModel getPopularProductForCard(int id);

  Future<bool> isUserSignedIn();
}