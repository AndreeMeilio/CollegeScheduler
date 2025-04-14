
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAnimationPageUtils {
  static animate({
    required LocalKey key,
    required Widget child,
  }){
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child){

        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.linear);

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      }
    );
  }
}