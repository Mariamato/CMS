import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  try {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("token");
  } catch (e) {
    print('Error getting token: $e');
    return null;
  }
}

Future<int?> getUserId() async {
  try {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("userId");
  } catch (e) {
    print('Error getting user ID: $e');
    return null;
  }
}

Future<String?> getName() async {
  try {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("name");
  } catch (e) {
    print('Error getting name: $e');
    return null;
  }
}

Future<String?> getEmail() async {
  try {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("email");
  } catch (e) {
    print('Error getting email: $e');
    return null;
  }
}

Future<String?> getPhone() async {
  try {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("phone");
  } catch (e) {
    print('Error getting phone: $e');
    return null;
  }
}
