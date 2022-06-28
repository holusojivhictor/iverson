import 'package:flutter/material.dart';
import 'package:iverson/presentation/home/widgets/sliver_sale_banner.dart';
import 'package:iverson/presentation/shared/clickable_title.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      builder: (ctx, size) => const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverSearchBar(),
            SliverDiscountBanner(),
            SliverClickableTitle(title: "Popular products"),
            SliverPopularProducts(),
            SliverSaleBanner(),
            SliverClickableTitle(title: "New products"),
          ],
        ),
      ),
    );
  }
}
