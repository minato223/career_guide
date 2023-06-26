// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/first/first_background.dart';
import 'package:career_guide/views/background/second_background.dart';
import 'package:flutter/material.dart';

class AnimatedHomeBackground extends StatefulWidget {
  AnimationController firstBackgroundAnimationController;
  AnimationController secondBackgroundAnimationController;
  AnimatedHomeBackground(
      {super.key,
      required this.firstBackgroundAnimationController,
      required this.secondBackgroundAnimationController});

  @override
  State<AnimatedHomeBackground> createState() => _AnimatedHomeBackgroundState();
}

class _AnimatedHomeBackgroundState extends State<AnimatedHomeBackground> {
  // late AnimationController firstBackgroundAnimationController;
  // late AnimationController secondBackgroundAnimationController;
  // final Duration duration = const Duration(milliseconds: 600);
  @override
  void initState() {
    super.initState();
    // firstBackgroundAnimationController =
    //     AnimationController(vsync: this, duration: duration);
    // secondBackgroundAnimationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 20));
    // firstBackgroundAnimationController.forward();
  }

  @override
  void dispose() {
    // firstBackgroundAnimationController.dispose();
    super.dispose();
  }

  // _startAnimation() {
  //   if (firstBackgroundAnimationController.status ==
  //       AnimationStatus.completed) {
  //     firstBackgroundAnimationController.reverse();
  //   }
  //   if (firstBackgroundAnimationController.status ==
  //       AnimationStatus.dismissed) {
  //     firstBackgroundAnimationController.forward();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Stack(
        children: [
          FirstBackground(
              animationController: widget.firstBackgroundAnimationController),
          // SecondBackground(
          //     animationController: widget.secondBackgroundAnimationController)
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
