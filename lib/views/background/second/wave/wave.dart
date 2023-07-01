// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AnimatedWave extends StatelessWidget {
  AnimationController controller;
  AnimatedWave({super.key, required this.controller});

  Animation<double> get animation =>
      Tween<double>(begin: 0, end: 1).animate(controller);
  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    final double waveHeight = size.HEIGHT * 2;
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                top: animation.value * (-1) * waveHeight / 4,
                child: Wave(height: waveHeight),
              ),
              Positioned(
                bottom: animation.value * (-1) * waveHeight / 4,
                child: Wave(height: waveHeight),
              ),
            ],
          );
        });
  }
}

class Wave extends StatelessWidget {
  double height;
  Wave({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: height,
        width: size.WIDTH * .22,
        color: const Color.fromARGB(255, 255, 244, 142),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double x = size.width;
    double y = size.height;
    int wavenNumber = 15;
    double ratio = y / wavenNumber;
    double min = x / 2;
    double middle = 3 * x / 4;
    double max = x;
    Path path = Path();
    path.lineTo(middle, 0);
    for (var i = 1; i <= wavenNumber; i++) {
      double x1 = i % 2 != 0 ? max : min;
      double y1 = (ratio / 2) * ((2 * i) - 1);
      double x2 = middle;
      double y2 = (ratio) * i;
      path.quadraticBezierTo(x1, y1, x2, y2);
    }
    path.lineTo(0, y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
