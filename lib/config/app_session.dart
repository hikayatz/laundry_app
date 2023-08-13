import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AppSession {
  static Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user == null) return null;
    var userMap = jsonDecode(user);
    return UserModel.fromJson(userMap);
  }

  static Future<bool> setUser(Map userMap) async {
    final pref = await SharedPreferences.getInstance();
    String userString = jsonEncode(userMap);
    bool success = await pref.setString('user', userString);
    return success;
  }

  static Future<bool> removeUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    return success;
  }

  static Future<String?> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    return token;
  }

  static Future<bool> setBearerToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString("token", token);
  }

  static Future<bool> removeBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    return await pref.remove("token");
  }
}
