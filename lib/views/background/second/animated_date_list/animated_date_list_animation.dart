import 'package:flutter/material.dart';

class AnimatedDateListAnimation {
  static Tween<double> zeroToOne = Tween<double>(begin: 0, end: 1);
  static Curve curve = Curves.easeOut;
  late final AnimationController _controller;
  late Animation<double> containerAnimation;
  late Animation<double> titleAnimation;
  late Animation<double> titleScaleAnimation;

  late Animation<double> subtitleAnimation;
  AnimatedDateListAnimation(this._controller) {
    containerAnimation = zeroToOne.animate(CurvedAnimation(
        parent: _controller, curve: Interval(0, 1, curve: curve)));
    titleAnimation = zeroToOne.animate(CurvedAnimation(
        parent: _controller, curve: Interval(.2, 1, curve: curve)));
    titleScaleAnimation = Tween<double>(begin: 1.5, end: 1).animate(
        CurvedAnimation(
            parent: _controller, curve: Interval(.2, 1, curve: curve)));
    subtitleAnimation = zeroToOne.animate(CurvedAnimation(
        parent: _controller, curve: Interval(.3, 1, curve: curve)));
  }
}
