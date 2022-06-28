import 'package:flutter/material.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/theme.dart';

class SliverSaleBanner extends StatelessWidget {
  const SliverSaleBanner({Key? key}) : super(key: key);

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
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            color: theme.primaryColor.withOpacity(0.5),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text.rich(
                      TextSpan(
                        text: "New Release\n\n",
                        style: TextStyle(color: kWhite),
                        children: const [
                          TextSpan(
                            text: "Jordan 6\n",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "Retro",
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

