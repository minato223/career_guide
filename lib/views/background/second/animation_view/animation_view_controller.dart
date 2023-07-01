import 'package:career_guide/views/background/second/animation_view/animation_view.dart';

class AnimationViewController {
  AnimationViewState? _state;
  void get animate => _state?.animate();
  void get forward => _state?.forward();
  void get dismiss => _state?.dismiss();
  void setState(AnimationViewState? state) => _state = state;
}
