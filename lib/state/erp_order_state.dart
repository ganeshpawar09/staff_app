import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/server_url.dart';
import 'package:staff_flutter_app/models/combine_data.dart';

class ErpOrderState extends ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');

  List<ErpOrder> _erpOrders = [];
  ErpOrder? _singleErpOrder;

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

  Future<void> getErpOrderByProcess(ErpOrderProcess orderProcess) async {
    String url =
        '$serversite/api/erp-order-by-processid/${orderProcess.processId}';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<ErpOrder> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          ErpOrder erporderitemlist = ErpOrder.fromJson(element);
          demo.add(erporderitemlist);
        });
        print('success erporderitemlist data');
        _singleErpOrder = demo[0];
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error erporderitemlist");
    }
  }

  ErpOrder? get singleErpOrderByProcess {
    return _singleErpOrder;
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

  ErpOrder singleOrder(String quoteNo) {
    return _erpOrders.firstWhere((element) => element.quoteNo == quoteNo);
  }

  List<ErpOrderItem>? orderItem(int id) {
    var order = _erpOrders.firstWhere((element) => element.id == id);
    return order.itemsNew;
  }

  // List<Movement>? Movement(int id) {
  //   var order = _erporder.firstWhere((element) => element.id == id);
  //   return order.itemsNew;
  // }
}
