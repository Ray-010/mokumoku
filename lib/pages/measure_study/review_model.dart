import 'package:flutter/cupertino.dart';

class ReviewModel extends ChangeNotifier {
  bool great = true;
  bool good = false;
  bool fine = false;
  bool bad = false;

  void checkedGreat() {
    great = true;
    good = false;
    fine = false;
    bad = false;
    notifyListeners();
  }
  void checkedGood() {
    great = false;
    good = true;
    fine = false;
    bad = false;
    notifyListeners();
  }
  void checkedFine() {
    great = false;
    good = false;
    fine = true;
    bad = false;
    notifyListeners();
  }
  void checkedBad() {
    great = false;
    good = false;
    fine = false;
    bad = true;
    notifyListeners();
  }
}