import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:municipal_cms/models/user.dart';
import 'package:municipal_cms/service/dio.dart';

class Auth extends ChangeNotifier {
  bool _isRegisted = false;
  bool _isLoggedin = false;
  late User _user;
  late String _token;
  bool get authenticated => _isLoggedin;
  User get user => _user;

  void login({required Map creds}) async {
     void login({required Map creds}) async {
    try {
      Dio.Response responce = await dio().post('login', data: creds);
      print(responce.data.toString());

      String token = responce.data.toString();
      this.tryToken(token: token);
      
    } catch (e) {
      print(e);
    }
  }
  }



  void register({required Map creds}) {
    _isRegisted = false;

    notifyListeners();
  }

  void tryToken({required String token}) async {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      try {
        Dio.Response responce = await dio().get('/user',
            options: Dio.Options(headers: {'Authorization': 'bearer $token'}));
        this._isLoggedin = true;
        this._user = User.fromJson(responce.data);
        notifyListeners();
        print(_user);
      } catch (e) {
        print(e);
      };
    }
  }
}
