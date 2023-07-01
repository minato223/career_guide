// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  double heightRatio;
  Function() goBack;
  Function() goNext;
  Navigation(
      {super.key,
      required this.goBack,
      required this.goNext,
      required this.heightRatio});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      height: heightRatio,
      decoration: BoxDecoration(
          color: Colors.white60, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          SizedBox(
            width: size.WIDTH * .2,
          ),
          Expanded(
              child: Row(
            children: [
              Text(
                "21",
                style: theme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.dark),
              ),
              SizedBox(width: size.CONTENT_SPACE * .5),
              Expanded(
                  child: Text(
                "to responses Ads",
                overflow: TextOverflow.ellipsis,
                style: theme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600, color: AppColors.dark),
              )),
            ],
          )),
          Container(
            width: size.WIDTH * .2,
            margin: EdgeInsets.all(size.CONTENT_SPACE * .5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.yellow, width: 5)),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: goBack,
                      child: const FittedBox(
                          child: Icon(Icons.keyboard_arrow_up_rounded)),
                    )),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: goNext,
                      child: const FittedBox(
                          child: Icon(Icons.keyboard_arrow_down_rounded)),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
