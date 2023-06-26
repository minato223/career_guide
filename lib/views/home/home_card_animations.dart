// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/home/card_item.dart';
import 'package:career_guide/views/job_detail/job_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Color> appColors = [
  Colors.red,
  Colors.purple,
  Colors.green,
  Colors.pink,
];

class HomeCardAnimations extends StatefulWidget {
  AnimationController backgroundAnimationController;
  HomeCardAnimations({super.key, required this.backgroundAnimationController});

  @override
  State<HomeCardAnimations> createState() => _HomeCardAnimationsState();
}

class _HomeCardAnimationsState extends State<HomeCardAnimations>
    with SingleTickerProviderStateMixin {
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

  _goToDetail(int id) {
    widget.backgroundAnimationController
        .reverse()
        .then((value) => Navigator.of(context)
                .push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) {
                      return JobDetail(id: id);
                    }),
                    transitionDuration: const Duration(milliseconds: 600)))
                .then((value) {
              widget.backgroundAnimationController.forward();
            }));
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (animationCompleted)
                  SizedBox(
                    height: size.HEIGHT * .65,
                    width: size.WIDTH * .8,
                    child: GestureDetector(
                      onTap: () {
                        _restartAnimation();
                      },
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(size.CONTENT_SPACE * 2),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              CupertinoIcons.refresh,
                              color: AppColors.dark,
                              size: theme.headlineLarge!.fontSize,
                            )),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                ...colors.reversed.toList().asMap().entries.map((e) {
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
                        index: index,
                        animationCompleted: animationCompleted,
                        isDisplayed: displayed.contains(colors[index]),
                        onCardSwipped: _scaleNext,
                        onTapCallback: () {
                          _goToDetail(index);
                        },
                        onCardSwipAnimationComplete: _changeCurrentColor,
                      ));
                }).toList()
              ],
            )
          ],
        ),
      ),
    );
  }
}
