import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/animated_home_background.dart';
import 'package:career_guide/views/home/home_card_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late AnimationController firstBackgroundAnimationController;
  late AnimationController secondBackgroundAnimationController;
  final Duration duration = const Duration(seconds: 1);
  @override
  void initState() {
    super.initState();
    firstBackgroundAnimationController =
        AnimationController(vsync: this, duration: duration);
    secondBackgroundAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    firstBackgroundAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedHomeBackground(
              firstBackgroundAnimationController:
                  firstBackgroundAnimationController,
              secondBackgroundAnimationController:
                  secondBackgroundAnimationController),
          Positioned(
            top: size.HEIGHT * .2,
            right: size.WIDTH * .05,
            child: HomeCardAnimations(
              backgroundAnimationController: firstBackgroundAnimationController,
            ),
          ),
          Align(
            alignment: const Alignment(0, .9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoIcons.home,
                CupertinoIcons.bell,
                CupertinoIcons.time,
              ]
                  .asMap()
                  .entries
                  .map((e) => Container(
                        padding: EdgeInsets.all(size.CONTENT_SPACE),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: e.key == 0
                                ? AppColors.white
                                : AppColors.white.withOpacity(.6)),
                        child: Icon(
                          e.value,
                          color: e.key == 0
                              ? AppColors.dark
                              : AppColors.dark.withOpacity(.6),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
