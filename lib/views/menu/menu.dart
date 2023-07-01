import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/animated_home_background.dart';
import 'package:career_guide/views/home/home_card_animations.dart';
import 'package:career_guide/views/menu/bottom_navigation_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late List<BottomNavigationItem> _navigationItems;
  late AnimationController _firstBackgroundAnimationController;
  late AnimationController _secondBackgroundAnimationController;
  late AnimationController _homeCardController;
  final Duration _duration = const Duration(seconds: 1);
  int _currentMenuIndex = 0;
  @override
  void initState() {
    super.initState();
    _firstBackgroundAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _secondBackgroundAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _homeCardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _firstBackgroundAnimationController.forward();
    _initNavigation();
  }

  _initNavigation() {
    _navigationItems = [
      BottomNavigationItem(icon: CupertinoIcons.home, onTap: _navigateToHome),
      BottomNavigationItem(
          icon: CupertinoIcons.bell, onTap: _navigateToNotification),
      BottomNavigationItem(icon: CupertinoIcons.time, onTap: _navigateToRecent),
    ];
  }

  _navigateToHome() {
    setState(() {
      _currentMenuIndex = 0;
    });
    _secondBackgroundAnimationController.reverse().then((value) {
      _firstBackgroundAnimationController.forward();
      _homeCardController.reverse();
    });
  }

  _navigateToNotification() {
    setState(() {
      _currentMenuIndex = 1;
    });
  }

  _navigateToRecent() {
    setState(() {
      _currentMenuIndex = 2;
    });
    _firstBackgroundAnimationController.reverse().then((value) {
      _secondBackgroundAnimationController.forward();
    });
    _homeCardController.forward();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedHomeBackground(
              firstBackgroundAnimationController:
                  _firstBackgroundAnimationController,
              secondBackgroundAnimationController:
                  _secondBackgroundAnimationController),
          Positioned(
            top: size.HEIGHT * .2,
            right: size.WIDTH * .05,
            child: HomeCardAnimations(
              backgroundAnimationController:
                  _firstBackgroundAnimationController,
              controller: _homeCardController,
            ),
          ),
          Align(
            alignment: const Alignment(0, .9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _navigationItems
                  .asMap()
                  .entries
                  .map((entry) => GestureDetector(
                        onTap: entry.value.onTap,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(size.CONTENT_SPACE),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: entry.key == _currentMenuIndex
                                  ? AppColors.white
                                  : AppColors.white.withOpacity(.6)),
                          child: Icon(
                            entry.value.icon,
                            color: entry.key == _currentMenuIndex
                                ? AppColors.dark
                                : AppColors.dark.withOpacity(.6),
                          ),
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
