package com.example.kunn.loanflutter;

import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {

  static final String channelName = "com.example.kunn/plateform";

  static final String TAG = "MainActivity";

  static final String platform_method_show_tip = "showTip";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    initMethodChannel();
    GeneratedPluginRegistrant.registerWith(this);

  }

  private void initMethodChannel() {
    MethodChannel  methodChannel = new MethodChannel(getFlutterView(),channelName);
    if(methodChannel!=null){
      methodChannel.setMethodCallHandler(this);
    }

  }

  @Override
  public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
    switch (methodCall.method){
      case platform_method_show_tip:
        int  longth = methodCall.argument("length");
        String msg = methodCall.argument("tipMsg");
        Log.d(TAG,methodCall.method + ";"+ methodCall.arguments.toString());
        new PlateformMethod().tip(MainActivity.this,msg,longth);
        break;
      default:
        new PlateformMethod().tip(MainActivity.this,"method not imp", Toast.LENGTH_SHORT);
    }
  }
}
