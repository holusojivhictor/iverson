import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 2)
class CartItem extends HiveObject {
  @HiveField(0)
  final int itemKey;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  final int type;

  CartItem(this.itemKey, this.quantity, this.type);
}