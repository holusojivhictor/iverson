import 'package:flutter/material.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/presentation/cart/cart_page.dart';

import 'card_description.dart';
import 'card_item.dart';

class MyCartCard extends StatelessWidget {
  final bool iconToTheLeft;
  const MyCartCard({
    Key? key,
    required this.iconToTheLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'My Cart',
      iconToTheLeft: iconToTheLeft,
      icon: Image.asset(Assets.getImagePath("cart.png")),
      onClick: _goToCartPage,
      children: const [
        CardDescription(text: 'My Cart', isBold: true),
        SizedBox(height: 10),
        CardDescription(text: 'View your cart here'),
      ],
    );
  }

  Future<void> _goToCartPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const CartPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
