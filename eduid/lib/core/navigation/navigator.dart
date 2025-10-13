import 'package:flutter/material.dart';

class AppNavigator {
  static void pushAndReplace(BuildContext context, Widget widget) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => widget));
  }

  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }
}
