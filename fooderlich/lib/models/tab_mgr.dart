import 'package:flutter/material.dart';

// 1
class TabManager extends ChangeNotifier {
  // 2 keeps track of the tab
  int selectedTab = 0;

  // 3 to modify current tab index
  void goToTab(index) {
    // 4 index of the new tab stored
    selectedTab = index;

    // 5 to notify all widgets listening to this state!
    notifyListeners();
  }

  // 6 sets selected tab to recipes tab which is at index 1
  void goToRecipes() {
    selectedTab = 1;
    // 7
    notifyListeners();
  }
}
