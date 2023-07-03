// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/common/badge_buttons/badge_button_item.dart';
import 'package:career_guide/views/common/badge_buttons/badge_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailAppBar extends StatefulWidget {
  Animation<double> popButtonAnimation;
  Animation<double> actionButtonAnimation;
  JobDetailAppBar(
      {super.key,
      required this.actionButtonAnimation,
      required this.popButtonAnimation});

  @override
  State<JobDetailAppBar> createState() => _JobDetailAppBarState();
}

class _JobDetailAppBarState extends State<JobDetailAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _bellAnimationController;
  late Animation<double> _bellAnimation;
  List<TweenSequenceItem<double>> items = [
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: -.1), weight: 1),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: -.1, end: 0), weight: 1),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: .1), weight: 1),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: .1, end: 0), weight: 1),
  ];
  bool _addedToBookmark = false;
  bool _notificationEnabled = false;
  final Duration _duration = const Duration(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    _bellAnimationController =
        AnimationController(vsync: this, duration: _duration);
    _bellAnimation = TweenSequence(items).animate(_bellAnimationController);
    _bellAnimationController.addListener(() {
      if (_bellAnimationController.status == AnimationStatus.completed) {
        setState(() {
          _notificationEnabled = true;
        });
      }
      if (_bellAnimationController.status == AnimationStatus.dismissed) {
        setState(() {
          _notificationEnabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _bellAnimationController.dispose();
    super.dispose();
  }

  _addToBookmark() {
    setState(() {
      _addedToBookmark = !_addedToBookmark;
    });
  }

  _animateBell() {
    if (_bellAnimationController.status == AnimationStatus.completed) {
      _bellAnimationController.reverse();
    }
    if (_bellAnimationController.status == AnimationStatus.dismissed) {
      _bellAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Padding(
      padding: EdgeInsets.all(size.CONTENT_SPACE),
      child: Row(
        children: [
          Transform.translate(
            offset: Offset(20 - (widget.popButtonAnimation.value * 20), 0.0),
            child: Opacity(
                opacity: widget.popButtonAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, size.CONTENT_SPACE * .5,
                        size.CONTENT_SPACE * .5, size.CONTENT_SPACE * .5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: theme.headlineSmall!.fontSize,
                        ),
                        Positioned(
                            right: -size.CONTENT_SPACE * .5,
                            child: Icon(Icons.arrow_back_ios_new_rounded,
                                size: theme.headlineSmall!.fontSize)),
                      ],
                    ),
                  ),
                )),
          ),
          const Spacer(),
          Opacity(
            opacity: widget.actionButtonAnimation.value,
            child: BadgeButtons(
              radius: size.WIDTH * .1,
              color: Colors.grey[300],
              iconColor: AppColors.white,
              items: [
                BadgeButtonItem(
                    child: GestureDetector(
                        onTap: _addToBookmark,
                        child: Padding(
                          padding: EdgeInsets.all(size.CONTENT_SPACE * .7),
                          child: AnimatedSwitcher(
                              duration: _duration,
                              child: _addedToBookmark
                                  ? Icon(
                                      CupertinoIcons.bookmark_fill,
                                      key: UniqueKey(),
                                      color: AppColors.white,
                                    )
                                  : Icon(
                                      CupertinoIcons.bookmark,
                                      key: UniqueKey(),
                                      color: AppColors.white,
                                    )),
                        ))),
                BadgeButtonItem(
                    child: AnimatedBuilder(
                        animation: _bellAnimation,
                        builder: (context, child) {
                          return GestureDetector(
                              onTap: _animateBell,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(size.CONTENT_SPACE * .5),
                                child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, .001)
                                      ..rotateZ(pi * _bellAnimation.value),
                                    child: AnimatedSwitcher(
                                        duration: _duration,
                                        child: _notificationEnabled
                                            ? Icon(
                                                CupertinoIcons.bell_fill,
                                                key: UniqueKey(),
                                                color: AppColors.white,
                                              )
                                            : Icon(
                                                CupertinoIcons.bell,
                                                key: UniqueKey(),
                                                color: AppColors.white,
                                              ))),
                              ));
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
