import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/widgets/loading/loading_dialog.dart';

/// 弹窗管理组件
class DialogManager{
  static void showBasicDialog(BuildContext context, String msg){
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog( //调用对话框
            text: msg,
          );
        });
  }
}