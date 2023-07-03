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
  AnimationController controller;
  HomeCardAnimations(
      {super.key,
      required this.backgroundAnimationController,
      required this.controller});

  @override
  State<HomeCardAnimations> createState() => _HomeCardAnimationsState();
}

class _HomeCardAnimationsState extends State<HomeCardAnimations> {
  late Animation<Offset> _offsetAnimations;
  late Animation<double> _opacityAnimations;
  late Animation<double> _scaleAnimations;
  List<Color> colors = [];
  List<Color> displayed = [];

  @override
  void initState() {
    super.initState();
    colors = [...appColors];
    displayed = [appColors[0]];
    _setupAnimations();
  }

  void _setupAnimations() {
    for (int i = 0; i < colors.length; i++) {
      double ratio = 1 / colors.length;
      double delayStart = (i.toDouble() * (ratio / 2));
      double delayEnd = .5 + (i * (.5 / colors.length));
      var curve = CurvedAnimation(
        parent: widget.controller,
        curve: Interval(delayStart, delayEnd, curve: Curves.easeOut),
      );
      _offsetAnimations = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(.8, 0.0),
      ).animate(curve);
      _opacityAnimations = Tween<double>(
        begin: 1,
        end: 0,
      ).animate(curve);
      _scaleAnimations = Tween<double>(
        begin: 1,
        end: .4,
      ).animate(curve);
    }
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
    });
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
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return FractionalTranslation(
            translation: _offsetAnimations.value,
            child: Transform.scale(
              scale: _scaleAnimations.value,
              child: Opacity(opacity: _opacityAnimations.value, child: child),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
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
            ),
            ...colors.reversed.toList().asMap().entries.map((e) {
              int index = colors.length - e.key - 1;
              return CardItem(
                color: colors[index],
                index: index,
                isDisplayed: displayed.contains(colors[index]),
                onCardSwipped: _scaleNext,
                onTapCallback: () {
                  _goToDetail(index);
                },
                onCardSwipAnimationComplete: _changeCurrentColor,
              );
            }).toList()
          ],
        ));
  }
}
