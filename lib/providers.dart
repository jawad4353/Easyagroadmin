



import 'package:flutter/foundation.dart';

class ValueProvider extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  set value(int newValue) {
    _value = newValue;
    notifyListeners();
  }

// Define your provider properties and methods here
}
