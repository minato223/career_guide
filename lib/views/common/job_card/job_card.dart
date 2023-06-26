// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_images.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/common/badge_buttons/badge_button_item.dart';
import 'package:career_guide/views/common/badge_buttons/badge_buttons.dart';
import 'package:career_guide/views/common/job_card/job_map_gradient.dart';
import 'package:career_guide/views/common/job_card/statistic_card.dart';
import 'package:career_guide/widgets/app_button.dart';
import 'package:career_guide/widgets/text_avatar_tile.dart';
import 'package:flutter/material.dart';
import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/cupertino.dart';

class JobCard extends StatelessWidget {
  int id;
  JobCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Hero(
      tag: "home_job$id",
      child: Container(
        padding: EdgeInsets.all(size.CONTENT_SPACE * 1.3),
        height: size.HEIGHT * .65,
        width: size.WIDTH * .8,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(40)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Image.asset(
                    AppImages.map,
                    width: double.infinity,
                    height: size.HEIGHT * .25,
                    fit: BoxFit.cover,
                  ),
                  JobMapGradient(symmetric: JobMapGradientSymmetric.horizontal),
                  JobMapGradient(symmetric: JobMapGradientSymmetric.vertical),
                  Positioned(
                      bottom: size.WIDTH * .25,
                      right: size.WIDTH * .1,
                      child: Icon(
                        CupertinoIcons.location_solid,
                        color: AppColors.yellow,
                        size: theme.headlineLarge!.fontSize!,
                      ))
                ],
              ),
            ),
            Column(
              children: [
                TextAvatarTile(text: "Arkin Space"),
                XSpace(size.CONTENT_SPACE * .5).y,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "User researcher",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: theme.titleLarge,
                      ),
                    ),
                    Material(
                      child: Chip(
                          label: Text(
                        "FULL-TIME",
                        style: theme.titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                    )
                  ],
                ),
                XSpace(size.CONTENT_SPACE * .4).y,
                Text(
                  "Enim esse magna laboris est. Dolore ad ipsum nisi excepteur excepteur elit quis magna cillum. Labore ad nisi enim incididunt dolor veniam sint sint et veniam proident eiusmod. Do occaecat minim officia enim consectetur voluptate et deserunt. Tempor minim reprehenderit elit labore nisi. Ex consequat sunt cillum labore sit commodo incididunt in officia cupidatat ea tempor consectetur. Et officia irure ullamco sunt eiusmod eiusmod cupidatat tempor fugiat veniam laborum ipsum dolore.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: theme.bodyLarge,
                ),
                XSpace(size.CONTENT_SPACE).y,
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: StatisticCard(
                            title: "120k+",
                            subtitle: "Salary",
                            content: "Increase every six mouth",
                            fill: true)),
                    XSpace(size.CONTENT_SPACE * .5).x,
                    Expanded(
                        flex: 1,
                        child: StatisticCard(
                            title: "148",
                            subtitle: "Reviews",
                            content: "Reviews from workers",
                            fill: false))
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    BadgeButtons(
                      radius: size.WIDTH * .12,
                      color: Colors.grey[500],
                      iconColor: AppColors.white,
                      items: [
                        BadgeButtonItem(
                            icon: CupertinoIcons.bookmark, onTap: () {}),
                        BadgeButtonItem(icon: CupertinoIcons.bell, onTap: () {})
                      ],
                    ),
                    const Spacer(),
                    AppButton(text: "APPLY", width: size.WIDTH * .4),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
