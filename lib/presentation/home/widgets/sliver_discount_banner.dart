import 'package:flutter/material.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/theme.dart';

class SliverDiscountBanner extends StatelessWidget {
  const SliverDiscountBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            color: theme.primaryColor,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    left: -25,
                    child: Image.asset(Assets.getImagePath("blob.png"), height: 100),
                  ),
                  Positioned(
                    right: -50,
                    bottom: -40,
                    child: Image.asset(Assets.getImagePath("blob-alt.png"), height: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text.rich(
                      TextSpan(
                        text: "A Summer Surprise\n\n",
                        style: TextStyle(color: kWhite),
                        children: const [
                          TextSpan(
                            text: "Cashback 20%",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

