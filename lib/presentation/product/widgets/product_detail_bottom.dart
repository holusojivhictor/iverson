import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/presentation/products/widgets/product_card.dart';
import 'package:iverson/presentation/shared/details/detail_bottom_layout.dart';
import 'package:iverson/presentation/shared/expandable_text.dart';
import 'package:iverson/presentation/shared/loading.dart';
import 'package:iverson/presentation/shared/utils/toast_utils.dart';
import 'package:iverson/theme.dart';

class ProductDetailBottom extends StatelessWidget {
  const ProductDetailBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) => DetailBottomLayout(
          isASmallImage: state.isASmallImage,
          color: theme.scaffoldBackgroundColor,
          children: [
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Text(
                state.title,
                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: theme.indicatorColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Text(
                    '${state.rating}',
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${state.ratingCount} Reviews)',
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor),
                  ),
                ],
              ),
            ),
            DetailTitle(theme: theme, text: 'Description'),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: ExpandableText(
                state.description,
                trimLines: 4,
                trimMode: TrimMode.line,
                trimCollapsedText: '...Read More',
                trimExpandedText: ' Less',
                style: theme.textTheme.bodyMedium!.copyWith(color: theme.indicatorColor),
              ),
            ),
            Padding(
              padding: Styles.edgeInsetAll10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${state.price}',
                    style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: theme.indicatorColor),
                  ),
                  CartButton(
                    theme: theme,
                    isInCart: state.isInCart,
                    onPressed: () => _addToCart(state.id, state.isInCart, context),
                  ),
                ],
              ),
            ),
            DetailTitle(theme: theme, text: 'Related products'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: Styles.materialCardHeight,
                child: ListView.separated(
                  separatorBuilder: (ctx, index) => const SizedBox(width: 10),
                  itemCount: state.relatedProducts.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    final e = state.relatedProducts[index];
                    return ProductCard.related(product: e, width: 170);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(int key, bool isInCart, BuildContext context) {
    final fToast = ToastUtils.of(context);
    final event = !isInCart ? ProductEvent.addToCart(key: key, quantity: 1) : ProductEvent.deleteFromCart(key: key);
    context.read<ProductBloc>().add(event);
    !isInCart ? ToastUtils.showSucceedToast(fToast, 'Added to cart') : ToastUtils.showInfoToast(fToast, 'Removed from cart');
  }
}

class CartButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isInCart;
  final ThemeData theme;

  const CartButton({
    Key? key,
    this.onPressed,
    this.isInCart = false,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.45,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isInCart ? Colors.grey : theme.primaryColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        onPressed: onPressed,
        child: Text(isInCart ? 'Added To Cart' : 'Add to Cart'),
      ),
    );
  }
}

class DetailTitle extends StatelessWidget {
  const DetailTitle({
    Key? key,
    required this.theme,
    required this.text,
  }) : super(key: key);

  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        text,
        style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: theme.indicatorColor),
      ),
    );
  }
}
