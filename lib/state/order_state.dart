import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/server_url.dart';
import 'package:staff_flutter_app/models/order.dart';

class OrderState with ChangeNotifier {
  LocalStorage storage =  LocalStorage('usertoken');

  late List<ErpOrder> _erporder;  

  Future<void> geterporderlists() async {
    String url = serversite + '/api/erp-orders/';
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
        _erporder = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error erporderlist");
    }
  }

  List<ErpOrder> get erporderlist {
    return _erporder;
  }

  List<ErpOrder> get erpordercompletedlist {
    return _erporder.where((element) => element.completed == true).toList();
  }

  List<ErpOrder> get erporderpendinglist {
    return _erporder.where((element) => element.completed == false).toList();
  }

  ErpOrder singleOrder(int id) {
    print('id${id}');
    return _erporder.firstWhere((element) => element.id == id);
  }

  List<ErpOrderItem>? OrderItem(int id) {
    var order = _erporder.firstWhere((element) => element.id == id);
    return order.itemsNew;
  }

  // List<Movement>? Movement(int id) {
  //   var order = _erporder.firstWhere((element) => element.id == id);
  //   return order.itemsNew;
  // }

  getorderbyprocess(items_new) {
   for (var order in _erporder) {
     for (var items_new in {order.itemsNew}) {
        items_new == items_new ? print('object okay'): print('object okay');
        if (items_new == items_new){
            return _erporder.firstWhere((element) => element.id == order.id);      
        }
        int? test = order.id;
        print('test is $test');
     }
    }
  }
}