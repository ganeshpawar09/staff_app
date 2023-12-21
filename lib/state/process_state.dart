import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/server_url.dart';

class ProcessState extends ChangeNotifier {
  LocalStorage data = LocalStorage('usertoken');
  List<OrderProcess> _orderProcessList = [];

  Future<void> getOderProcessList() async {
    String url = '$serversite/api/erp-process/';  
    var token = data.getItem('token');
    //print('test2');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<OrderProcess> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderProcess orderprocesslist = OrderProcess.fromJson(element);
          demo.add(orderprocesslist);
        });
        print('Sucess process data');
        _orderProcessList = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error getorderprocesslists");
    }
  }

  List<OrderProcess> get orderProcessList {
    return _orderProcessList;
  }

  List<OrderProcess> get orderProcessCompletedList {
    return _orderProcessList
        .where((element) => element.completed == true)
        .toList();
  }

  List<OrderProcess> get orderProcessPendingList {
    return _orderProcessList
        .where((element) => element.completed == false)
        .toList();
  }

  OrderProcess singleProcess(int id) {
    print('id');
    return _orderProcessList.firstWhere((element) => element.id == id);
  }

  Future<http.Response?> updateProcessStatus(
      int id, int val1, String val2) async {
    String url = '$serversite/api/update_process/$id/';
    var token = data.getItem('token');
    print("update process");
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            'cost': val1,
            'completed': true,
            'barcode_link': val2,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      // var data = json.decode(response.body);
      //getRFQlists();
      return response;
    } catch (e) {
      print("e favoritButton");
    }
    print('End of future');
    return null;
  }
}
