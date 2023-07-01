import 'package:flutter/cupertino.dart';

class BottomNavigationItem {
  Function() onTap;
  IconData icon;
  BottomNavigationItem({required this.icon, required this.onTap});
}
