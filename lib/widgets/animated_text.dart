// ignore_for_file: must_be_immutable

import 'package:career_guide/Utils/number.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final Animation<double> animation;
  final String text;
  final TextStyle? style;
  bool withScale;

  AnimatedText({
    super.key,
    required this.animation,
    required this.text,
    this.withScale = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final int textLength = text.length;
        final double ratio = 1 / textLength;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(textLength, (index) {
            double opacity = 0;
            if (animation.value - (index * ratio) > 0) {
              opacity = animation.value;
            }
            final Widget letterWidget = Opacity(
              opacity: opacity,
              child: Text(
                text[index],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: style,
              ),
            );

            return letterWidget;
          }),
        );
      },
    );
  }
}
