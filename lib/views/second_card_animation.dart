// ignore_for_file: must_be_immutable

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

List<Color> appColors = [
  Colors.red,
  Colors.blue,
  Colors.yellow,
  // Colors.brown,
  // Colors.cyan,
  // Colors.green
];

class SecondCardAnimation extends StatefulWidget {
  AnimationController appearAnimationController;
  AnimationController disappearAnimationController;
  SecondCardAnimation(
      {super.key,
      required this.appearAnimationController,
      required this.disappearAnimationController});

  @override
  State<SecondCardAnimation> createState() => _SecondCardAnimationState();
}

class _SecondCardAnimationState extends State<SecondCardAnimation> {
  List<Color> colors = [...appColors];
  final List<Animation<double>> _appearAnimations = [];
  final List<Animation<double>> _disappearAnimations = [];
  final int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _setupAnimation();
    // _startAppearAnimation();
  }

  _setupAnimation() {
    for (int i = 0; i < colors.length; i++) {
      double ratio = 1 / colors.length;
      double start = i * (ratio / 5);
      double end = (i + 1) * ratio;
      int reversedIndex = colors.length - i - 1;
      end = 1 - (reversedIndex * ratio / 5);
      Curve curve = Interval(start, end, curve: Curves.easeOut);
      Tween<double> tween = Tween<double>(begin: 0, end: 1);
      Animation<double> appearAnimation = tween.animate(CurvedAnimation(
          parent: widget.appearAnimationController, curve: curve));
      Animation<double> disappearAnimation = tween.animate(CurvedAnimation(
          parent: widget.disappearAnimationController, curve: curve));
      _appearAnimations.add(appearAnimation);
      _disappearAnimations.add(disappearAnimation);
    }
  }

  _getReverse(double value) {
    return (value - 1) * (-1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.disappearAnimationController,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: widget.appearAnimationController,
          builder: (context, child) {
            return Stack(
              children: List.generate(colors.length, (index) {
                double sigma = 0;
                // double sigma = _selectedIndex == index ? 0 : 5;
                return Stack(
                  children: [
                    Opacity(
                      opacity: _appearAnimations[index].value,
                      child: Container(
                        transformAlignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, .001)
                          ..scale(_appearAnimations[index].value)
                          ..translate(
                              (_disappearAnimations[index].value * 300),
                              (index * 80.0),
                              (_getReverse(_disappearAnimations[index].value) *
                                  40))
                          ..rotateY(
                              (pi * .5) * _disappearAnimations[index].value)
                          ..rotateX(
                              (-pi * .1) * _disappearAnimations[index].value),
                        height: 300,
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset.zero,
                                  blurRadius: 10,
                                  spreadRadius: 10)
                            ]),
                      ),
                    ),
                    Positioned.fill(
                        child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                      child: const SizedBox(),
                    ))
                  ],
                );
              }).reversed.toList(),
            );
          },
        );
      },
    );
  }
}
