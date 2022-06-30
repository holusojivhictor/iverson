import 'package:flutter/material.dart';
import 'package:iverson/presentation/home/widgets/sliver_sale_banner.dart';
import 'package:iverson/presentation/shared/clickable_title.dart';
import 'package:iverson/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets/my_cart_card.dart';
import 'widgets/my_inventory_card.dart';
import 'widgets/sliver_discount_banner.dart';
import 'widgets/sliver_popular_products.dart';
import 'widgets/sliver_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveBuilder(
      builder: (ctx, size) => Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverSearchBar(),
            const SliverDiscountBanner(),
            const SliverClickableTitle(title: "Popular products"),
            const SliverPopularProducts(),
            const SliverSaleBanner(),
            const SliverClickableTitle(title: "Inventory Section"),
            SliverToBoxAdapter(
              child: Container(
                padding: Styles.edgeInsetHorizontal10,
                height: Styles.homeCardHeight,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) => _buildToolsSectionMenu(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsSectionMenu(int index) {
    switch (index) {
      case 0:
        return const MyInventoryCard(iconToTheLeft: true);
      case 1:
        return const MyCartCard(iconToTheLeft: false);
      default:
        throw Exception('Invalid tool section');
    }
  }
}
