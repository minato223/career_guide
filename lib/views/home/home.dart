// ignore_for_file: must_be_immutable
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

List<Color> appColors = [
  Colors.red,
  Colors.purple,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.pink,
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Animation<Offset>> offsetAnimations = [];
  List<Animation<double>> opacityAnimations = [];
  List<Animation<double>> scaleAnimations = [];
  List<Color> colors = [];
  List<Color> displayed = [];
  bool animationCompleted = false;

  @override
  void initState() {
    super.initState();
    colors = [...appColors];
    displayed = [appColors[0]];
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _setupAnimations();
    _startAnimations();
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        setState(() {
          animationCompleted = true;
        });
      }
    });
  }

  void _setupAnimations() {
    for (int i = 0; i < colors.length; i++) {
      double ratio = 1 / colors.length;
      double delayStart = (i.toDouble() * (ratio / 2));
      double delayEnd = .5 + (i * (.5 / colors.length));
      var curve = CurvedAnimation(
        parent: animationController,
        curve: Interval(delayStart, delayEnd, curve: Curves.easeOut),
      );
      final animation = Tween<Offset>(
        begin: const Offset(.8, 0.0),
        end: Offset.zero,
      ).animate(curve);
      final animation2 = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(curve);
      final animation3 = Tween<double>(
        begin: .4,
        end: 1,
      ).animate(curve);
      offsetAnimations.add(animation);
      opacityAnimations.add(animation2);
      scaleAnimations.add(animation3);
    }
  }

  void _startAnimations() {
    animationController.forward();
  }

  _changeCurrentColor(Color color) {
    setState(() {
      colors.remove(color);
    });
  }

  _scaleNext(Color color) {
    int index = colors.indexOf(color);
    if (colors.elementAtOrNull(index + 1) != null) {
      setState(() {
        displayed.add(colors[index + 1]);
      });
    }
  }

  _restartAnimation() {
    setState(() {
      colors = [...appColors];
      displayed = [colors[0]];
      animationCompleted = false;
    });
    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Align(
          alignment: Alignment.center,
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: colors.reversed.toList().asMap().entries.map((e) {
                    int index = colors.length - e.key - 1;
                    return AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return FractionalTranslation(
                            translation: offsetAnimations[index].value,
                            child: Transform.scale(
                              scale: scaleAnimations[index].value,
                              child: Opacity(
                                  opacity: opacityAnimations[index].value,
                                  child: child),
                            ),
                          );
                        },
                        child: CardItem(
                          color: colors[index],
                          animationCompleted: animationCompleted,
                          isDisplayed: displayed.contains(colors[index]),
                          onCardSwipped: _scaleNext,
                          onCardSwipAnimationComplete: _changeCurrentColor,
                        ));
                  }).toList(),
                ),
                TextButton(
                    onPressed: () {
                      _restartAnimation();
                    },
                    child: Text("Restart"))
              ],
            ),
          ),
        ));
  }
}

class CardItemAnimation {
  late AnimationController controller;
  Animation<double> rotateXAnimation;
  Animation<double> rotateYAnimation;
  Animation<double> rotateZAnimation;
  Animation<double> translateXAnimation;
  Animation<double> opacityAnimation;
  CardItemAnimation(this.controller)
      : rotateXAnimation = Tween<double>(begin: 0.0, end: .3)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        rotateYAnimation = Tween<double>(begin: 0.0, end: .1)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        rotateZAnimation = Tween<double>(begin: 0.0, end: .1)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        translateXAnimation = Tween<double>(begin: 0.0, end: 500.0)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        opacityAnimation = Tween<double>(begin: 1, end: .4)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
}

class CardItem extends StatefulWidget {
  Color color;
  void Function(Color)? onCardSwipped;
  void Function(Color)? onCardSwipAnimationComplete;
  bool isDisplayed;
  bool animationCompleted;
  CardItem(
      {required this.color,
      required this.isDisplayed,
      required this.animationCompleted,
      this.onCardSwipped,
      this.onCardSwipAnimationComplete,
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
    double blur =
        widget.animationCompleted ? (widget.isDisplayed ? 0 : sigma) : 0;
    return GestureDetector(
      onTap: () {
        _removeCard();
      },
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
                              ..translate(
                                  cardItemAnimation.translateXAnimation.value *
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
                              opacity: cardItemAnimation.opacityAnimation.value,
                              child: Container(
                                width: 300,
                                height: 400,
                                color: Colors.white,
                                child: const Text("Lamine"),
                              ),
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
    );
  }
}
