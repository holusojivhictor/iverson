import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';

part 'product_card_model.freezed.dart';

@freezed
class ProductCardModel with _$ProductCardModel {
  factory ProductCardModel({
    required int id,
    required String title,
    required double price,
    required ProductCategoryType category,
    required String image,
    required double rating,
    required int ratingCount,
  }) = _ProductCardModel;

  ProductCardModel._();
}