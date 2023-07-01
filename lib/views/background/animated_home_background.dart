// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/views/background/first/first_background.dart';
import 'package:career_guide/views/background/second/second_background.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Stack(
        children: [
          FirstBackground(
              animationController: widget.firstBackgroundAnimationController),
          SecondBackground(
              animationController: widget.secondBackgroundAnimationController)
        ],
      ),
    );
  }
}
