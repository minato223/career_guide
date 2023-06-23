// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/first_background.dart';
import 'package:career_guide/views/background/second_background.dart';
import 'package:flutter/material.dart';

class AnimatedHomeBackground extends StatefulWidget {
  const AnimatedHomeBackground({super.key});

  @override
  State<AnimatedHomeBackground> createState() => _AnimatedHomeBackgroundState();
}

class _AnimatedHomeBackgroundState extends State<AnimatedHomeBackground>
    with TickerProviderStateMixin {
  late AnimationController firstBackgroundAnimationController;
  late AnimationController secondBackgroundAnimationController;
  final Duration duration = const Duration(milliseconds: 600);
  @override
  void initState() {
    super.initState();
    firstBackgroundAnimationController =
        AnimationController(vsync: this, duration: duration);
    secondBackgroundAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    // firstBackgroundAnimationController.forward();
  }

  @override
  void dispose() {
    firstBackgroundAnimationController.dispose();
    super.dispose();
  }

  _startAnimation() {
    if (firstBackgroundAnimationController.status ==
        AnimationStatus.completed) {
      firstBackgroundAnimationController.reverse();
    }
    if (firstBackgroundAnimationController.status ==
        AnimationStatus.dismissed) {
      firstBackgroundAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    final double titleFontSize = size.WIDTH * .22;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          FirstBackground(
              animationController: firstBackgroundAnimationController),
          SecondBackground(
              animationController: secondBackgroundAnimationController)
          // GestureDetector(
          //   onTap: _startAnimation,
          //   child: Container(
          //     color: Colors.transparent,
          //   ),
          // )
        ],
      ),
    );
  }
}
