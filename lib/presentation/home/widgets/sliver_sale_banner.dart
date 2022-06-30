import 'package:flutter/material.dart';
import 'package:iverson/application/bloc.dart';
import 'package:iverson/domain/assets.dart';
import 'package:iverson/presentation/shared/gradient_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iverson/theme.dart';

class SliverSaleBanner extends StatelessWidget {
  const SliverSaleBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          child: GradientCard(
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            gradient: const LinearGradient(
              stops: [0.2, 1],
              colors: [
                Color(0xFF513B56),
                Color(0xFFF49097),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text.rich(
                      TextSpan(
                        text: "New Release\n",
                        style: TextStyle(color: kWhite),
                        children: const [
                          TextSpan(
                            text: "Jordan 4\n",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: "Retro",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      Assets.getImagePath("air-jordan-4.png"),
                      height: 140,
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Column(
                      children: const [
                        BackgroundText(),
                        BackgroundText(),
                        BackgroundText(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 7,
                    child: InkWell(
                      onTap: () => _goToTab(context, 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: const Text("Shop Now"),
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

  void _goToTab(BuildContext context, int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}

class BackgroundText extends StatelessWidget {
  const BackgroundText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'JORDAN',
      style: TextStyle(
        fontSize: 40,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.white.withOpacity(0.08),
      ),
    );
  }
}

