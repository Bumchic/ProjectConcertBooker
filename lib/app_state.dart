import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isAdminMode = false;

  void toggleAdminMode(){
    isAdminMode = !isAdminMode;
    notifyListeners();
  }
}