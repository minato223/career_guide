// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum JobMapGradientSymmetric { horizontal, vertical }

class JobMapGradient extends StatelessWidget {
  JobMapGradientSymmetric symmetric;
  JobMapGradient({super.key, required this.symmetric});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);

    return Container(
      height: size.HEIGHT * .25,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: symmetric == JobMapGradientSymmetric.vertical
                  ? Alignment.topCenter
                  : Alignment.centerLeft,
              end: symmetric == JobMapGradientSymmetric.vertical
                  ? Alignment.bottomCenter
                  : Alignment.centerRight,
              colors: const [
            AppColors.white,
            Color.fromARGB(41, 255, 255, 255),
            AppColors.white,
          ])),
    );
  }
}
