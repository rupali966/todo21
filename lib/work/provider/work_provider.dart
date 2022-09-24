import 'package:flutter/material.dart';

class work_provider extends ChangeNotifier {
  bool multiple_floting = false;

  void change_floting() {
    multiple_floting = !multiple_floting;
    notifyListeners();
  }
}
