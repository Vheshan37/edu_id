import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  static int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void navigate({required int index}) {
    _currentIndex = index;
    notifyListeners();
  }
}
