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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    return {
      'vendor_code': vendorCode,
      'company_name': companyName,
      'material_spec': materialSpec,
      'gst_no': gstNo,
      'bank_account_no': bankAccountNo,
      'ifsc_code': ifscCode,
      'name_on_check': nameOnCheck,
      'upi_id': upiId,
      'billing_add_1': billingAdd1,
      'billing_add_2': billingAdd2,
      'city': city,
      'state': state,
      'country': country,
      'pin': pin,
      'email': email,
      'cont_person_name': contPersonName,
      'cont_person_number': contPersonNumber,
      'latitude': latitude,
      'longitude': longitude,
      'user': user?.toJson(), // This will handle null gracefully
    };
  }
}
