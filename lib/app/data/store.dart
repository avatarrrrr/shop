import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<void> saveString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setString(key, value);
  }

  static Future<void> saveMap(String key, Map<String, dynamic> value) async =>
      saveString(key, json.encode(value));

  static Future<String?> readString(String key) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getString(key);
  }

  static Future<Map<String, dynamic>?> readMap(String key) async {
    String? dataInJson = await readString(key);
    return dataInJson == null ? null : json.decode(dataInJson);
  }

  static Future<bool> remove(String key) async {
    var storage = await SharedPreferences.getInstance();

    return storage.remove(key);
  }
}
