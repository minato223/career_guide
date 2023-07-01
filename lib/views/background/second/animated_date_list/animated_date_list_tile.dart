// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/material.dart';

class AnimatedDateListTile extends StatelessWidget {
  Animation<double> animation;
  double heightRatio;
  String? text;
  int index;
  int currentIndex;
  Duration duration;
  bool isActive;
  AnimatedDateListTile(
      {super.key,
      required this.animation,
      required this.currentIndex,
      required this.duration,
      required this.heightRatio,
      required this.index,
      required this.isActive,
      required this.text});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.CONTENT_SPACE * 1.5),
      transform: Matrix4.identity()
        ..setEntry(3, 2, .001)
        ..translate(0.0, -animation.value * (10)),
      height: heightRatio,
      child: text != null
          ? Row(
              children: [
                Opacity(
                  opacity: animation.value,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          text!,
                          style: theme.titleLarge!.copyWith(
                              fontWeight: index == currentIndex
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color:
                                  AppColors.darkenColor(AppColors.yellow, .5)),
                        )),
                  ),
                ),
                SizedBox(width: size.CONTENT_SPACE * 1.1),
                AnimatedSwitcher(
                    duration: duration,
                    child: isActive
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: size.CONTENT_SPACE * 2.5,
                                width: size.CONTENT_SPACE * 2.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white60),
                              ),
                              Container(
                                height: size.CONTENT_SPACE * .8,
                                width: size.CONTENT_SPACE * .8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.yellow),
                              ),
                            ],
                          )
                        : const SizedBox())
              ],
            )
          : XSpace(0).x,
    );
  }
}
