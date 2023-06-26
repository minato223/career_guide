import 'package:flutter/material.dart';

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
