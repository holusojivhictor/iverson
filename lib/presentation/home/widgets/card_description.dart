import 'package:flutter/material.dart';

class CardDescription extends StatelessWidget {
  final String text;
  final bool isBold;
  const CardDescription({Key? key, required this.text, this.isBold = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: text,
      child: Text(
        text,
        style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
