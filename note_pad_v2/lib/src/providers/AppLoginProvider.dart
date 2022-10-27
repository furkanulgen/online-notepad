import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLoginProvider with ChangeNotifier{
  bool isLogin = false;
  String username = "";

  setLoginStatus(bool _i){
    isLogin = _i;
    notifyListeners();
  }
  setUserName(String _i){
    username = _i;
    notifyListeners();
  }

  bool get getLoginStatus => isLogin;
  String get getUserName => username;

}