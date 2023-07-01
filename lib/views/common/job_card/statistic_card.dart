// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  String title;
  String subtitle;
  String content;
  bool fill;
  StatisticCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.content,
      required this.fill});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Container(
      padding: EdgeInsets.all(size.CONTENT_SPACE),
      decoration: BoxDecoration(
          color: fill ? AppColors.yellow.withOpacity(.7) : null,
          border: fill ? null : Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.headlineSmall,
          ),
          XSpace(size.CONTENT_SPACE * .2).y,
          Text(
            subtitle,
            style: theme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color:
                    fill ? AppColors.darkenColor(AppColors.yellow, .3) : null),
          ),
          XSpace(size.CONTENT_SPACE * 1.5).y,
          const Spacer(),
          Text(
            content,
            style: theme.bodyLarge!
                .copyWith(color: AppColors.dark, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
