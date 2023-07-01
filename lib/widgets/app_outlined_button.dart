// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  String text;
  AppOutlinedButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: size.CONTENT_SPACE * .8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.dark, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: theme.headlineSmall!.copyWith(
            // color: AppColors.white,
            fontSize: theme.headlineSmall!.fontSize! * .8,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
