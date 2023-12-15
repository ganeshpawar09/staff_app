import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/order.dart';
import 'package:staff_flutter_app/server_url.dart';

class OrderitemState with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');

  late List<ErpOrderItem> _erporderitem;

  Future<void> geterporderitemlists() async {
    String url = serversite + '/api/get_orderitem_list_by_partner/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<ErpOrderItem> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          ErpOrderItem erporderitemlist = ErpOrderItem.fromJson(element);
          demo.add(erporderitemlist);
        });
        print('success erporderitemlist data');
        _erporderitem = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error erporderitemlist");
    }
  }

  getorderitembyprocess(process) {
    for (var orderitem in _erporderitem) {
      for (var process in {orderitem.process}) {
        process == process ? print('object okay') : print('object okay');
        if (process == process) {
          return _erporderitem
              .firstWhere((element) => element.id == orderitem.id);
        }
        int? test = orderitem.id;
        print('test is $test');
      }
    }
  }
}
