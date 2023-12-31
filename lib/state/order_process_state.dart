import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/server_url.dart';

class OrderProcessState extends ChangeNotifier {
  LocalStorage data = LocalStorage('usertoken');
  List<OrderProcess> _orderProcessList = [];

  Future<void> getOrderProcessList() async {
    String url = '$serversite/api/erp-process/';
    var token = data.getItem('token');
    //print('test2');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = jsonDecode(response.body) as Map;
      List<OrderProcess> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderProcess orderprocesslist = OrderProcess.fromJson(element);
          demo.add(orderprocesslist);
        });
        // print('Sucess process data');
        _orderProcessList = demo;
        notifyListeners();
      } else {
        // print("something went wrong from server side error=True");
      }
    } catch (e) {
      // print(e);
      // print("error getorderprocesslists");
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

  OrderProcess singleProcess(String processId) {
    return _orderProcessList
        .firstWhere((element) => element.processId == processId);
  }

  Future<void> updateProcessStatus(
      String processId, double cost, String barcodeLink) async {
    String url = '$serversite/api/update_process/$processId/';
    var token = data.getItem('token');
    try {
      print("update process");

      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'cost': cost,
            'completed': true,
            'barcode_link': barcodeLink,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      print("process updated");

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && !data['error']) {
        print(data["error"]);
        OrderProcess process = _orderProcessList
            .firstWhere((element) => element.id.toString() == processId);
        process.barcodeLink = barcodeLink;
        process.completed = true;
        process.cost = cost;
        notifyListeners();
      } else {
        print("Failed to update process. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error updating process: $e");
    }
  }
}
