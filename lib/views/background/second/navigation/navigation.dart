// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_colors.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/second/navigation/navigation_controller.dart';
import 'package:career_guide/widgets/animated_text.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  double heightRatio;
  int itemCount;
  Animation<double> titleAnimation;
  Animation<double> subtitleAnimation;
  Animation<double> titleScaleAnimation;
  NavigationController? navigationController;

  Function() goBack;
  Function() goNext;
  Navigation(
      {super.key,
      required this.goBack,
      required this.goNext,
      required this.titleAnimation,
      required this.subtitleAnimation,
      required this.titleScaleAnimation,
      required this.heightRatio,
      required this.itemCount,
      this.navigationController});

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  final ScrollController _titleScrollController = ScrollController();
  final ScrollController _subtitleScrollController = ScrollController();
  final Duration _duration = const Duration(milliseconds: 600);
  final Curve _curve = Curves.easeOut;
  int _currentIndex = 0;
  late double heightRatio;

  @override
  void initState() {
    super.initState();
    widget.navigationController?.setState(this);
    heightRatio = widget.heightRatio * .7;
  }

  @override
  void dispose() {
    _titleScrollController.dispose();
    _subtitleScrollController.dispose();
    super.dispose();
  }

  goNext() {
    _currentIndex++;
    scroll();
  }

  goBack() {
    _currentIndex--;
    scroll();
  }

  scroll() {
    _titleScrollController.animateTo(heightRatio * _currentIndex,
        duration: _duration, curve: _curve);
    Future.delayed(const Duration(milliseconds: 50), () {
      _subtitleScrollController.animateTo(heightRatio * _currentIndex,
          duration: _duration, curve: _curve);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    double widthRatio = size.WIDTH * .15;
    Widget getTitleChild(int index) {
      return Center(
          child: Transform.scale(
        scale: widget.titleScaleAnimation.value,
        child: Opacity(
          opacity: widget.titleAnimation.value,
          child: AnimatedOpacity(
            curve: _curve,
            duration: _duration,
            opacity: _currentIndex == index ? 1 : 0,
            child: Text(
              "${index + 15}",
              style: theme.displayMedium!
                  .copyWith(fontWeight: FontWeight.w500, color: AppColors.dark),
            ),
          ),
        ),
      ));
    }

    Widget getSubTitleChild(int index) {
      return AnimatedOpacity(
        curve: _curve,
        duration: _duration,
        opacity: _currentIndex == index ? 1 : 0,
        child: AnimatedText(
          animation: widget.subtitleAnimation,
          text: "to responses Ads",
          style: theme.titleLarge!
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.dark),
        ),
      );
    }

    return Container(
      height: widget.heightRatio,
      decoration: BoxDecoration(
          color: Colors.white60, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          SizedBox(
            width: size.WIDTH * .2,
          ),
          Expanded(
              child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: heightRatio,
                width: widthRatio,
                child: CustomAnimatedListView(
                    controller: _titleScrollController,
                    getChild: getTitleChild,
                    heightRatio: heightRatio,
                    widthRatio: widthRatio,
                    itemCount: widget.itemCount),
              ),
              SizedBox(width: size.CONTENT_SPACE * .5),
              Expanded(
                  child: SizedBox(
                height: heightRatio,
                child: CustomAnimatedListView(
                  controller: _subtitleScrollController,
                  itemCount: widget.itemCount,
                  getChild: getSubTitleChild,
                  heightRatio: heightRatio,
                ),
              )),
            ],
          )),
          Container(
            width: size.WIDTH * .2,
            margin: EdgeInsets.all(size.CONTENT_SPACE * .5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.yellow, width: 5)),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: widget.goBack,
                      child: const FittedBox(
                          child: Icon(Icons.keyboard_arrow_up_rounded)),
                    )),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: widget.goNext,
                      child: const FittedBox(
                          child: Icon(Icons.keyboard_arrow_down_rounded)),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomAnimatedListView extends StatelessWidget {
  ScrollController controller;
  int itemCount;
  Widget Function(int index) getChild;
  double heightRatio;
  double? widthRatio;
  CustomAnimatedListView(
      {super.key,
      required this.controller,
      required this.getChild,
      required this.itemCount,
      required this.heightRatio,
      this.widthRatio});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(itemCount, (index) {
        return Container(
            alignment: Alignment.center,
            height: heightRatio,
            width: widthRatio,
            child: getChild(index));
      }),
    );
  }
}

// ListView(
//       controller: _titleScrollController,
//       physics: const NeverScrollableScrollPhysics(),
//       children: List.generate(widget.itemCount, (index) {
