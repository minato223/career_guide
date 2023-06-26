// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_images.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/common/badge_buttons/badge_button_item.dart';
import 'package:career_guide/views/common/badge_buttons/badge_buttons.dart';
import 'package:career_guide/widgets/app_button.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetail extends StatefulWidget {
  int id;
  JobDetail({super.key, required this.id});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    AppSizes size = AppSizes(context);
    return Hero(
      tag: "home_job${widget.id}",
      child: Container(
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..translate(0.0, 0.0, -30),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30)),
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Column(
              children: [
                XSpace(size.CONTENT_SPACE).y,
                Padding(
                  padding: EdgeInsets.all(size.CONTENT_SPACE),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              size.CONTENT_SPACE * .5,
                              size.CONTENT_SPACE * .5,
                              size.CONTENT_SPACE * .5),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: theme.headlineSmall!.fontSize,
                              ),
                              Positioned(
                                  right: -size.CONTENT_SPACE * .5,
                                  child: Icon(Icons.arrow_back_ios_new_rounded,
                                      size: theme.headlineSmall!.fontSize)),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      BadgeButtons(
                        radius: size.WIDTH * .1,
                        color: Colors.grey[300],
                        iconColor: AppColors.white,
                        items: [
                          BadgeButtonItem(
                              icon: CupertinoIcons.bookmark, onTap: () {}),
                          BadgeButtonItem(
                              icon: CupertinoIcons.bell, onTap: () {})
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(size.CONTENT_SPACE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Arkin Space",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: theme.headlineMedium!.copyWith(
                              color: AppColors.dark,
                              fontWeight: FontWeight.bold),
                        ),
                        XSpace(size.CONTENT_SPACE).y,
                        Text(
                          "User researcher",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: theme.titleLarge,
                        ),
                        XSpace(size.CONTENT_SPACE).y,
                        Text(
                          "Enim esse magna laboris est. Dolore ad ipsum nisi excepteur excepteur elit quis magna cillum. Labore ad nisi enim incididunt dolor veniam sint sint et veniam proident eiusmod. Do occaecat minim officia enim consectetur voluptate et deserunt. Tempor minim reprehenderit elit labore nisi. Ex consequat sunt cillum labore sit commodo incididunt in officia cupidatat ea tempor consectetur. Et officia irure ullamco sunt eiusmod eiusmod cupidatat tempor fugiat veniam laborum ipsum dolore.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: theme.bodyLarge,
                        ),
                        XSpace(size.CONTENT_SPACE).y,
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: mino(
                                            title: "120k-140k",
                                            subtitle: "Salary",
                                            fill: true)),
                                    XSpace(size.CONTENT_SPACE / 2).y,
                                    Expanded(
                                        flex: 1,
                                        child: mino(
                                            title: "148",
                                            subtitle: "Reviews",
                                            fill: false)),
                                    XSpace(size.CONTENT_SPACE / 2).y,
                                    Expanded(
                                        flex: 1,
                                        child: mino(
                                            title: "full-time",
                                            subtitle: "Job",
                                            fill: false))
                                  ],
                                )),
                            XSpace(size.CONTENT_SPACE / 2).x,
                            Expanded(
                                flex: 1,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(size.CONTENT_SPACE),
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: AssetImage(AppImages.map),
                                              fit: BoxFit.cover),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                                color:
                                                    Color.fromARGB(30, 0, 0, 0),
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
                                ))
                          ],
                        )),
                        XSpace(size.CONTENT_SPACE).y,
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: size.WIDTH * .22,
                                decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(AppImages.minato),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              XSpace(size.CONTENT_SPACE / 2).x,
                              Expanded(
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
                                          Text(
                                            "Lamine D.",
                                            style: theme.bodyLarge!.copyWith(
                                                color: AppColors.dark,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text("5/5",
                                              style: theme.bodyLarge!.copyWith(
                                                  color: AppColors.dark,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      XSpace(size.CONTENT_SPACE / 2).y,
                                      Text(
                                        "Laborum exercitation adipisicing eu velit quis ex tempor nostrud nisi in mollit minim non ex. Est nostrud nostrud culpa amet exercitation Lorem. Aliquip aute reprehenderit tempor mollit consectetur non veniam consequat dolor labore sint eu. Officia mollit amet id excepteur magna eiusmod in. Culpa ad ipsum pariatur minim culpa enim sunt anim. Velit adipisicing aliquip et aliqua qui occaecat voluptate in eu qui sunt eu.",
                                        maxLines: 2,
                                        style: theme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.CONTENT_SPACE * 1.5),
                              child: AppButton(
                                  text: "APPLY", width: size.WIDTH * .4)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mino(
      {required String title, required String subtitle, required bool fill}) {
    return Builder(builder: (context) {
      TextTheme theme = Theme.of(context).textTheme;
      AppSizes size = AppSizes(context);
      return Container(
        padding: EdgeInsets.all(size.CONTENT_SPACE),
        width: double.infinity,
        decoration: BoxDecoration(
            color: fill ? AppColors.yellow.withOpacity(.7) : Colors.white,
            border:
                fill ? null : Border.all(color: Colors.grey[300]!, width: 2),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(30, 0, 0, 0),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset.zero)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            XSpace(size.CONTENT_SPACE * .2).y,
            Text(
              subtitle,
              style: theme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: fill
                      ? AppColors.darkenColor(AppColors.yellow, .3)
                      : null),
            )
          ],
        ),
      );
    });
  }
}
