import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/model/user_model.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static final User singleton = User._internal();

  factory User() {
    return singleton;
  }

  User._internal();

  List<String> cookie;
  String userName;
  bool isLogin = false;

  void setLogin(bool login) {
    this.isLogin = login;
  }

  bool isUserLogin() {
    return isLogin;
  }

  void saveUserInfo(UserModel _userModel, Response response) {
    List<String> cookies = response.headers["set-cookie"];
    cookie = cookies;
    userName = _userModel.data.username;
    _saveInfo();
  }

  Future<Null> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cookies = sp.getStringList("cookies");
    if (cookies != null) {
      cookie = cookies;
    }
    String username = sp.getString("username");
    if (username != null) {
      userName = username;
    }
  }

  _saveInfo() async {
    print("登录成功，保存用户信息：" + userName);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", cookie);
    sp.setString("username", userName);
  }

  /// sp 保存用户名
  void saveUserName(UserModel _userModel) {
    SpUtil.getInstance().then((_sp) {
      _sp.putString(SharedPreferencesKeys.userName, _userModel.data.username);
    });
  }

  /// 获取用户名
//  String getUserName() {
//    String username = "";
//    SpUtil.getInstance().then((_sp) {
//      username = _sp.getString(SharedPreferencesKeys.userName);
//      print("用户username：" + username.toString());
//      if (username != null && username.isNotEmpty) {
//        _setLogin(true);
//      } else {
//        _setLogin(false);
//      }
//    });
//    print("用户username--->：" + username.toString());
//    return username;
//  }

  void clearUserInfor() {
    cookie = null;
    userName = null;
    _clearInfo();
  }

  _clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", null);
    sp.setString("username", null);
  }
}
