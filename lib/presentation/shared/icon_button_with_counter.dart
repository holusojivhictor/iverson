import 'package:flutter/material.dart';
import 'package:iverson/theme.dart';

class IconBtnWithCounter extends StatelessWidget {
  final IconData icon;
  final int numOfItems;
  final GestureTapCallback onTap;

  const IconBtnWithCounter({
    Key? key,
    required this.icon,
    this.numOfItems = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20),
          ),
          if (numOfItems != 0)
            Positioned(
              right: 0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: theme.scaffoldBackgroundColor),
                ),
                child: Center(
                  child: Text(
                    "$numOfItems",
                    style: TextStyle(
                      fontSize: 10,
                      height: 1,
                      color: kWhite,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
