import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/injection.dart';
import 'package:iverson/presentation/product/widgets/product_detail_bottom.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/presentation/shared/scaffold_with_fab.dart';

import 'widgets/product_detail_top.dart';

class ProductPage extends StatelessWidget {
  final int itemKey;

  const ProductPage({Key? key, required this.itemKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (ctx) => Injection.productBloc(ctx.read<CartBloc>())..add(ProductEvent.loadFromId(key: itemKey)),
      child: const _PortraitLayout(),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithFab(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Stack(
            fit: StackFit.passthrough,
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: const [
              ProductDetailTop(),
              ProductDetailBottom(),
            ],
          ),
        ),
      ),
    );
  }
}

