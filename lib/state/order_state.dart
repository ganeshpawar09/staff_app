import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/server_url.dart';
import 'package:staff_flutter_app/models/combine_data.dart';

class OrderState extends ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');

  List<ErpOrder> _erpOrders = [];

  Future<void> getErpOrderList() async {
    String url = '$serversite/api/erp-orders/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<ErpOrder> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          ErpOrder erporderlist = ErpOrder.fromJson(element);
          demo.add(erporderlist);
        });
        print('success erporderlist data');
        _erpOrders = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error erporderlist");
    }
  }

  void manupulate() {
    _erpOrders[0].id = 1000000;
    notifyListeners();
  }

  List<ErpOrder> get erporderlist {
    return _erpOrders;
  }

  List<ErpOrder> get erpordercompletedlist {
    return _erpOrders.where((element) => element.completed == true).toList();
  }

  List<ErpOrder> get erporderpendinglist {
    return _erpOrders.where((element) => element.completed == false).toList();
  }

  ErpOrder singleOrder(int id) {
    print('id${id}');
    return _erpOrders.firstWhere((element) => element.id == id);
  }

  List<ErpOrderItem>? OrderItem(int id) {
    var order = _erpOrders.firstWhere((element) => element.id == id);
    return order.itemsNew;
  }

  // List<Movement>? Movement(int id) {
  //   var order = _erporder.firstWhere((element) => element.id == id);
  //   return order.itemsNew;
  // }
}