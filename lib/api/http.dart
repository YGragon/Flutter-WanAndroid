import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/api/error_entity.dart';

/// 网络请求工具
class Http{
  /// 单例
  Http._internal();

  static final Dio dio = Dio(BaseOptions(
    baseUrl: "https://www.wanandroid.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  ///初始化dio
  static init() {
    ///初始化cookie
    var cookieJar= CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志,放在最后一个拦截器

    /// 添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求之前");
      return options;
    }, onResponse: (Response response) {
      print("响应之前");
      return response;
    }, onError: (DioError e) {
      print("错误之前");
      handleError(e);
      return e;
    }));
  }

  ///error统一处理
  static void handleError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        print("连接超时");
        break;
      case DioErrorType.SEND_TIMEOUT:
        print("请求超时");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        print("响应超时");
        break;
      case DioErrorType.RESPONSE:
        print("出现异常");
        break;
      case DioErrorType.CANCEL:
        print("请求取消");
        break;
      default:
        print("未知错误");
        break;
    }
  }

  /// get请求
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  /// get请求
  static Future getData(url, {data, options, cancelToken, success, Function(ErrorEntity) error}) async {
    try {
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
    } on DioError catch(e) {
      /// 格式化输出错误信息
      handleError(e);
    }finally{
    }
  }

  /// post 表单请求
  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  /// post body请求
  static Future postJson(String url, [Map<String, dynamic> data]) async {
    Response response = await dio.post(url, data: data);
    return response.data;
  }

  /// post 请求
  static Future postData<T>(url, {data, options, cancelToken, Function(T) success, Function(ErrorEntity) error}) async {
    try {
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
    } on DioError catch (e) {
      handleError(e);
    } finally {
    }
  }

  /// 下载文件
  static Future downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
            //进度
            print("$count $total");
          });
    } on DioError catch (e) {
      handleError(e);
    }
    return response.data;
  }
}
