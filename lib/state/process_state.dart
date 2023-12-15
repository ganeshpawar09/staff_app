import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/order_process.dart';
import 'package:staff_flutter_app/server_url.dart';

class ProcessState with ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');
  // var token = storage.getItem('token');
  late OrderProcess _orderProcess;
  late List<OrderProcess> _orderprocess;
  late List<OrderProcess> _orderprocessnow;
  late List<OrderProcess> _orderprocessupcoming;
  late List<OrderProcess> _orderprocessoverdue;

  Future<void> getProcessDatas() async {
    String url = serversite + '/api/process/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      print("Sucess getProcessDatas");
      List<OrderProcess> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderProcess orderProcess = OrderProcess.fromJson(element);

          demo.add(orderProcess);
        });
        _orderProcess = demo[0];
        notifyListeners();
      } else {}
    } catch (e) {
      print(e);
      print("error while getting process data");
    }
  }

  Future<void> getorderprocesslists() async {
    String url = serversite + '/api/process/';
    var token = storage.getItem('token');
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
        _orderprocess = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print(e);
      print("error getorderprocesslists");
    }
  }

  Future<void> getorderprocessnowlists() async {
    String url = serversite + '/api/process_now/';
    var token = storage.getItem('token');
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
        _orderprocessnow = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print("error getorderprocesslists");
    }
  }

  Future<void> getorderprocessupcominglists() async {
    String url = serversite + '/api/process_upcoming/';
    var token = storage.getItem('token');
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
        print('sucess process data');
        _orderprocessupcoming = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print("error getorderprocesslists");
    }
  }

  Future<void> getorderprocessoverduelists() async {
    String url = serversite + '/api/process_overdue/';
    var token = storage.getItem('token');
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
        print('process data');
        _orderprocessoverdue = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print("error getorderprocesslists");
    }
  }

  Future<http.Response?> updateprocessstatus(
      int id, int val1, String val2) async {
    String url = serversite + '/api/update_process/$id/';
    var token = storage.getItem('token');
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
  }

  OrderProcess? get orderProcess {
    if (_orderProcess != null) {
      return _orderProcess;
    } else {
      return null;
    }
  }

  List<OrderProcess> get orderprocesslist {
    return _orderprocess;
  }

  List<OrderProcess> get orderprocesslistnow {
    return _orderprocessnow;
  }

  List<OrderProcess> get orderprocesslistupcoming {
    return _orderprocessupcoming;
  }

  List<OrderProcess> get orderprocesslistoverdue {
    return _orderprocessoverdue;
  }

  List<OrderProcess> get completedorderprocess {
    return _orderprocess.where((element) => element.completed == true).toList();
  }

  List<OrderProcess> get pendingorderprocess {
    return _orderprocess
        .where((element) => element.completed == false)
        .toList();
  }

  OrderProcess singleProcess(int id) {
    print('id');
    return _orderprocess.firstWhere((element) => element.id == id);
  }
}
