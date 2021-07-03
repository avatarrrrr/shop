import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///Grava/lê dados no armazenamento local.
class Store {
  ///Grava uma string no armazenamento local.
  static Future<void> saveString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();

    storage.setString(key, value);
  }

  ///Grava um map no armazenamento local como um json.
  static Future<void> saveMap(String key, Map<String, dynamic> value) async =>
      saveString(key, json.encode(value));

  ///Lê uma string no armazenamento local.
  static Future<String> readString(String key) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getString(key);
  }

  ///Lê um map no armazenamento local.
  static Future<Map<String, dynamic>> readMap(String key) async {
    var dataInJson = await readString(key);
    return json.decode(dataInJson);
  }

  ///Remove um valor do armazenamento local.
  static Future<bool> remove(String key) async {
    var storage = await SharedPreferences.getInstance();

    return storage.remove(key);
  }
}
