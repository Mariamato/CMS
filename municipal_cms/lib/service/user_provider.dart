import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late String _userRole;

  String get userRole => _userRole;

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }
}
