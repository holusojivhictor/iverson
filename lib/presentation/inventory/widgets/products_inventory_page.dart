import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/products/products_page.dart';
import 'package:iverson/presentation/products/widgets/product_card.dart';
import 'package:iverson/presentation/shared/app_fab.dart';
import 'package:iverson/presentation/shared/mixins/app_fab_mixin.dart';
import 'package:iverson/presentation/shared/nothing_found_column.dart';
import 'package:iverson/presentation/shared/utils/size_utils.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class ProductsInventoryPage extends StatefulWidget {
  const ProductsInventoryPage({Key? key}) : super(key: key);

  @override
  State<ProductsInventoryPage> createState() => _ProductsInventoryPageState();
}

class _ProductsInventoryPageState extends State<ProductsInventoryPage> with SingleTickerProviderStateMixin, AppFabMixin {
  @override
  bool get isInitiallyVisible => true;

  @override
  bool get hideOnTop => false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Scaffold(
        floatingActionButton: AppFab(
          onPressed: () => _openProductsPage(context),
          icon: const Icon(Icons.add),
          hideFabAnimController: hideFabAnimController,
          scrollController: scrollController,
          mini: false,
        ),
        body: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (ctx, state) => state.products.isNotEmpty ? WaterfallFlow.builder(
            controller: scrollController,
            itemBuilder: (context, index) => ProductCard.related(product: state.products[index]),
            itemCount: state.products.length,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context),
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
          ) : const NothingFoundColumn(),
        ),
      ),
    );
  }

  Future<void> _openProductsPage(BuildContext context) async {
    final inventoryBloc = context.read<InventoryBloc>();
    final productsBloc = context.read<ProductsBloc>();
    productsBloc.add(ProductsEvent.init(excludeKeys: inventoryBloc.getItemsKeysToExclude()));
    final route = MaterialPageRoute<int>(builder: (_) => const ProductsPage(isInSelectionMode: true));
    final key = await Navigator.push(context, route);

    productsBloc.add(const ProductsEvent.init());
    if (key == null) {
      return;
    }
    
    inventoryBloc.add(InventoryEvent.addProduct(key: key));
  }
}
