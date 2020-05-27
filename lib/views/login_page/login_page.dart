import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/common_service.dart';
import 'package:flutter_wanandroid/model/user.dart';
import 'package:flutter_wanandroid/model/user_model.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/router_path.dart';
import 'package:flutter_wanandroid/utils/toast.dart';
import 'package:flutter_wanandroid/views/register_page/register_page.dart';
import 'package:flutter_wanandroid/widgets/loading/dialog_manager.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState() {
    print("loginPage-constructor");
  }
  final _formKey = GlobalKey<FormState>();
  String _name, _password;
  bool _isObscure = true;
  bool _isLoading = false;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "微信",
      "icon": GroovinMaterialIcons.wechat,
    },
    {
      "title": "QQ",
      "icon": GroovinMaterialIcons.qqchat,
    }
  ];

  bool flag = false; //维护复选框状态


  @override
  Widget build(BuildContext context) {
    print("loginPage-build");
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: _bodyLayout(context));
  }

  Widget _bodyLayout(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildRememberPasswordText(context),
                  buildForgetPasswordText(context),
                ],
              ),

              SizedBox(height: 40.0),
              buildLoginButton(context),
              SizedBox(height: 60.0),
              buildOtherLoginText(),
              buildOtherMethod(context),
              buildRegisterText(context),
            ],
          ));
    }
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO : 第三方登录方法
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("${item['title']}登录"),
                          action: new SnackBarAction(
                            label: "取消",
                            onPressed: () {},
                          ),
                        ));
                      });
                },
              ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  /// 点击登录
  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              DialogManager.showBasicDialog(context, "正在登录中...");
              CommonService().login((UserModel _userModel, Response response) {
                if (_userModel.errorCode == 0) {
                  ToastUtil.showBasicToast("登录成功");
                  print("response：" + response.toString());
                  User().saveUserInfo(_userModel, response);
                  /// 跳转首页
                  Navigator.pushNamedAndRemoveUntil(context, RouterPath.root,ModalRoute.withName('/'));

                } else if (_userModel.errorCode == -1) {
                  ToastUtil.showBasicToast(_userModel.errorMsg);
                  Navigator.pop(context);
                }
              }, _name, _password);
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Padding buildRememberPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: flag,
                  onChanged: (value) {
                    print("value:$value");
                    setState(() {
                      flag = value;
                    });
                  },
                  activeColor: Colors.red, //选中时的颜色
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  flag ? "记住密码" : "不记住密码",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            ToastUtil.showBasicToast("忘记密码");
          },
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
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "用户名",
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入用户名';
        }
      },
      onSaved: (String value) => _name = value,
    );
  }
}
