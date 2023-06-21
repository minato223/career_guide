// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

class AppSizes {
  BuildContext context;
  late double _height;
  late double _width;
  AppSizes(this.context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
  }

  double get HEIGHT => _height;
  double get WIDTH => _width;
  double get CONTENT_PADDING => _width * 0.1;
  double get AVATAR_RADIUS => _width * .15;
  double get CONTENT_SPACE => _width * .04;
}
