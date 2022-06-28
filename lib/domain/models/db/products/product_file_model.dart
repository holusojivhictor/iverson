import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/enums/enums.dart';

part 'product_file_model.freezed.dart';
part 'product_file_model.g.dart';

@freezed
class ProductFileModel with _$ProductFileModel {
  factory ProductFileModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required ProductCategoryType category,
    required String image,
    required RatingModel rating,
  }) = _ProductFileModel;

  ProductFileModel._();

  factory ProductFileModel.fromJson(Map<String, dynamic> json) => _$ProductFileModelFromJson(json);
}

@freezed
class RatingModel with _$RatingModel {
  factory RatingModel({
    required double rate,
    required int count,
  }) = _RatingModel;

  RatingModel._();

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}