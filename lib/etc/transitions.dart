import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadePageTransitionsBuilder extends PageTransitionsBuilder {
  /// Constructs a page transition animation that slides the page up.
  const FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double>? secondaryAnimation,
      Widget child,
      ) {
    return _FadePageTransition(routeAnimation: animation, child: child);
  }
}

class _FadePageTransition extends StatelessWidget {
  _FadePageTransition({
    required Animation<double> routeAnimation, // The route's linear 0.0 - 1.0 animation.
    required this.child,
  }) : _positionAnimation = routeAnimation.drive(_centerTween.chain(_fastOutSlowInTween)),
        _opacityAnimation = routeAnimation.drive(_animation);

  // Fractional offset from 1/4 screen below the top to fully on screen.
  static final Tween<Offset> _centerTween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );
  static final Animatable<double> _fastOutSlowInTween = CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _animation = CurveTween(curve: Curves.easeInOutCubic);

  final Animation<Offset> _positionAnimation;
  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: FadeTransition(opacity: _opacityAnimation, child: child),
    );
  }
}