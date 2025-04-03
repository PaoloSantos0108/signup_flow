import 'package:flutter/material.dart';
import 'package:signup_flow/widgets/mobile_frame.dart';

class NavigationHelper {
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFF303030),
          body: MobileFrame(
            child: screen,
          ),
        ),
      ),
    );
  }

  static void navigateToReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFF303030),
          body: MobileFrame(
            child: screen,
          ),
        ),
      ),
    );
  }
}

