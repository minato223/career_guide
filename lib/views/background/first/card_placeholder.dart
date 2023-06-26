// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

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
          color: Colors.white24,
          border: Border.all(color: Colors.white30, width: 3),
          borderRadius: BorderRadius.circular(titleFontSize * .6)),
    );
  }
}
