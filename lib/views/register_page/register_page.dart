import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/user_model.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';
import 'package:flutter_wanandroid/widgets/loading/loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name, _password, _repassword;
  bool _isObscure = true;
  bool _isLoading = true;
  Color _eyeColor;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('注册'),
        ),
        body:_bodyLayout(context));
  }

Widget _bodyLayout(BuildContext context){
    if(_isLoading){
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    }else{
      return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(height: 50.0),
              buildNameTextField(),
              SizedBox(height: 30.0),
              buildPasswordTextField(context),
              SizedBox(height: 30.0),
              buildRePasswordTextField(context),
              SizedBox(height: 60.0),
              buildRegisterButton(context),
              SizedBox(height: 30.0),
            ],
          ));
    }
}

  Align buildRegisterButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              DialogManager.showBasicDialog(context, "正在注册中...");
              CommonService().register((UserModel _userModel){
                if(_userModel.errorCode == -1){
                  ToastUtil.showBasicToast(_userModel.errorMsg);
                  /// 关闭弹窗
                  Navigator.pop(context);
                  /// 关闭登录页面
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pop(context);
                  });
                }else if(_userModel.errorCode == 0){
                  ToastUtil.showBasicToast("注册成功，准备登录吧~");
                  Navigator.pop(context);
                }
              }, _name, _password,_repassword);
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }


  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: '输入密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                // 控制是否显示密码
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildRePasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _repassword = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请再次输入密码';
        }
        if (_password != _repassword) {
          return '两次密码输入不一致';
        }
      },
      decoration: InputDecoration(
          labelText: '确认密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                // 控制是否显示密码
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildNameTextField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "用户名",),
      validator: (String value){
        if(value.length < 3 || value.length > 10){
          return '请输入3-10位字符长度的用户名';
        }
      },
      onSaved: (String value) => _name = value,
    );
  }

}