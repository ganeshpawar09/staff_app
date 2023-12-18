import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:staff_flutter_app/models/order.dart';
import 'package:staff_flutter_app/server_url.dart';

class VendorState with ChangeNotifier {
  LocalStorage data = LocalStorage('usertoken');

  List<VendorDetail> _vendorList = [];

  Future<void> getVendorList() async {
    final String url = '$serversite/api/vendor-list/';

    var token = data.getItem('token');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });

      var data = json.decode(response.body) as Map;
      List<VendorDetail> vendors = [];

      if (data['error'] == false) {
        data['data'].forEach((element) {
          VendorDetail vendor = VendorDetail.fromJson(element);
          vendors.add(vendor);
        });

        _vendorList = vendors;
        notifyListeners();
      } else {
        print("Something went wrong from the server side. Error=true");
      }
    } catch (e) {
      print(e);
      print("Error fetching vendor list");
    }
  }

  List<VendorDetail> vendorList() {
    return _vendorList;
  }

  Future<void> updateVendor(VendorDetail updatedVendor) async {
    var token = data.getItem('token');
    final String url = '$serversite/api/vendor-details/${updatedVendor.id}/';

    try {
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {
          "Authorization": "token $token",
          "Content-Type": "application/json",
        },
        body: json.encode(updatedVendor.toJson()),
      );

      if (response.statusCode == 200) {
        int index = _vendorList.indexWhere(
            (vendor) => vendor.vendorCode == updatedVendor.vendorCode);
        if (index != -1) {
          _vendorList[index] = updatedVendor;
          notifyListeners();
        }
      } else {
        print("Failed to update vendor. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error updating vendor");
    }
  }

  Future<void> deleteVendor(int vendorId) async {
    var token = data.getItem('token');
    final String url = '$serversite/api/vendor-details/$vendorId/';

    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "token $token",
        },
      );

      if (response.statusCode == 204) {
        _vendorList.removeWhere((vendor) => vendor.id == vendorId);
        notifyListeners();
      } else {
        print("Failed to delete vendor. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error deleting vendor");
    }
  }
}
