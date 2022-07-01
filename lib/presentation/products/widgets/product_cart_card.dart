import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/domain/enums/enums.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/presentation/product/product_page.dart';
import 'package:iverson/presentation/shared/container_tag.dart';
import 'package:iverson/presentation/shared/custom_card.dart';
import 'package:iverson/theme.dart';

class ProductCartCard extends StatefulWidget {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final ProductCategoryType category;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const ProductCartCard({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  }) : super(key: key);

  ProductCartCard.item({
    Key? key,
    required ProductCardModel product,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = false,
  })  : id = product.id,
        title = product.title,
        price = product.price,
        image = product.image,
        rating = product.rating,
        category = product.category,
        super(key: key);

  @override
  State<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToProductPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetHorizontal10Vertical5,
        shape: Styles.mainCardShape,
        elevation: widget.withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: Styles.edgeInsetAll5,
          child: Row(
            children: [
              Expanded(
                flex: 28,
                child: Container(
                  height: widget.imgHeight,
                  width: widget.imgWidth,
                  padding: Styles.edgeInsetAll10,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: Styles.mainCardBorderRadius,
                  ),
                  child: Image(
                    fit: BoxFit.contain,
                    image: CachedNetworkImageProvider(widget.image),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: widget.title,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ContainerTag(tagText: Assets.translateProductCategoryType(widget.category)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${widget.price}",
                          style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            CounterButton(
                              icon: Icons.remove,
                              color: Colors.transparent,
                              hasBorder: true,
                              onPressed: () => _decrementCounter(),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '$_counter',
                              style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            CounterButton(
                              icon: Icons.add,
                              color: theme.primaryColor,
                              iconColor: Colors.white,
                              onPressed: () => _incrementCounter(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToProductPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (c) => ProductPage(itemKey: widget.id));
    await Navigator.push(context, route);
    await route.completed;
  }
}

class CounterButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final bool hasBorder;
  final void Function()? onPressed;

  const CounterButton({
    Key? key,
    required this.icon,
    this.iconColor = Colors.black54,
    required this.color,
    this.hasBorder = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 35,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: hasBorder ?  Border.all(color: Colors.grey) : null,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

