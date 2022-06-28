import 'package:flutter/material.dart';
import 'package:iverson/presentation/shared/icon_button_with_counter.dart';
import 'package:iverson/presentation/shared/search_field.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SearchField(),
            IconBtnWithCounter(
              icon: Icons.shopping_cart_outlined,
              onTap: () {},
            ),
            IconBtnWithCounter(
              icon: Icons.notifications_outlined,
              numOfItems: 5,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
