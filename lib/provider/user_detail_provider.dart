import 'package:crash_course/modules/user.dart';
import 'package:flutter/material.dart';

class UserDetailProvider extends ChangeNotifier {
  late User userDetails;

  void addUser(User user) {
    userDetails = user;
    notifyListeners();
  }
}
