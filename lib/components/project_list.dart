import 'package:flutter/material.dart';

/// 项目列表

class ProjectListPage extends StatefulWidget{

  final int id;
  final String title;

  ProjectListPage(this.id, this.title);

  @override
  State<StatefulWidget> createState() {
    return new ProjectListPageState();
  }

}

class ProjectListPageState extends State<ProjectListPage> {
  @override
  Widget build(BuildContext context) {
    return Text("项目列表");
  }
}