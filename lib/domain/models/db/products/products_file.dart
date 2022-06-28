import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iverson/domain/models/models.dart';

part 'products_file.freezed.dart';
part 'products_file.g.dart';

@freezed
class ProductsFile with _$ProductsFile {
  List<ProductFileModel> get products => clothing + footwear + jewelery + electronics + gaming;

  factory ProductsFile({
    required List<ProductFileModel> clothing,
    required List<ProductFileModel> footwear,
    required List<ProductFileModel> jewelery,
    required List<ProductFileModel> electronics,
    required List<ProductFileModel> gaming,
  }) = _ProductsFile;

  ProductsFile._();

  factory ProductsFile.fromJson(Map<String, dynamic> json) => _$ProductsFileFromJson(json);
}