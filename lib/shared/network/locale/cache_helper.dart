import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper 
{
  static late SharedPreferences sharedPreferences ;
  static Future<void>  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveDate({
    required String key,
    required dynamic value,
  }) async 
  {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  static  dynamic getDate({@required key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
