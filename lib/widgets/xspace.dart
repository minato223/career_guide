// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';

class XSpace {
  double? value;
  XSpace([this.value]);
  Widget get x => SizedBox(width: value);
  Widget get y => SizedBox(height: value);
}
