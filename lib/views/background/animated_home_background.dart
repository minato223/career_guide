// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedHomeBackground extends StatefulWidget {
  const AnimatedHomeBackground({super.key});

  @override
  State<AnimatedHomeBackground> createState() => _AnimatedHomeBackgroundState();
}

class _AnimatedHomeBackgroundState extends State<AnimatedHomeBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late AnimatedHomeBackgroundAnimation animatedHomeBackgroundAnimation;
  final Duration duration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: duration);
    animatedHomeBackgroundAnimation =
        AnimatedHomeBackgroundAnimation(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _startAnimation() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    }
    if (animationController.status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  double _getOpacity(double value) {
    return (value - 1) * (-1);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    final double titleFontSize = size.WIDTH * .22;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
          child: SizedBox(
        height: size.HEIGHT,
        width: size.WIDTH,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  left: -(titleFontSize / 3) -
                      (size.WIDTH *
                          animatedHomeBackgroundAnimation
                              .headerAnimation.value),
                  child: Opacity(
                    opacity: _getOpacity(
                        animatedHomeBackgroundAnimation.headerAnimation.value),
                    child: Text(
                      "CAREER",
                      style: TextStyle(
                          fontSize: titleFontSize, color: Colors.white24),
                    ),
                  ),
                ),
                Positioned(
                  top: titleFontSize * 1.1,
                  right: -titleFontSize / 3 -
                      (size.WIDTH *
                          animatedHomeBackgroundAnimation
                              .headerAnimation.value),
                  child: Opacity(
                    opacity: _getOpacity(
                        animatedHomeBackgroundAnimation.headerAnimation.value),
                    child: Text(
                      "GUIDE",
                      style: TextStyle(
                          fontSize: titleFontSize, color: Colors.white24),
                    ),
                  ),
                ),
                Positioned(
                  top: titleFontSize * .17 +
                      ((-titleFontSize * 2) *
                          animatedHomeBackgroundAnimation
                              .headerAnimation.value),
                  right: titleFontSize * .1,
                  child: Opacity(
                    opacity: _getOpacity(
                        animatedHomeBackgroundAnimation.headerAnimation.value),
                    child: Container(
                      height: titleFontSize * .9,
                      padding:
                          EdgeInsets.symmetric(horizontal: titleFontSize * .08),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Icon(
                        CupertinoIcons.search,
                        size: titleFontSize / 2.6,
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: _getOpacity(
                      animatedHomeBackgroundAnimation.thirdBoxAnimation.value),
                  child: CardPlaceholder(
                      rotateX: .34,
                      rotateZ: .38 +
                          animatedHomeBackgroundAnimation
                              .thirdBoxAnimation.value,
                      translateX: .35 +
                          animatedHomeBackgroundAnimation
                              .thirdBoxAnimation.value,
                      translateY: .55,
                      titleFontSize: titleFontSize),
                ),
                Opacity(
                  opacity: _getOpacity(
                      animatedHomeBackgroundAnimation.secondBoxAnimation.value),
                  child: CardPlaceholder(
                      rotateX: .25,
                      rotateZ: .32 +
                          animatedHomeBackgroundAnimation
                              .secondBoxAnimation.value,
                      translateX: .28 +
                          animatedHomeBackgroundAnimation
                              .secondBoxAnimation.value,
                      translateY: .42,
                      titleFontSize: titleFontSize),
                ),
                Opacity(
                  opacity: _getOpacity(
                      animatedHomeBackgroundAnimation.firstBoxAnimation.value),
                  child: CardPlaceholder(
                      rotateX: .15,
                      rotateZ: .25 +
                          animatedHomeBackgroundAnimation
                              .firstBoxAnimation.value,
                      translateX: .35 +
                          animatedHomeBackgroundAnimation
                              .firstBoxAnimation.value,
                      translateY: .3,
                      titleFontSize: titleFontSize),
                ),
                GestureDetector(
                  onTap: _startAnimation,
                  child: Container(
                    color: Colors.transparent,
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}

class CardPlaceholder extends StatelessWidget {
  double titleFontSize;
  double translateX;
  double translateY;
  double rotateZ;
  double rotateX;
  CardPlaceholder(
      {required this.titleFontSize,
      required this.translateX,
      required this.rotateX,
      required this.rotateZ,
      required this.translateY,
      super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return Container(
      transformAlignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, .001)
        ..translate(
          size.WIDTH * translateX,
          (size.HEIGHT * translateY),
        )
        ..rotateX(pi * (-rotateX))
        ..rotateZ(pi * (-rotateZ))
        ..rotateY(pi * (-.05)),
      height: size.WIDTH * 1.2,
      width: size.WIDTH * .85,
      decoration: BoxDecoration(
          color: Colors.white12,
          border: Border.all(
              color: const Color.fromARGB(15, 255, 255, 255), width: 3),
          borderRadius: BorderRadius.circular(titleFontSize * .6)),
    );
  }
}

class AnimatedHomeBackgroundAnimation {
  AnimationController controller;
  late Animation<double> firstBoxAnimation;
  late Animation<double> secondBoxAnimation;
  late Animation<double> thirdBoxAnimation;
  late Animation<double> headerAnimation;
  AnimatedHomeBackgroundAnimation(this.controller) {
    headerAnimation = getDoubleAnimation(begin: 0, end: .8);
    firstBoxAnimation = getDoubleAnimation(begin: .1, end: .8);
    secondBoxAnimation = getDoubleAnimation(begin: .3, end: 1);
    thirdBoxAnimation = getDoubleAnimation(begin: .5, end: 1);
  }

  Animation<double> getDoubleAnimation(
      {required double begin, required double end}) {
    return Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(begin, end, curve: Curves.easeOut)));
  }
}
