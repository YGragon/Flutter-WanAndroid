import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/api/error_entity.dart';

class DioManager{
  Dio _dio;

  /// 网络请求配置信息
  BaseOptions _getOptions() {
    return BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: Api.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      headers: {
        HttpHeaders.userAgentHeader: "dio",
        "api": "1.0.0",
      },
      //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
  }
  /// 单例
  DioManager._internal() {
    _dio = new Dio(_getOptions());
    var cookieJar= CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));
    _dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志,放在最后一个拦截器
    // Print cookies
    print("cookie===>>>:${cookieJar.loadForRequest(Uri.parse(Api.BASE_URL))}");
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  get dio {
    return _dio;
  }

  /// get请求
  get(url, {data, options, cancelToken, showLoading, hideLoading, success, Function(ErrorEntity) error}) async {
    try {
      showLoading();
      Response response = await dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);
      if (response != null) {
        if(response.statusCode == 200){
          print('get response:${response.data}');
          success(response.data);
        }else{
          error(ErrorEntity(code: -2, message: "未知错误"));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
      hideLoading();
    } on DioError catch(e) {
      /// 格式化输出错误信息
      formatError(e);
      hideLoading();
    }finally{
      hideLoading();
    }
  }

  /// post 请求
  post<T>(url, {data, options, cancelToken, showLoading, hideLoading, Function(T) success, Function(ErrorEntity) error}) async {
    try {
      showLoading();
      Response response = await dio.post(url, queryParameters: data, options: options, cancelToken: cancelToken);
      if (response != null) {
        if(response.statusCode == 200){
          print('post response:${response.data}');
          success(response.data);
        }else{
          error(ErrorEntity(code: -2, message: "未知错误"));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
      hideLoading();
    } on DioError catch (e) {
      formatError(e);
      hideLoading();
    } finally {
      hideLoading();
    }
  }

  /// 下载文件
  downloadFile(urlPath, savePath, progress) async {
    try {
      Response response = await dio.download(urlPath, savePath, onReceiveProgress: (int count, int total){
        //进度
        progress(count,total);
      });
      print('downloadFile data---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    } finally{

    }
  }

  /// error 统一处理
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }


}