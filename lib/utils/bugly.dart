import 'package:flutter_bugly/flutter_bugly.dart';

class Bugly {
  Bugly._internal();

  static const String BUGLY_APP_ID_ANDROID = "15792a0daa";
  static const String BUGLY_APP_ID_IOS = "15792a0daa";// iOS暂未申请id

  //============================统计==================================//

  ///初始化Bugly
  static void init() {
    FlutterBugly.init(
        androidAppId: BUGLY_APP_ID_ANDROID,
        iOSAppId: BUGLY_APP_ID_IOS)
        .then((_result) {
      print("Bugly初始化结果: " + _result.message);
      print("Bugly初始化结果: ${_result.isSuccess}" );
    });

  }

  //============================更新==================================//

  ///检查更新
  static Future<UpgradeInfo> checkUpgrade() {
    return FlutterBugly.checkUpgrade();
  }

}
