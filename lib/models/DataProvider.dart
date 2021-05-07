import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  String name;
  void endDate(var value) {
    end = value;
    notifyListeners();
  }

  void startDate(var value) {
    start = value;
    notifyListeners();
  }

  void fullName(var fullname) {
    name = fullname;
    notifyListeners();
  }
}
