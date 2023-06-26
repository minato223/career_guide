// ignore_for_file: must_be_immutable

import 'dart:math';
import 'dart:ui';

import 'package:career_guide/views/common/job_card/job_card.dart';
import 'package:career_guide/views/home/card_item_animation.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  int index;
  Color color;
  void Function(Color)? onCardSwipped;
  void Function(Color)? onCardSwipAnimationComplete;
  Function()? onTapCallback;
  bool isDisplayed;
  bool animationCompleted;
  CardItem(
      {required this.index,
      required this.color,
      required this.isDisplayed,
      required this.animationCompleted,
      this.onCardSwipped,
      this.onCardSwipAnimationComplete,
      this.onTapCallback,
      super.key});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CardItemAnimation cardItemAnimation;
  final Duration duration = const Duration(milliseconds: 1000);
  final double beginScale = .2;
  final double sigma = 5.0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: duration);
    cardItemAnimation = CardItemAnimation(animationController);
    _listenAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _listenAnimation() {
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        widget.onCardSwipAnimationComplete?.call(widget.color);
      }
    });
  }

  _removeCard() {
    animationController.forward();
    widget.onCardSwipped?.call(widget.color);
  }

  @override
  Widget build(BuildContext context) {
    double transformTweenValue =
        widget.animationCompleted ? (widget.isDisplayed ? 0 : .1) : 0;
    double scale =
        widget.animationCompleted ? (widget.isDisplayed ? 1 : beginScale) : 1;
    double blur = 0;
    // double blur =
    //     widget.animationCompleted ? (widget.isDisplayed ? 0 : sigma) : 0;
    return GestureDetector(
      onTap: widget.onTapCallback,
      onHorizontalDragEnd: (DragEndDetails details) {
        if ((details.primaryVelocity != null) && details.primaryVelocity! < 0) {
          _removeCard();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          child: Stack(
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: .1, end: transformTweenValue),
                duration: duration,
                builder: (context, value, child) {
                  return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .001)
                        ..rotateX(pi * (-1) * value)
                        ..rotateY(pi * value)
                        ..rotateZ(pi * value),
                      child: AnimatedScale(
                        curve: Curves.ease,
                        scale: scale,
                        duration: duration,
                        child: AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, .001)
                                ..translate(cardItemAnimation
                                        .translateXAnimation.value *
                                    (-1))
                                ..rotateX(pi *
                                    (cardItemAnimation.rotateXAnimation.value) *
                                    (-1))
                                ..rotateY(pi *
                                    (cardItemAnimation.rotateYAnimation.value) *
                                    (-1))
                                ..rotateZ(pi *
                                    (cardItemAnimation.rotateZAnimation.value) *
                                    (-1)),
                              child: Opacity(
                                opacity:
                                    cardItemAnimation.opacityAnimation.value,
                                child: JobCard(id: widget.index),
                              ),
                            );
                          },
                        ),
                      ));
                },
              ),
              Positioned.fill(
                  child: TweenAnimationBuilder(
                tween: Tween<double>(begin: sigma, end: blur),
                duration: duration,
                builder: (context, value, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                    child: const SizedBox(),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
