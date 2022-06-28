import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';

abstract class IversonService {
  Future<void> init(AppLanguageType languageType);
  Future<void> initProducts();

  List<ProductCardModel> getProductsForCard();
  ProductCardModel getProductForCard(int id);
  ProductFileModel getProduct(int id);

  Future<bool> isUserSignedIn();
}