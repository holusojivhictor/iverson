import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iverson/domain/models/models.dart';
import 'package:iverson/presentation/product/product_page.dart';
import 'package:iverson/presentation/shared/custom_card.dart';
import 'package:iverson/presentation/shared/images/coming_soon_new_avatar.dart';
import 'package:iverson/presentation/shared/transparent_image.dart';
import 'package:iverson/theme.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String image;
  final double rating;
  final double width;

  final double imgWidth;
  final double imgHeight;
  final bool isInSelectionMode;
  final bool withElevation;
  final bool isPopular;

  const ProductCard({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
    this.width = 180,
    this.imgHeight = 160,
    this.imgWidth = 160,
    this.isInSelectionMode = false,
    this.withElevation = true,
    this.isPopular = false,
  }) : super(key: key);

  ProductCard.item({
    Key? key,
    required ProductCardModel product,
    this.width = 180,
    this.imgHeight = 160,
    this.imgWidth = 160,
    this.isInSelectionMode = false,
    this.withElevation = false,
    this.isPopular = false,
  })  : id = product.id,
        title = product.title,
        price = product.price,
        image = product.image,
        rating = product.rating,
        super(key: key);

  ProductCard.popular({
    Key? key,
    required ProductCardModel product,
    this.width = 180,
    this.imgHeight = 160,
    this.imgWidth = 160,
    this.isInSelectionMode = false,
    this.withElevation = false,
    this.isPopular = true,
  })  : id = product.id,
        title = product.title,
        price = product.price,
        image = product.image,
        rating = product.rating,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToProductPage(context),
      child: CustomCard(
        margin: const EdgeInsets.only(right: 5),
        clipBehavior: Clip.hardEdge,
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Colors.white,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  fit: StackFit.passthrough,
                  children: [
                    FadeInImage(
                      width: imgWidth,
                      height: imgHeight,
                      fadeInDuration: const Duration(milliseconds: 200),
                      placeholder: MemoryImage(kTransparentImage),
                      image: CachedNetworkImageProvider(image),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ComingSoonNewAvatar(
                          isNew: isPopular,
                          isComingSoon: false,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: isPopular ? 35 : null,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Tooltip(
                      message: title,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: isPopular ? 2 : 3,
                        style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$$price",
                      style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {},
                      child: Container(
                        padding: Styles.edgeInsetAll7,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.favorite, color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToProductPage(BuildContext context) async {
    if (isInSelectionMode) {
      Navigator.pop(context, id);
      return;
    }

    final route = MaterialPageRoute(builder: (c) => ProductPage(itemKey: id));
    await Navigator.push(context, route);
    await route.completed;
  }
}
