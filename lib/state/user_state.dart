import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:staff_flutter_app/server_url.dart';

class UserState extends ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');

  Future<bool> loginNow(String uname, String passw) async {
    String url = '$serversite/api/login/';
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": uname, "password": passw}));
      var data = json.decode(response.body) as Map;

      if (data.containsKey("token")) {
        storage.setItem("token", data['token']);
        print(storage.getItem('token'));
        return true;
      }
      return false;
    } catch (e) {
      print("error login");
      print(e);
      return false;
    }
  }

  Future<bool> registernow(String uname, String passw) async {
    String url = '$serversite/api/register/';
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": uname, "password": passw}));
      var data = json.decode(response.body) as Map;
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("e loginNow register");
      print(e);
      return false;
    }
  }
}
