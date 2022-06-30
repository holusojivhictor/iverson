import 'package:flutter/material.dart';
import 'package:iverson/presentation/shared/gradient_card.dart';
import 'package:iverson/theme.dart';

class CardItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final List<Widget> children;
  final bool iconToTheLeft;
  final Function(BuildContext) onClick;
  const CardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    required this.children,
    this.iconToTheLeft = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.homeCardItemBorderRadius,
      onTap: () => onClick(context),
      child: GradientCard(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetAll10,
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF49097),
            Color(0xFF513B56),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: Styles.homeCardItemBorderRadius),
        child: Container(
          width: Styles.homeCardWidth,
          height: 100,
          padding: Styles.edgeInsetAll16,
          child: iconToTheLeft ? _LeftLayout(icon: icon, children: children) : _RightLayout(icon: icon, children: children),
        ),
      ),
    );
  }
}

class _LeftLayout extends StatelessWidget {
  final Widget icon;
  final List<Widget> children;
  const _LeftLayout({
    Key? key,
    required this.icon,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: icon,
        ),
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ],
    );
  }
}

class _RightLayout extends StatelessWidget {
  final Widget icon;
  final List<Widget> children;
  const _RightLayout({
    Key? key,
    required this.icon,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
        Flexible(
          flex: 50,
          fit: FlexFit.tight,
          child: icon,
        ),
      ],
    );
  }
}


