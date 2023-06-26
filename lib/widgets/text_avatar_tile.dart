// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/material.dart';

class TextAvatarTile extends StatelessWidget {
  String text;
  TextAvatarTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    String firstLetter = text.substring(0, 1);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.yellow.withOpacity(.4),
          radius: 25,
          child: Text(firstLetter,
              style: theme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkenColor(AppColors.yellow, .5))),
        ),
        XSpace(size.CONTENT_SPACE * .7).x,
        Expanded(
          child: Text(text.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.headlineSmall),
        )
      ],
    );
  }
}
