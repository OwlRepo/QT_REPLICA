import 'package:flutter/material.dart';

class WidgetHelper with ChangeNotifier {


  //BOTTOM NAV BAR HELPER
  int _currentIndexBottomNav = 1;

  int get currentIndexBottomNav => _currentIndexBottomNav;

  set currentIndex(int value) {
    _currentIndexBottomNav = value;
    notifyListeners();
  }

  //MIC ANIMATION HELPER
  String _micButtonAnimation = 'Normal';

  String get micButtonAnimation => _micButtonAnimation;

  set micButtonAnimation(String value){
    _micButtonAnimation = value;
    notifyListeners();
  }
  //MEMBER SELECTION HELPER
  String _selectedMember = 'Member 1';

  String get selectedMember => _selectedMember;

  set selectedMember(String value){
    _selectedMember = value;
    notifyListeners();
  }
}
