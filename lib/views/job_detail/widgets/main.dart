// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_images.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/job_detail/widgets/job_detail_statistic_card.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailMain extends StatelessWidget {
  Animation<double> firstStatTextAnimation;
  Animation<double> firstStatAnimation;
  Animation<double> secondStatTextAnimation;
  Animation<double> secondStatAnimation;
  Animation<double> thirdStatTextAnimation;
  Animation<double> thirdStatAnimation;
  Animation<double> statMapAnimation;
  JobDetailMain(
      {super.key,
      required this.firstStatAnimation,
      required this.firstStatTextAnimation,
      required this.secondStatAnimation,
      required this.secondStatTextAnimation,
      required this.statMapAnimation,
      required this.thirdStatAnimation,
      required this.thirdStatTextAnimation});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Expanded(
        flex: 10,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: JobDetailStaticCard(
                            title: "120k-140k",
                            subtitle: "Salary",
                            fill: true,
                            textAnimation: firstStatTextAnimation,
                            containerAnimation: firstStatAnimation)),
                    XSpace(size.CONTENT_SPACE / 2).y,
                    Expanded(
                        flex: 1,
                        child: JobDetailStaticCard(
                            title: "148",
                            subtitle: "Reviews",
                            fill: false,
                            textAnimation: secondStatTextAnimation,
                            containerAnimation: secondStatAnimation)),
                    XSpace(size.CONTENT_SPACE / 2).y,
                    Expanded(
                        flex: 1,
                        child: JobDetailStaticCard(
                            title: "full-time",
                            subtitle: "Job",
                            fill: false,
                            textAnimation: thirdStatTextAnimation,
                            containerAnimation: thirdStatAnimation))
                  ],
                )),
            XSpace(size.CONTENT_SPACE / 2).x,
            Expanded(
                flex: 1,
                child: Opacity(
                  opacity: getReverse(statMapAnimation.value),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..rotateZ(-pi * .02 * statMapAnimation.value),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(size.CONTENT_SPACE),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(AppImages.map),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(30, 0, 0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset.zero)
                              ]),
                        ),
                        Positioned(
                            top: size.WIDTH * .25,
                            right: size.WIDTH * .1,
                            child: Icon(
                              CupertinoIcons.location_solid,
                              color: AppColors.yellow,
                              size: theme.headlineLarge!.fontSize!,
                            ))
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
