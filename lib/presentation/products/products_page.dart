import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/presentation/shared/search_field.dart';
import 'package:iverson/presentation/shared/sliver_nothing_found.dart';
import 'package:iverson/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:iverson/presentation/shared/utils/size_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  final bool isInSelectionMode;

  static Future<int?> forSelection(BuildContext context, {List<int> excludeKeys = const []}) async {
    final bloc = context.read<ProductsBloc>();
    bloc.add(ProductsEvent.init(excludeKeys: excludeKeys));

    final route = MaterialPageRoute<int>(builder: (ctx) => const ProductsPage(isInSelectionMode: true));
    final key = await Navigator.of(context).push(route);
    await route.completed;

    bloc.add(const ProductsEvent.init());

    return key;
  }

  const ProductsPage({Key? key, this.isInSelectionMode = false}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with AutomaticKeepAliveClientMixin<ProductsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: widget.isInSelectionMode ? AppBar(title: const Text('Select an item')) : null,
          slivers: [
            SliverToBoxAdapter(
              child: SearchField(
                value: state.search,
                factor: 0.88,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                searchChanged: (v) => context.read<ProductsBloc>().add(ProductsEvent.searchChanged(search: v)),
              ),
            ),
            if (state.products.isNotEmpty) _buildGrid(context, state.products) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<ProductCardModel> products) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      sliver: SliverWaterfallFlow(
        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, isOnMainPage: !widget.isInSelectionMode),
          crossAxisSpacing: isPortrait ? 10 : 5,
          mainAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate((context, index) => ProductCard.item(product: products[index], isInSelectionMode: widget.isInSelectionMode),
          childCount: products.length,
        ),
      ),
    );
  }
}
