//enum DateType {
//  Int,
//  Double,
//  Bool,
//  String,
//  Dynamic
//}

//class spKey {
//  String name;
//  DateType type;
//
//  spKey({this.name, this.type});
//}

class SharedPreferencesKeys {
  /// boolean
  /// 用于欢迎页面. 只有第一次访问才会显示. 或者手动将这个值设为false
  static String showWelcome = 'loginWelcone';
  /// json
  /// 用于存放搜索页的搜索数据.
  /// [{
  ///  name: 'name'
  ///
  /// }]
  static String searchHistory = 'searchHistory';
  static String userName = 'userName';

  static String splash_date = "key_splash_date";
  static String splash_image = "key_splash_image";
}

