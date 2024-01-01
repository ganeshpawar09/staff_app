import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/server_url.dart';

class ProcessRFQState with ChangeNotifier {
  LocalStorage storage = LocalStorage('usertoken');
  List<ProcessRFQ> _processRFQList = [];

  Future<void> getProcessRFQlists() async {
    String url = '$serversite/api/rfq_vendor_list/';
    var token = storage.getItem('token');
    //print('test2');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as Map;
      List<ProcessRFQ> demo = [];
      if (data['error'] == false) {
        data['data'].forEach((element) {
          ProcessRFQ processRFQTempList = ProcessRFQ.fromJson(element);
          demo.add(processRFQTempList);
        });
        print('process data');
        _processRFQList = demo;
        notifyListeners();
      } else {
        print("something went wrong from server side error=True");
      }
    } catch (e) {
      print("error get rfq list");
      print(e);
    }
  }

  Future<void> updateProcessRFQ(int id, double rfqCost) async {
    print("update started");

    String url = '$serversite/api/update_partner_rfq_price/$id/';
    var token = storage.getItem('token');

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'rfq_cost': rfqCost,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      print("updated");

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && !data['error']) {
        print(data["error"]);
        ProcessRFQ processRFQ =
            _processRFQList.firstWhere((element) => element.id == id);
        processRFQ.rfqCost = rfqCost;
        print("done");
        notifyListeners();
      } else {
        print("Failed to update process. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in updaterfqpartner: $e");
    }
  }

  List<ProcessRFQ> get processRFQList {
    return _processRFQList;
  }

  List<ProcessRFQ> get notOfferProcessRFQList {
    return _processRFQList.where((element) => element.rfqCost == 0.00).toList();
  }

  List<ProcessRFQ> get offerProcessRFQList {
    return _processRFQList.where((element) => element.rfqCost != 0.00).toList();
  }

  ProcessRFQ singlerfqitem(int id) {
    return _processRFQList.firstWhere((element) => element.id == id);
  }
}
