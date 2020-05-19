package com.example.flutterwanandroid

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.net.Uri
import android.util.Log
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
  private val TAG = MainActivity::class.java.simpleName
  private val CHANNEL = "com.flutter.method.channel"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      when(call.method){
        "getBatteryLevel" ->{
          val batteryLevel = getBatteryLevel()
          if (batteryLevel != -1) {
            result.success(batteryLevel)
          }else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
          }
        }
        "openAppStore" ->{
          try {
            var appId = ""
            var packageName = "com.tencent.mm"
            if (call.hasArgument("appId")){
              appId = call.argument<String>("appId").toString()
              Log.e(TAG,"appId: $appId")
            }
            if (call.hasArgument("packageName")){
              packageName = call.argument<String>("packageName").toString()
              Log.e(TAG,"packageName: $packageName")
            }
            val uri = Uri.parse("market://details?id=$packageName")
            val intent = Intent(Intent.ACTION_VIEW, uri)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
          } catch (e: Exception) {
            result.error("UNAVAILABLE", "没有安装应用市场", null)
          }
        }
        else ->{
          result.notImplemented()
        }
      }
    }
  }
  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
    batteryLevel = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    } else {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }

    return batteryLevel
  }
}
