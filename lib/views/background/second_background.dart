// ignore_for_file: must_be_immutable

import 'package:career_guide/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class SecondBackground extends StatelessWidget {
  AnimationController animationController;
  SecondBackground({super.key, required this.animationController});
  Animation<double> get translation =>
      Tween<double>(begin: 0, end: 1).animate(animationController);

  @override
  Widget build(BuildContext context) {
    animationController.repeat();
    AppSizes size = AppSizes(context);
    final double waveHeight = size.HEIGHT * 2;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: translation.value * (-1) * waveHeight / 4,
              child: Wave(height: waveHeight),
            ),
            Positioned(
              bottom: translation.value * (-1) * waveHeight / 4,
              child: Wave(height: waveHeight),
            ),
            const AnimatedDateList()
          ],
        );
      },
    );
  }
}

class AnimatedDateList extends StatefulWidget {
  const AnimatedDateList({super.key});

  @override
  State<AnimatedDateList> createState() => _AnimatedDateListState();
}

class _AnimatedDateListState extends State<AnimatedDateList> {
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  final ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  int fromTop = 0;
  List<String> items = [];
  final int itemCount = 10;
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  _startAnimation() {
    Future future = Future(() => null);
    for (var i = 0; i < itemCount; i++) {
      future = future.then((value) {
        _addItem(i);
        return Future.delayed(const Duration(milliseconds: 200));
      });
    }
  }

  _addItem(int index) {
    items.add("Item ${index + 1}");
    key.currentState?.insertItem(index);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    double heightRatio = size.HEIGHT * .12;
    int visibleItemCount = 8;
    const Duration duration = Duration(milliseconds: 600);
    goNext() {
      if (itemCount - currentIndex > visibleItemCount) {
        currentIndex++;
        scrollController.animateTo(heightRatio * currentIndex,
            duration: duration, curve: Curves.easeOut);
      } else {
        int value = visibleItemCount - (itemCount - currentIndex) + 1;
        if (value <= (visibleItemCount - 1)) {
          currentIndex++;
          setState(() {
            fromTop = value;
          });
        }
      }
    }

    goBack() {
      if (fromTop > 0) {
        currentIndex--;
        setState(() {
          fromTop -= 1;
        });
      } else {
        if (currentIndex > 0) {
          currentIndex--;
          scrollController.animateTo(heightRatio * currentIndex,
              duration: duration, curve: Curves.linear);
        }
      }
    }

    return SafeArea(
      child: Stack(
        children: [
          AnimatedList(
            key: key,
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index, animation) {
              bool isActive = index % 4 == 0 && currentIndex != index;
              CurvedAnimation curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              );
              return AnimatedBuilder(
                animation: curvedAnimation,
                builder: (context, child) {
                  return Container(
                    // color: Colors.red,
                    // margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.CONTENT_SPACE * 1.5),
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..translate(0.0, -animation.value * (10)),
                    height: heightRatio,
                    child: Row(
                      children: [
                        Opacity(
                          opacity: animation.value,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  items[index],
                                  style: theme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.normal),
                                )),
                          ),
                        ),
                        SizedBox(width: size.CONTENT_SPACE * 1.1),
                        AnimatedSwitcher(
                            duration: duration,
                            child: isActive
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: size.CONTENT_SPACE * 2.5,
                                        width: size.CONTENT_SPACE * 2.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white60),
                                      ),
                                      Container(
                                        height: size.CONTENT_SPACE * .8,
                                        width: size.CONTENT_SPACE * .8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.yellow),
                                      ),
                                    ],
                                  )
                                : const SizedBox())
                      ],
                    ),
                  );
                },
              );
            },
          ),
          AnimatedPositioned(
              duration: duration,
              left: (size.CONTENT_SPACE / 2),
              right: (size.CONTENT_SPACE / 2),
              top: fromTop * (heightRatio),
              height: heightRatio,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.WIDTH * .2,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                          "21",
                          style: theme.displayMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: size.CONTENT_SPACE * .5),
                        Expanded(
                            child: Text(
                          "to responses Ads",
                          overflow: TextOverflow.ellipsis,
                          style: theme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        )),
                      ],
                    )),
                    Container(
                      width: size.WIDTH * .2,
                      margin: EdgeInsets.all(size.CONTENT_SPACE * .5),
                      decoration: BoxDecoration(
                          // color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.yellow, width: 5)),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: goBack,
                                child: const FittedBox(
                                    child:
                                        Icon(Icons.keyboard_arrow_up_rounded)),
                              )),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: goNext,
                                child: const FittedBox(
                                    child: Icon(
                                        Icons.keyboard_arrow_down_rounded)),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class Wave extends StatelessWidget {
  double height;
  Wave({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: height,
        width: size.WIDTH * .25,
        color: Colors.yellow,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double x = size.width;
    double y = size.height;
    int wavenNumber = 15;
    double ratio = y / wavenNumber;
    double min = x / 2;
    double middle = 3 * x / 4;
    double max = x;
    Path path = Path();
    path.lineTo(middle, 0);
    for (var i = 1; i <= wavenNumber; i++) {
      double x1 = i % 2 != 0 ? max : min;
      double y1 = (ratio / 2) * ((2 * i) - 1);
      double x2 = middle;
      double y2 = (ratio) * i;
      path.quadraticBezierTo(x1, y1, x2, y2);
    }
    path.lineTo(0, y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
