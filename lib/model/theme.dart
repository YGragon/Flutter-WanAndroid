import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/shared_preferences.dart';

/// provider 主题修改

class AppTheme with ChangeNotifier{

  static final List<MaterialColor> materialColors = [
    Colors.blue,
    Colors.lightBlue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.grey,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lime
  ];

  MaterialColor _mThemeColor;
  AppTheme(this._mThemeColor);

//  defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme :kAndroidTheme,
  MaterialColor get themeColor => _mThemeColor ;

  // 根据 Platform 设置主题
  ThemeData get themeDate => defaultTargetPlatform == TargetPlatform.iOS ? getIOSTheme() :getAndroidTheme();
  // iOS浅色主题
  ThemeData getIOSTheme(){
    return ThemeData(
      primarySwatch: getDefaultTheme(),
      buttonColor: getDefaultTheme(),
      brightness: Brightness.dark,
      //深色主题
      accentColor: Color(0xFF888888)
    );
  }
  ThemeData getAndroidTheme(){
    return ThemeData(
        primarySwatch: getDefaultTheme(),
        buttonColor: getDefaultTheme(),
        brightness: Brightness.light,
        //亮色主题
        accentColor: Color(0xFF888888)
    );
  }



  /// 获取默认主题
  static MaterialColor getDefaultTheme() {
    return materialColors[SPUtils.getThemeColorIndex()];
  }


  /// 修改主题颜色
  void changeTheme(int colorIndex){
    _mThemeColor = materialColors[colorIndex];
    /// 保存主题索引值
    SPUtils.saveThemeColorIndex(colorIndex);
    notifyListeners();
  }
}