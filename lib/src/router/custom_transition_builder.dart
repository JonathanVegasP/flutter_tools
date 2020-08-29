import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (kIsWeb) {
      return child;
    }
    if (animation.isCompleted && secondaryAnimation.isDismissed) {
      return child;
    }
    final primary = CurvedAnimation(
        parent: animation,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.ease);
    final secondary = CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.easeInToLinear);
    final fade = primary.status == AnimationStatus.forward
        ? const AlwaysStoppedAnimation(1.0)
        : primary;
    final text = Directionality.of(context);
    return SlideTransition(
      textDirection: text,
      transformHitTests: false,
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-1.0 / 3.0, 0.0),
      ).animate(secondary),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(primary),
        child: FadeTransition(
          opacity: fade,
          child: Material(
            color: Colors.transparent,
            elevation: 10.0,
            child: child,
          ),
        ),
      ),
    );
  }
}
