// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/job_detail/job_detail_animation.dart';
import 'package:career_guide/views/job_detail/widgets/app_bar.dart';
import 'package:career_guide/views/job_detail/widgets/footer.dart';
import 'package:career_guide/views/job_detail/widgets/main.dart';
import 'package:career_guide/widgets/animated_text.dart';
import 'package:career_guide/widgets/app_button.dart';
import 'package:career_guide/widgets/xspace.dart';
import 'package:flutter/material.dart';

class JobDetail extends StatefulWidget {
  int id;
  JobDetail({super.key, required this.id});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _appliedAnimationController;
  late JobDetailAnimation _detailAnimation;
  bool _applied = false;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _appliedAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _detailAnimation = JobDetailAnimation(_controller);
    _appliedAnimationController.addListener(() {
      if (_appliedAnimationController.value > .4 && !_applied) {
        setState(() {
          _applied = true;
        });
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _appliedAnimationController.dispose();
    _controller.dispose();
    super.dispose();
  }

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
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SafeArea(
                child: Column(
                  children: [
                    XSpace(size.CONTENT_SPACE).y,
                    JobDetailAppBar(
                        actionButtonAnimation:
                            _detailAnimation.actionButtonAnimation,
                        popButtonAnimation:
                            _detailAnimation.popContextButtonAnimation),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(size.CONTENT_SPACE),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedText(
                              animation: _detailAnimation.titleAnimation,
                              text: "Arkin Space",
                              style: theme.headlineMedium!.copyWith(
                                  color: AppColors.dark,
                                  fontWeight: FontWeight.bold),
                            ),
                            XSpace(size.CONTENT_SPACE).y,
                            AnimatedText(
                              animation: _detailAnimation.titleAnimation,
                              text: "User researcher",
                              style: theme.titleLarge,
                            ),
                            XSpace(size.CONTENT_SPACE).y,
                            Expanded(
                              flex: 3,
                              child: Opacity(
                                opacity:
                                    _detailAnimation.descriptionAnimation.value,
                                child: Transform.translate(
                                  offset: Offset(
                                      0.0,
                                      20 -
                                          (_detailAnimation
                                                  .descriptionAnimation.value *
                                              20)),
                                  child: Text(
                                    "Enim esse magna laboris est. Dolore ad ipsum nisi excepteur excepteur elit quis magna cillum. Labore ad nisi enim incididunt dolor veniam sint sint et veniam proident eiusmod. Do occaecat minim officia enim consectetur voluptate et deserunt. Tempor minim reprehenderit elit labore nisi. Ex consequat sunt cillum labore sit commodo incididunt in officia cupidatat ea tempor consectetur. Et officia irure ullamco sunt eiusmod eiusmod cupidatat tempor fugiat veniam laborum ipsum dolore.",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: theme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                            JobDetailMain(
                                firstStatAnimation:
                                    _detailAnimation.firstStatAnimation,
                                firstStatTextAnimation:
                                    _detailAnimation.firstStatTextAnimation,
                                secondStatAnimation:
                                    _detailAnimation.secondStatAnimation,
                                secondStatTextAnimation:
                                    _detailAnimation.secondStatTextAnimation,
                                statMapAnimation:
                                    _detailAnimation.statMapAnimation,
                                thirdStatAnimation:
                                    _detailAnimation.thirdStatAnimation,
                                thirdStatTextAnimation:
                                    _detailAnimation.thirdStatTextAnimation),
                            XSpace(size.CONTENT_SPACE).y,
                            JobDetailFooter(
                                profilContainerAnimation:
                                    _detailAnimation.profilContainerAnimation,
                                profilDescriptionAnimation:
                                    _detailAnimation.profilDescriptionAnimation,
                                profilPicAnimation:
                                    _detailAnimation.profilPicAnimation,
                                profilTitleAnimation:
                                    _detailAnimation.profilTitleAnimation),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Opacity(
                                  opacity: getReverse(_detailAnimation
                                      .applyButtonAnimation.value),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, .001)
                                      ..rotateZ(pi *
                                          .2 *
                                          _detailAnimation
                                              .applyButtonAnimation.value)
                                      ..rotateY(-pi *
                                          .3 *
                                          _detailAnimation
                                              .applyButtonAnimation.value)
                                      ..scale(getReverse(_detailAnimation
                                              .applyButtonAnimation.value)
                                          .clamp(.8, 1)),
                                    child: AnimatedBuilder(
                                        animation: _appliedAnimationController,
                                        builder: (context, child) {
                                          Animation<double> rotateX = Tween<
                                                  double>(begin: 0, end: 1)
                                              .animate(CurvedAnimation(
                                                  parent:
                                                      _appliedAnimationController,
                                                  curve: Curves.easeOut));
                                          return Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.identity()
                                              ..setEntry(3, 2, .001)
                                              ..rotateX(pi * rotateX.value),
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.identity()
                                                ..setEntry(3, 2, .001)
                                                ..rotateX(_applied ? pi : 0),
                                              child: SizedBox(
                                                height: size.HEIGHT * .06,
                                                child: AppButton(
                                                  onTap: () {
                                                    _appliedAnimationController
                                                        .forward();
                                                  },
                                                  text: _applied
                                                      ? "APPLIED"
                                                      : "APPLY",
                                                  width: size.WIDTH * .4,
                                                  color: _applied
                                                      ? AppColors.yellow
                                                      : null,
                                                  textColor: _applied
                                                      ? AppColors.dark
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
