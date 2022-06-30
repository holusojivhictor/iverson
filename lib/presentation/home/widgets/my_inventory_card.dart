import 'package:flutter/material.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/presentation/inventory/inventory_page.dart';

import 'card_description.dart';
import 'card_item.dart';

class MyInventoryCard extends StatelessWidget {
  final bool iconToTheLeft;
  const MyInventoryCard({
    Key? key,
    required this.iconToTheLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: 'My Inventory',
      iconToTheLeft: iconToTheLeft,
      icon: Image.asset(Assets.getImagePath("controller.png")),
      onClick: _goToInventoryPage,
      children: const [
        CardDescription(text: 'My Inventory', isBold: true),
        SizedBox(height: 10),
        CardDescription(text: 'See your saved items here'),
      ],
    );
  }

  Future<void> _goToInventoryPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => const InventoryPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
