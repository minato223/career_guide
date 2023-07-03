// ignore_for_file: must_be_immutable

import 'dart:math';
import 'dart:ui';

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/common/job_card/job_card.dart';
import 'package:flutter/material.dart';

List<Color> appColors = [
  Colors.red,
  Colors.blue,
  Colors.yellow,
];

class SecondCardAnimation extends StatefulWidget {
  AnimationController appearAnimationController;
  AnimationController disappearAnimationController;
  int heroTagDiff;
  SecondCardAnimation(
      {super.key,
      required this.appearAnimationController,
      required this.disappearAnimationController,
      required this.heroTagDiff});

  @override
  State<SecondCardAnimation> createState() => _SecondCardAnimationState();
}

class _SecondCardAnimationState extends State<SecondCardAnimation> {
  List<Color> colors = [...appColors];
  final List<Animation<double>> _appearAnimations = [];
  final List<Animation<double>> _disappearAnimations = [];
  @override
  void initState() {
    super.initState();
    _setupAnimation();
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

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return AnimatedBuilder(
      animation: widget.disappearAnimationController,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: widget.appearAnimationController,
          builder: (context, child) {
            return Stack(
              children: List.generate(colors.length, (index) {
                double sigma = index == 0 ? 0 : 5.0;
                return Opacity(
                  opacity: _appearAnimations[index].value,
                  child: Container(
                    transformAlignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..scale(_appearAnimations[index].value)
                      ..translate(
                          (_disappearAnimations[index].value * 300),
                          (index * size.HEIGHT * .08),
                          (getReverse(_disappearAnimations[index].value) * 40))
                      ..rotateY((pi * .5) * _disappearAnimations[index].value)
                      ..rotateX((-pi * .1) * _disappearAnimations[index].value),
                    child: Stack(
                      children: [
                        JobCard(
                          id: index + widget.heroTagDiff,
                          isRecentView: true,
                        ),
                        Positioned.fill(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: sigma, sigmaY: sigma),
                              child: const SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).reversed.toList(),
            );
          },
        );
      },
    );
  }
}
