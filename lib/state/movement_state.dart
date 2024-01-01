import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/server_url.dart';

class MovementState extends ChangeNotifier {
  LocalStorage data = LocalStorage('usertoken');
  List<ErpOrderMovement> _movementList = [];

  Future<void> getMovementList() async {
    String url = '$serversite/api/erp-movement/';
    var token = data.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<ErpOrderMovement> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          ErpOrderMovement movementList = ErpOrderMovement.fromJson(element);
          demo.add(movementList);
        });
        print('Sucess process data');
        _movementList = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error getorderprocesslists");
    }
  }

  ErpOrderMovement singleMovement(String movementId) {
    return _movementList
        .firstWhere((element) => element.movementId == movementId);
  }

  List<ErpOrderMovement> get movementList {
    return _movementList;
  }

  List<ErpOrderMovement> get movementCompletedList {
    return _movementList.where((element) => element.completed == true).toList();
  }

  List<ErpOrderMovement> get movementNotStartedList {
    return _movementList
        .where(
            (element) => element.picked == false && element.completed == false)
        .toList();
  }

  List<ErpOrderMovement> get movementStartedList {
    return _movementList.where((element) => element.picked == true).toList();
  }
}
