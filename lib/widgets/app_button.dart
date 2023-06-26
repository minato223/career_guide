// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;
  double? width;
  AppButton({super.key, required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: size.CONTENT_SPACE * .8),
      decoration: BoxDecoration(
          color: AppColors.dark, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: theme.headlineSmall!.copyWith(
            color: AppColors.white,
            fontSize: theme.headlineSmall!.fontSize! * .8,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
