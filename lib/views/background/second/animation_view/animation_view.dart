// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:ui';

import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/second/animation_view/animation_view_controller.dart';
import 'package:career_guide/views/background/second/animation_view/second_card_animation/second_card_animation.dart';
import 'package:flutter/material.dart';

class AnimationView extends StatefulWidget {
  AnimationViewController? controller;
  AnimationView({super.key, this.controller});

  @override
  State<AnimationView> createState() => AnimationViewState();
}

class AnimationViewState extends State<AnimationView>
    with TickerProviderStateMixin {
  late AnimationController _1appearAnimationController;
  late AnimationController _1disappearAnimationController;

  late AnimationController _2appearAnimationController;
  late AnimationController _2disappearAnimationController;

  final Duration _duration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    widget.controller?.setState(this);
    _1appearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _1disappearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _2appearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _2disappearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _1appearAnimationController.addListener(() {
      if (_1appearAnimationController.status == AnimationStatus.completed) {
        _2appearAnimationController.reset();
        _2disappearAnimationController.reset();
      }
    });
    _2appearAnimationController.addListener(() {
      if (_2appearAnimationController.status == AnimationStatus.completed) {
        _1appearAnimationController.reset();
        _1disappearAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _1appearAnimationController.dispose();
    _1disappearAnimationController.dispose();
    _2appearAnimationController.dispose();
    _2disappearAnimationController.dispose();
    super.dispose();
  }

  forward() {
    _2appearAnimationController.forward();
  }

  dismiss() {
    _1appearAnimationController.reverse();
    _2appearAnimationController.reverse();
  }

  animate() {
    if (_2appearAnimationController.status == AnimationStatus.completed) {
      _2disappearAnimationController.forward();
      _1appearAnimationController.forward();
    }
    if (_1appearAnimationController.status == AnimationStatus.completed) {
      _1disappearAnimationController.forward();
      _2appearAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          SecondCardAnimation(
            appearAnimationController: _1appearAnimationController,
            disappearAnimationController: _1disappearAnimationController,
            heroTagDiff: 10,
          ),
          SecondCardAnimation(
            appearAnimationController: _2appearAnimationController,
            disappearAnimationController: _2disappearAnimationController,
            heroTagDiff: 20,
          ),
        ],
      ),
    );
  }
}
