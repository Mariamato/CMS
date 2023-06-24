

import 'package:flutter/foundation.dart';

class visibility extends ChangeNotifier {
  bool hidePassword = false;

  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
}
