import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;

  init({required BuildContext context}) {
    this.context = context;
  }

  void isLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
