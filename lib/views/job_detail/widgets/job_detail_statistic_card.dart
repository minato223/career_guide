// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/widgets/animated_text.dart';
import 'package:flutter/material.dart';

class JobDetailStaticCard extends StatelessWidget {
  String title;
  String subtitle;
  bool fill;
  Animation<double> containerAnimation;
  Animation<double> textAnimation;
  JobDetailStaticCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.fill,
      required this.containerAnimation,
      required this.textAnimation});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Opacity(
      opacity: getReverse(containerAnimation.value),
      child: Container(
        transformAlignment: Alignment.center,
        padding: EdgeInsets.all(size.CONTENT_SPACE),
        width: double.infinity,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..rotateX(-.2 * pi * containerAnimation.value)
          ..rotateY(.2 * pi * containerAnimation.value)
          ..scale(getReverse(containerAnimation.value)),
        decoration: BoxDecoration(
            color: fill ? AppColors.yellow.withOpacity(.7) : Colors.white,
            border:
                fill ? null : Border.all(color: Colors.grey[300]!, width: 2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(30, 0, 0, 0),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset.zero)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: FittedBox(
                child: AnimatedText(
                  animation: textAnimation,
                  text: title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Opacity(
                  opacity: textAnimation.value,
                  child: Text(
                    subtitle,
                    style: theme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: fill
                            ? AppColors.darkenColor(AppColors.yellow, .3)
                            : null),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
