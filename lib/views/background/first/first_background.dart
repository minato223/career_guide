// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/first/animated_home_background_animation.dart';
import 'package:career_guide/views/background/first/card_placeholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstBackground extends StatelessWidget {
  AnimationController animationController;
  FirstBackground({super.key, required this.animationController});
  AnimatedHomeBackgroundAnimation get animatedHomeBackgroundAnimation =>
      AnimatedHomeBackgroundAnimation(animationController);

  double _getOpacity(double value) {
    return (value - 1) * (-1);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    final double titleFontSize = size.WIDTH * .22;
    return SafeArea(
      child: SizedBox(
        height: size.HEIGHT,
        width: size.WIDTH,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  height: size.HEIGHT * .14,
                  left: -(titleFontSize / 3) -
                      (size.WIDTH *
                          animatedHomeBackgroundAnimation
                              .headerAnimation.value),
                  child: Opacity(
                    opacity: _getOpacity(
                        animatedHomeBackgroundAnimation.headerAnimation.value),
                    child: const FittedBox(
                      child: Text(
                        "CAREER",
                        style: TextStyle(color: Colors.white30),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: size.HEIGHT * .14,
                  top: titleFontSize * 1.1,
                  right: -titleFontSize / 3 -
                      (size.WIDTH *
                          animatedHomeBackgroundAnimation
                              .headerAnimation.value),
                  child: Opacity(
                    opacity: _getOpacity(
                        animatedHomeBackgroundAnimation.headerAnimation.value),
                    child: const FittedBox(
                      child: Text(
                        "GUIDE",
                        style: TextStyle(color: Colors.white30),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: titleFontSize * .12 +
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
                          border: Border.all(color: Colors.white70, width: 2),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
