// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_images.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/widgets/animated_text.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/material.dart';

class JobDetailFooter extends StatelessWidget {
  Animation<double> profilPicAnimation;
  Animation<double> profilContainerAnimation;
  Animation<double> profilTitleAnimation;
  Animation<double> profilDescriptionAnimation;
  JobDetailFooter(
      {super.key,
      required this.profilContainerAnimation,
      required this.profilDescriptionAnimation,
      required this.profilPicAnimation,
      required this.profilTitleAnimation});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return IntrinsicHeight(
      child: Row(
        children: [
          Opacity(
            opacity: getReverse(profilPicAnimation.value).clamp(.9, 1),
            child: Container(
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(-pi * .1 * profilPicAnimation.value)
                ..rotateY(pi * .1 * profilPicAnimation.value)
                ..rotateZ(pi * .1 * profilPicAnimation.value)
                ..scale(getReverse(profilPicAnimation.value)),
              width: size.WIDTH * .22,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(AppImages.minato), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          XSpace(size.CONTENT_SPACE / 2).x,
          Expanded(
            child: Opacity(
              opacity: profilContainerAnimation.value,
              child: Transform.scale(
                scale: profilContainerAnimation.value.clamp(.8, 1),
                child: Container(
                  padding: EdgeInsets.all(size.CONTENT_SPACE),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(14, 0, 0, 0),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset.zero)
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AnimatedText(
                            animation: profilTitleAnimation,
                            text: "Lamine D.",
                            style: theme.bodyLarge!.copyWith(
                                color: AppColors.dark,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          AnimatedText(
                              animation: profilTitleAnimation,
                              text: "5/5",
                              style: theme.bodyLarge!.copyWith(
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      XSpace(size.CONTENT_SPACE / 2).y,
                      Opacity(
                        opacity: profilDescriptionAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0.0,
                              10 - (profilDescriptionAnimation.value * 10)),
                          child: Text(
                            "Laborum exercitation adipisicing eu velit quis ex tempor nostrud nisi in mollit minim non ex. Est nostrud nostrud culpa amet exercitation Lorem. Aliquip aute reprehenderit tempor mollit consectetur non veniam consequat dolor labore sint eu. Officia mollit amet id excepteur magna eiusmod in. Culpa ad ipsum pariatur minim culpa enim sunt anim. Velit adipisicing aliquip et aliqua qui occaecat voluptate in eu qui sunt eu.",
                            maxLines: 2,
                            style: theme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
