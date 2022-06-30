import 'package:flutter/material.dart';
import 'package:iverson/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'size_utils.dart';

class DetailBottomLayout extends StatelessWidget {
  final List<Widget> children;
  final bool isASmallImage;
  final Color? color;

  const DetailBottomLayout({
    Key? key,
    required this.children,
    this.isASmallImage = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxTopHeight = getTopMarginForPortrait(context, isASmallImage);
    final device = getDeviceType(size);
    final width = size.width * (device == DeviceScreenType.mobile ? 1 : 0.9);
    return SizedBox(
      width: width,
      child: Card(
        color: color,
        margin: EdgeInsets.only(top: maxTopHeight),
        shape: Styles.cardItemDetailShape,
        elevation: 0,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
