import 'package:career_guide/views/background/second/navigation/navigation.dart';

class NavigationController {
  NavigationState? _state;
  void setState(NavigationState state) => _state = state;
  void get goNext => _state?.goNext();
  void get goBack => _state?.goBack();
}
