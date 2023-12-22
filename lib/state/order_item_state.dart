import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/server_url.dart';

class OrderItemState extends ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');

  List<ErpOrderItem> _erporderitem = [];
  late ErpOrderItem _singleerporderitem;

  Future<void> getErpOrderItemList() async {
    String url = '$serversite/api/erp-orderitem/';
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

  Future<void> getErpOrderItemByProcess(OrderProcess orderProcess) async {
    String url =
        '$serversite/api/erp-orderitem-by-processid/${orderProcess.processId}';
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
        _singleerporderitem = demo[0];
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error erporderitemlist");
    }
  }
  ErpOrderItem singleOrderItem(String partId) {
    return _erporderitem.firstWhere((element) => element.document!.partId == partId);
  }

  ErpOrderItem get erpOrderItemByProcess {
    return _singleerporderitem;
  }

  List<ErpOrderItem> get erporderitemlist {
    return _erporderitem;
  }

  List<ErpOrderItem> get erporderitemcompletedlist {
    return _erporderitem.where((element) => element.ordered == true).toList();
  }

  List<ErpOrderItem> get erporderitempendinglist {
    return _erporderitem.where((element) => element.ordered == false).toList();
  }
}
