import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;



class Provider {
  static Database db;

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item)  {
      targetList.add(item['name']);
    });
    print("所有表格："+targetList.toString());
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['collection'];

    List<String> tables = await getTables();

    for(int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;

  }

  //初始化数据库

  Future init(bool isCreate) async {
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter.db');
    print("数据库的路径："+path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("错误信息  Error $e");
    }
    bool tableIsRight = await this.checkTableIsRight();

    print("表格是否存在："+tableIsRight.toString());
    if (!tableIsRight) {
      // 关闭上面打开的db，否则无法执行open
      db.close();
      // Delete the database
      await deleteDatabase(path);
      ByteData data = await rootBundle.load(join("assets", "app.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await new File(path).writeAsBytes(bytes);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            print('数据库的版本号：db created version is $version');
          }, onOpen: (Database db) async {
            print('新的数据库：new db opened');
          });
    } else {
      print("打开旧的数据库：Opening existing database");
    }
  }

}
