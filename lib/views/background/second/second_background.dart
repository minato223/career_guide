// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/second/animated_date_list/animated_date_list.dart';
import 'package:career_guide/views/background/second/wave/wave.dart';
import 'package:flutter/material.dart';

class SecondBackground extends StatefulWidget {
  AnimationController animationController;
  SecondBackground({super.key, required this.animationController});

  @override
  State<SecondBackground> createState() => _SecondBackgroundState();
}

class _SecondBackgroundState extends State<SecondBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController waveAnimationController;
  late Animation<double> wavePositionAnimation;
  @override
  void initState() {
    super.initState();
    waveAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _setupAnimation();
  }

  _setupAnimation() {
    wavePositionAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: widget.animationController, curve: Curves.ease));
    widget.animationController.addListener(() {
      if (widget.animationController.status == AnimationStatus.completed) {
        waveAnimationController.repeat();
      }
      if (widget.animationController.status == AnimationStatus.dismissed) {
        waveAnimationController.stop();
      }
    });
  }

  @override
  void dispose() {
    waveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Transform.translate(
                offset: Offset(
                    wavePositionAnimation.value *
                        (-AppSizes(context).WIDTH * .23),
                    0),
                child: AnimatedWave(
                  controller: waveAnimationController,
                ),
              ),
              AnimatedDateList(
                  secondBackgroundController: widget.animationController,
                  waveAnimationController: waveAnimationController,
                  wavePositionAnimation: wavePositionAnimation)
            ],
          );
        });
  }
}
