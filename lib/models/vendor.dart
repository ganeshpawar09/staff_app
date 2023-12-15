import 'package:staff_flutter_app/models/auth.dart';
import 'package:staff_flutter_app/models/data.dart';

class VendorDetail {
  int? id;  
  String? vendorCode;
  String? companyName;
  String? processName;
  String? machineName;
  double? bedSizeX;
  double? bedSizeY;
  double? bedSizeZ;
  String? gstNo;
  String? bankAccountNo;
  String? ifscCode;
  String? nameOnCheck;
  String? upiId;
  String? billingAdd1;
  String? billingAdd2;
  String? city;
  String? state;
  String? country;
  int? pin;
  String? email;
  String? contPersonName;
  String? contPersonNumber;
  String? latitude;
  String? longitude;
  User? user;
  List<ManufacturingCapabilities>? manufacturingCapabilities;

  VendorDetail(
      {this.id,
      this.vendorCode,
      this.companyName,
      this.processName,
      this.machineName,
      this.bedSizeX,
      this.bedSizeY,
      this.bedSizeZ,
      this.gstNo,
      this.bankAccountNo,
      this.ifscCode,
      this.nameOnCheck,
      this.upiId,
      this.billingAdd1,
      this.billingAdd2,
      this.city,
      this.state,
      this.country,
      this.pin,
      this.email,
      this.contPersonName,
      this.contPersonNumber,
      this.latitude,
      this.longitude,
      this.user,
      this.manufacturingCapabilities});

  VendorDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorCode = json['vendor_code'];
    companyName = json['company_name'];
    processName = json['process_name'];
    machineName = json['machine_name'];
    bedSizeX = json['bed_size_x'];
    bedSizeY = json['bed_size_y'];
    bedSizeZ = json['bed_size_z'];
    gstNo = json['gst_no'];
    bankAccountNo = json['bank_account_no'];
    ifscCode = json['ifsc_code'];
    nameOnCheck = json['name_on_check'];
    upiId = json['upi_id'];
    billingAdd1 = json['billing_add_1'];
    billingAdd2 = json['billing_add_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
    email = json['email'];
    contPersonName = json['cont_person_name'];
    contPersonNumber = json['cont_person_number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['manufacturing_capabilities'] != null) {
      manufacturingCapabilities = <ManufacturingCapabilities>[];
      json['manufacturing_capabilities'].forEach((v) {
        manufacturingCapabilities!
            .add(new ManufacturingCapabilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_code'] = this.vendorCode;
    data['company_name'] = this.companyName;
    data['process_name'] = this.processName;
    data['machine_name'] = this.machineName;
    data['bed_size_x'] = this.bedSizeX;
    data['bed_size_y'] = this.bedSizeY;
    data['bed_size_z'] = this.bedSizeZ;
    data['gst_no'] = this.gstNo;
    data['bank_account_no'] = this.bankAccountNo;
    data['ifsc_code'] = this.ifscCode;
    data['name_on_check'] = this.nameOnCheck;
    data['upi_id'] = this.upiId;
    data['billing_add_1'] = this.billingAdd1;
    data['billing_add_2'] = this.billingAdd2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    data['email'] = this.email;
    data['cont_person_name'] = this.contPersonName;
    data['cont_person_number'] = this.contPersonNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.manufacturingCapabilities != null) {
      data['manufacturing_capabilities'] =
          this.manufacturingCapabilities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}