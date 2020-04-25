import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimationTestPage extends StatefulWidget {
  @override
  _AnimationTestPageState createState() {
    return _AnimationTestPageState();
  }
}

String mContext = '';
  const platform = const MethodChannel('com.flutter.method.channel');
class _AnimationTestPageState extends State<AnimationTestPage> {
// Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MethodChannel"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                child: Text('MethodChannel'),
                onPressed: () {
                  _getBatteryLevel();
                },
              ),
              new Text(_batteryLevel),
              RaisedButton(
                child: Text('打开应用商店'),
                onPressed: () {
                  _openMarket();
                },
              ),
            ],
          ),
        ));
  }

  Future _openMarket() async {
    try {
      final int result = await platform.invokeMethod('openAppStore',<String, dynamic>{
        'appId': "123456",
        'packageName': "com.meizu.mstore",
      });

      print("result:$result");
    } on PlatformException catch (e) {
      print("result:${e.message}");
    }
  }
}

class Student {
  String id;
  String name;
  int score;

  Student({
    this.id,
    this.name,
    this.score,
  });
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }
}
