import 'package:flutter/material.dart';

class CardItemAnimation {
  late AnimationController controller;
  Animation<double> rotateXAnimation;
  Animation<double> rotateYAnimation;
  Animation<double> rotateZAnimation;
  Animation<double> translateXAnimation;
  Animation<double> opacityAnimation;
  CardItemAnimation(this.controller)
      : rotateXAnimation = Tween<double>(begin: 0.0, end: .3)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        rotateYAnimation = Tween<double>(begin: 0.0, end: .1)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        rotateZAnimation = Tween<double>(begin: 0.0, end: .1)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        translateXAnimation = Tween<double>(begin: 0.0, end: 500.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        opacityAnimation = Tween<double>(begin: 1, end: .4)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
}
