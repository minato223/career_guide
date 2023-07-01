// ignore_for_file: must_be_immutable

import 'package:career_guide/Utils/number.dart';
import 'package:career_guide/constants/app_sizes.dart';
import 'package:career_guide/views/background/second/animated_date_list/animated_date_list_tile.dart';
import 'package:career_guide/views/background/second/animation_view/animation_view.dart';
import 'package:career_guide/views/background/second/animation_view/animation_view_controller.dart';
import 'package:career_guide/views/background/second/navigation/navigation.dart';
import 'package:flutter/material.dart';

class AnimatedDateList extends StatefulWidget {
  AnimationController secondBackgroundController;
  AnimationController waveAnimationController;
  Animation<double> wavePositionAnimation;

  AnimatedDateList(
      {super.key,
      required this.secondBackgroundController,
      required this.waveAnimationController,
      required this.wavePositionAnimation});

  @override
  State<AnimatedDateList> createState() => _AnimatedDateListState();
}

class _AnimatedDateListState extends State<AnimatedDateList>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  late AnimationController _textController;
  late Animation<double> _navigationScaleAnimation;
  final ScrollController _scrollController = ScrollController();
  final int _visibleItemCount = 8;
  final List<String?> _items = [];
  final int _itemCount = 10;
  final AnimationViewController _animationViewController =
      AnimationViewController();
  Curve curve = Curves.easeOut;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  _setupAnimation() {
    widget.secondBackgroundController.addListener(() {
      if (widget.secondBackgroundController.status ==
          AnimationStatus.completed) {
        _startAnimation();
      }
    });
    widget.secondBackgroundController.addListener(() {
      if (widget.secondBackgroundController.status ==
          AnimationStatus.dismissed) {
        _textController.reverse();
        _animationViewController.dismiss;
        key.currentState!
            .removeAllItems((context, animation) => const SizedBox());
        _items.clear();
      }
    });
    _textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _navigationScaleAnimation = Tween<double>(begin: .8, end: 1.0)
        .animate(CurvedAnimation(parent: _textController, curve: curve));
  }

  _startAnimation() {
    Future future = Future(() => null);
    for (var i = 0; i < (_itemCount + _visibleItemCount); i++) {
      future = future.then((value) {
        if (i < _itemCount) {
          int day = _itemCount - i;
          _addItem(i, "Nov $day");
        } else {
          _addItem(i, null);
        }
        return Future.delayed(const Duration(milliseconds: 100));
      });
    }
    future.then((value) {
      _textController.forward();
      _animationViewController.forward;
    });
  }

  _addItem(int index, String? value) {
    _items.add(value);
    key.currentState?.insertItem(index);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    double heightRatio = size.HEIGHT * .12;
    const Duration duration = Duration(milliseconds: 600);
    goNext() {
      if ((_itemCount + _visibleItemCount - 1) - _currentIndex >
          _visibleItemCount) {
        _currentIndex++;
        _animationViewController.animate;
        _scrollController.animateTo(heightRatio * _currentIndex,
            duration: duration, curve: curve);
        setState(() {});
      }
    }

    goBack() {
      if (_currentIndex > 0) {
        _animationViewController.animate;
        _currentIndex--;
        _scrollController.animateTo(heightRatio * _currentIndex,
            duration: duration, curve: curve);
        setState(() {});
      }
    }

    return SafeArea(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: widget.waveAnimationController,
            builder: (context, child) {
              return Transform.translate(
                  offset: Offset(
                      widget.wavePositionAnimation.value *
                          (-AppSizes(context).WIDTH * .23),
                      0),
                  child: AnimatedList(
                    key: key,
                    controller: _scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      bool isActive = index % 4 == 0 && _currentIndex != index;
                      CurvedAnimation curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: curve,
                      );
                      return AnimatedBuilder(
                        animation: curvedAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity:
                                getReverse(widget.wavePositionAnimation.value),
                            child: AnimatedDateListTile(
                                animation: animation,
                                currentIndex: _currentIndex,
                                duration: duration,
                                heightRatio: heightRatio,
                                index: index,
                                isActive: isActive,
                                text: _items[index]),
                          );
                        },
                      );
                    },
                  ));
            },
          ),
          AnimatedBuilder(
            animation: _textController,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, .001)
                  ..scale(1.0, _navigationScaleAnimation.value),
                child: Opacity(
                  opacity: _textController.value,
                  child: Navigation(
                      goBack: goBack, goNext: goNext, heightRatio: heightRatio),
                ),
              );
            },
          ),
          Positioned(
            top: heightRatio * 1.2,
            right: size.WIDTH * .02,
            height: size.HEIGHT - (heightRatio * 2),
            width: size.WIDTH * .7,
            child: AnimationView(
              controller: _animationViewController,
            ),
          )
        ],
      ),
    );
  }
}
