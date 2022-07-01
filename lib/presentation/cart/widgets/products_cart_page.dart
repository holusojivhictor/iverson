import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/products/widgets/product_cart_card.dart';
import 'package:iverson/presentation/shared/nothing_found_column.dart';

class ProductsCartPage extends StatelessWidget {
  const ProductsCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Scaffold(
        body: BlocBuilder<CartBloc, CartState>(
          builder: (ctx, state) => state.products.isNotEmpty ? ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) => ProductCartCard.item(product: state.products[index]),
          ) : const NothingFoundColumn(),
        ),
      ),
    );
  }
}

