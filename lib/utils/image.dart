import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageUtil{

  static showBasicImage(String url){
    ExtendedImage.network(
      url,
      fit: BoxFit.fill,
    );
  }

  static showCircleImage(String url,){
    ExtendedImage.network(
      url,
      width: ScreenUtil().setWidth(400),
      height: ScreenUtil().setWidth(400),
      fit: BoxFit.fill,
      cache: true,
      border: Border.all(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      //cancelToken: cancellationToken,
    );
  }
}