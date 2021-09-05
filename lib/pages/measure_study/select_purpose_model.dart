import 'package:flutter/material.dart';

class SelectPurposeModel with ChangeNotifier {
  List<String> _items = ["item1", "item2", "item3"];
  String selectedItem = "item1";

  List<String> get items => _items;

  String get selected => selectedItem;

  void setSelectedItem(String s) {
    selectedItem = s;
    notifyListeners();
  }
  
}