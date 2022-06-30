import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iverson/presentation/shared/details/size_utils.dart';

class DetailTopLayout extends StatelessWidget {
  final String image;
  final Color? color;
  final Widget? appBar;
  final BorderRadius? borderRadius;

  final bool isASmallImage;

  const DetailTopLayout({
    Key? key,
    required this.image,
    this.color,
    this.appBar,
    this.borderRadius,
    this.isASmallImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getTopHeightForPortrait(context, isASmallImage),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image(
              width: 300,
              height: 300,
              image: CachedNetworkImageProvider(image),
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            bottom: 60,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: appBar ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
