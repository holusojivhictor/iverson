import 'package:flutter/material.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/presentation/products/widgets/product_card.dart';
import 'package:iverson/theme.dart';

class PopularProducts extends StatelessWidget {
  final List<ProductCardModel> popularProducts;

  const PopularProducts({Key? key, required this.popularProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: Styles.materialCardHeight,
        child: ListView.separated(
          separatorBuilder: (ctx, index) => const SizedBox(width: 10),
          itemCount: popularProducts.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            final e = popularProducts[index];
            return ProductCard.popular(product: e, width: 170);
          },
        ),
      ),
    );
  }
}
