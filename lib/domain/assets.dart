import 'package:flutter/material.dart';
import 'package:iverson/domain/enums/enums.dart';

class Assets {
  static String dbPath = 'assets/db';
  static String imageBasePath = 'assets/images';
  static String svgsBasePath = 'assets/svgs';
  static String productsDbPath = '$dbPath/products.json';
  static String popularProductsDbPath = '$dbPath/popular-products.json';

  static String getImagePath(String name) => '$imageBasePath/$name';
  static String getSvgPath(String name) => '$svgsBasePath/$name';

  static String translateAppLanguageType(AppLanguageType language) {
    switch (language) {
      case AppLanguageType.english:
        return 'English';
      default:
        throw Exception('The provided app language type = $language is not valid');
    }
  }

  static String translateAutoThemeModeType(AutoThemeModeType type) {
    switch (type) {
      case AutoThemeModeType.on:
        return 'Follow OS setting';
      case AutoThemeModeType.off:
        return 'Off';
      default:
        throw Exception('Invalid auto theme mode type = $type');
    }
  }

  static AppThemeType translateThemeTypeBool(bool value) {
    switch (value) {
      case false:
        return AppThemeType.light;
      case true:
        return AppThemeType.dark;
      default:
        throw Exception('Unknown error occurred');
    }
  }

  static String translateProductCategoryType(ProductCategoryType type) {
    switch (type) {
      case ProductCategoryType.clothing:
        return "Clothing";
      case ProductCategoryType.footwear:
        return "Footwear";
      case ProductCategoryType.jewelery:
        return "Jewelery";
      case ProductCategoryType.electronics:
        return "Electronics";
      case ProductCategoryType.gaming:
        return "Gaming";
      default:
        throw Exception('Invalid product category type = $type');
    }
  }

  static IconData translateProductCategoryTypeIcon(ProductCategoryType type) {
    switch (type) {
      case ProductCategoryType.clothing:
        return Icons.cases_outlined;
      case ProductCategoryType.footwear:
        return Icons.lan_outlined;
      case ProductCategoryType.jewelery:
        return Icons.medical_services_outlined;
      case ProductCategoryType.electronics:
        return Icons.emergency_outlined;
      case ProductCategoryType.gaming:
        return Icons.emoji_events_outlined;
      default:
        throw Exception('Invalid product category type = $type');
    }
  }
}