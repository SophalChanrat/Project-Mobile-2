import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Animationutils {
  static const int animationSpeed = 500;

  static CustomTransitionPage rightToLeft(Widget screen) {
    return createAnimation(screen, const Offset(1, 0), const Offset(0, 0));
  }

  static CustomTransitionPage leftToRight(Widget screen) {
    return createAnimation(screen, const Offset(-1, 0), Offset.zero);
  }

  static CustomTransitionPage bottomToTop(Widget screen) {
    return createAnimation(screen, const Offset(0, 1.2), Offset.zero);
  }

  static Widget fadeSlideTransition(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: Offset(0.3, 0), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      ),
    );
  }

  static CustomTransitionPage<T> createAnimation<T>(
    Widget screen,
    Offset begin,
    Offset end,
  ) {
    return CustomTransitionPage<T>(
      transitionDuration: Duration(milliseconds: animationSpeed),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: Curves.easeOutBack));

        final fadeTween = Tween(begin: 0.0, end: 1.0);

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          ),
        );
      },
    );
  }

  static Route<T> createScalePopupRoute<T>(Widget popup) {
    return PageRouteBuilder<T>(
      opaque: false,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: animationSpeed),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(child: popup),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleTween = Tween(
          begin: 0.85,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOutBack));

        final fadeTween = Tween(begin: 0.0, end: 1.0);

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }
}
