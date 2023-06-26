// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/views/common/badge_buttons/badge_button_item.dart';
import 'package:flutter/material.dart';

class BadgeButtons extends StatelessWidget {
  double? radius;
  Color? color;
  Color? iconColor;
  List<BadgeButtonItem> items;
  BadgeButtons(
      {super.key, this.color, this.radius, required this.items, this.iconColor})
      : assert(items.length == 2);

  @override
  Widget build(BuildContext context) {
    double value = radius ?? 150;
    Color bgColor = color ?? AppColors.yellow;
    return Material(
      child: SizedBox(
        height: value,
        width: value * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customAvatar(),
                customAvatar(),
              ],
            ),
            RotatedBox(
              quarterTurns: 1,
              child: ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: value * .4,
                  width: value * .8,
                  color: bgColor,
                ),
              ),
            ),
            Positioned.fill(
                child: Row(
              children: items
                  .map((item) => SizedBox(
                        width: value,
                        height: value,
                        child: FittedBox(
                            child: IconButton(
                                onPressed: item.onTap,
                                icon: Icon(
                                  item.icon,
                                  color: iconColor,
                                ))),
                      ))
                  .toList(),
            ))
          ],
        ),
      ),
    );
  }

  Widget customAvatar() {
    double value = radius ?? 150;
    Color bgColor = color ?? AppColors.yellow;
    return Container(
      width: value,
      height: value,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double x = size.width;
    double y = size.height;
    Path path = Path();
    path.lineTo(x, 0);
    path.quadraticBezierTo(x * .8, y / 2, x, y);
    path.lineTo(0, y);
    path.quadraticBezierTo(x * .2, y / 2, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
