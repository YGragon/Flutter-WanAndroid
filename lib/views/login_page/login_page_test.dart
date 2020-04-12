import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class AnimationTestPage extends StatefulWidget {
  @override
  _AnimationTestPageState createState() {
    return _AnimationTestPageState();
  }
}

Database dataBase;

StringBuffer sb = new StringBuffer();
String mContext = '';

Future<void> initDataBase() async {
  dataBase = await openDatabase(
    join(await getDatabasesPath(), 'students_database.db'),
    onCreate: (db, version) => db.execute(
        "CREATE TABLE students(id TEXT PRIMARY KEY, name TEXT, score INTEGER)"),
    onUpgrade: (db, oldVersion, newVersion) {
      //dosth for migration
      print("old:$oldVersion,new:$newVersion");
    },
    version: 1,
  );
  print("database:$dataBase");
}

Future<void> insertStudent(Student std) async {
  print("database1:${dataBase.path}");
  await dataBase.insert(
    'students',
    std.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Student>> students() async {
  final List<Map<String, dynamic>> maps = await dataBase.query('students');
  return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
}

insertData() async {
  var student1 = Student(id: '0', name: '张三', score: 90);
  var student2 = Student(id: '1', name: '李四', score: 80);
  var student3 = Student(id: '2', name: '王五', score: 85);

  // Insert a dog into the database.
  await insertStudent(student1);
  await insertStudent(student2);
  await insertStudent(student3);
}


class _AnimationTestPageState extends State<AnimationTestPage> {
  @override
  void initState() {
    initDataBase();
    super.initState();
  }

  @override
  void dispose() {
    dataBase.close();
    super.dispose();
  }

  getStudents() async {
    await students()
        .then((list) => list.forEach((s) => sb.writeln(s.toJson().toString())));
    setState(() {
      mContext = sb.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Database"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                child: Text('写入数据'),
                onPressed: () {
                  insertData();
                },
              ),
              RaisedButton(
                child: Text('读取数据'),
                onPressed: () {
                  getStudents();
                },
              ),
              Text("读取出来的数据：$mContext")
            ],
          ),
        ));
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
