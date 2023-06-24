// ignore_for_file: non_constant_identifier_names

import 'package:career_guide/views/second_card_animation.dart';
import 'package:flutter/material.dart';

class AnimationView extends StatefulWidget {
  const AnimationView({super.key});

  @override
  State<AnimationView> createState() => _AnimationViewState();
}

class _AnimationViewState extends State<AnimationView>
    with TickerProviderStateMixin {
  late AnimationController _1appearAnimationController;
  late AnimationController _1disappearAnimationController;

  late AnimationController _2appearAnimationController;
  late AnimationController _2disappearAnimationController;

  final Duration _duration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    _1appearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _1disappearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _2appearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _2disappearAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _2appearAnimationController.forward();
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

  _animate() {
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
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SecondCardAnimation(
                      appearAnimationController: _1appearAnimationController,
                      disappearAnimationController:
                          _1disappearAnimationController),
                  SecondCardAnimation(
                      appearAnimationController: _2appearAnimationController,
                      disappearAnimationController:
                          _2disappearAnimationController),
                ],
              ),
            ),
          ),
          TextButton(onPressed: _animate, child: Text("Change"))
        ],
      ),
    );
  }
}
