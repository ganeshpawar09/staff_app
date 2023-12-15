import 'package:staff_flutter_app/models/auth.dart';

class MaterialVendor {
  String? vendorCode;
  String? companyName;
  String? materialSpec;
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
  int? contPersonNumber;
  String? latitude;
  String? longitude;
  User? user;

  MaterialVendor(
      {this.vendorCode,
      this.companyName,
      this.materialSpec,
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
      this.user});

  MaterialVendor.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendor_code'];
    companyName = json['company_name'];
    materialSpec = json['material_spec'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_code'] = this.vendorCode;
    data['company_name'] = this.companyName;
    data['material_spec'] = this.materialSpec;
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
    return data;
  }
}