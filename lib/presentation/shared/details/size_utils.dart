import 'package:flutter/material.dart';

double getTopHeightForPortrait(BuildContext context, bool isASmallImage) {
  final factor = isASmallImage ? 0.5 : 0.6;
  final value = MediaQuery.of(context).size.height * factor;
  // Max soldier height
  if (value > 700) {
    return 700;
  }
  return value;
}

double getTopMarginForPortrait(BuildContext context, bool isASmallImage) {
  final maxTopHeight = (getTopHeightForPortrait(context, isASmallImage)) - 50;
  return maxTopHeight;
}