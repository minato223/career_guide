import 'package:flutter/material.dart';

class JobDetailAnimation {
  final double _ratio = 1 / 15;
  final Curve _curve = Curves.easeOut;
  final Tween<double> zeroToOneTween = Tween<double>(begin: 0, end: 1);
  final Tween<double> oneToZeroTween = Tween<double>(begin: 1, end: 0);
  AnimationController controller;

  late Animation<double> popContextButtonAnimation;
  late Animation<double> actionButtonAnimation;
  late Animation<double> titleAnimation;
  late Animation<double> subtitleAnimation;
  late Animation<double> descriptionAnimation;
  late Animation<double> firstStatAnimation;
  late Animation<double> firstStatTextAnimation;
  late Animation<double> secondStatAnimation;
  late Animation<double> secondStatTextAnimation;
  late Animation<double> thirdStatAnimation;
  late Animation<double> thirdStatTextAnimation;
  late Animation<double> statMapAnimation;
  late Animation<double> profilPicAnimation;
  late Animation<double> profilContainerAnimation;
  late Animation<double> profilTitleAnimation;
  late Animation<double> profilDescriptionAnimation;
  late Animation<double> applyButtonAnimation;

  JobDetailAnimation(this.controller) {
    popContextButtonAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller, curve: Interval(0, _ratio, curve: _curve)));
    actionButtonAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(_ratio, 2 * _ratio, curve: _curve)));
    titleAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(2 * _ratio, 3 * _ratio, curve: _curve)));
    subtitleAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(2.2 * _ratio, 3 * _ratio, curve: _curve)));
    descriptionAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(2.6 * _ratio, 5 * _ratio, curve: _curve)));
    firstStatAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(4 * _ratio, 7 * _ratio, curve: _curve)));
    statMapAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(6 * _ratio, 9 * _ratio, curve: _curve)));
    firstStatTextAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(7 * _ratio, 8 * _ratio, curve: _curve)));
    secondStatAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(7 * _ratio, 8 * _ratio, curve: _curve)));
    thirdStatAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(7 * _ratio, 8 * _ratio, curve: _curve)));
    secondStatTextAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(9 * _ratio, 10 * _ratio, curve: _curve)));
    thirdStatTextAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(9 * _ratio, 10 * _ratio, curve: _curve)));

    profilPicAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(10 * _ratio, 11 * _ratio, curve: _curve)));
    profilContainerAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(10 * _ratio, 11 * _ratio, curve: _curve)));
    profilTitleAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(11 * _ratio, 12 * _ratio, curve: _curve)));

    profilDescriptionAnimation = zeroToOneTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(12 * _ratio, 13 * _ratio, curve: _curve)));
    applyButtonAnimation = oneToZeroTween.animate(CurvedAnimation(
        parent: controller,
        curve: Interval(13 * _ratio, 15 * _ratio, curve: _curve)));
  }
}
