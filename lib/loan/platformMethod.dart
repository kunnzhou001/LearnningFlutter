import 'package:flutter/services.dart';
import 'dart:async';

class LocalPlatformMethod {
  static const String channelName = "com.example.kunn/plateform";
  static const String platform_method_show_tip = "showTip";
  static const platform = const MethodChannel(channelName);
  static const int LENGTH_LONG = 1;
  static const int LENGTH_SHORT = 0;

  static Future<Null> showTip(int length, String msg) async {
    try {
      await platform.invokeMethod(platform_method_show_tip,
          <String, dynamic>{'tipMsg': msg, 'length': length});
    } on PlatformException catch (e) {
      print("平台方法未实现，错误信息${e.message}");
    }
  }
}
