// custom animation for the app
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAnimation extends StateNotifier<bool> {
  CustomAnimation() : super(false);
  var begin = const Offset(1.0, 1.0); // Bottom right corner
  var end = Offset.zero; // Top left corner
  var curve = Curves.ease; // Ease in-out
  void navigateWithCustomAnimation(BuildContext context, Widget destination) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 700), // 0.7 seconds
    ));
  }
}

final customAnimationProvider =
    StateNotifierProvider<CustomAnimation, bool>((ref) => CustomAnimation());
