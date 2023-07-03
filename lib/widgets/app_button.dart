// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  double? width;
  Color? color;
  Color? textColor;
  Function()? onTap;
  AppButton(
      {super.key,
      required this.text,
      this.width,
      this.onTap,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: size.CONTENT_SPACE * .8),
        decoration: BoxDecoration(
            color: color ?? AppColors.dark,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: theme.headlineSmall!.copyWith(
              color: textColor ?? AppColors.white,
              fontSize: theme.headlineSmall!.fontSize! * .8,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
