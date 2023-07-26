import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String? productCode;

  void setProductCode(code) {
    productCode = code;
    notifyListeners();
  }
}