import 'package:staff_flutter_app/models/data.dart';
import 'package:staff_flutter_app/models/vendor.dart';

class OrderProcess {
  int? id;
  int? srNo;
  String? processName;
  String? processId;
  String? barcodeLink;
  String? barcodeImg;
  String? processBill;
  double? targetCost;
  double? cost;
  double? incTaxCost;
  String? processPartFile;
  String? processDrawing;
  String? startDate;
  String? endDate;
  bool? completed;
  String? woDate;
  bool? rfqVendorBool;
  bool? reviewed;
  bool? proceed;  
  ManufacturingCapabilities? manufacturingCapabilities;
  VendorDetail? vendorDetail;
  PaymentDetails? paymentDetails;

  OrderProcess(
      {this.id,
      this.srNo,
      this.processName,
      this.processId,
      this.barcodeLink,
      this.barcodeImg,
      this.processBill,
      this.targetCost,
      this.cost,
      this.incTaxCost,
      this.processPartFile,
      this.processDrawing,
      this.startDate,
      this.endDate,
      this.completed,
      this.woDate,
      this.rfqVendorBool,
      this.reviewed,
      this.proceed,      
      this.manufacturingCapabilities,
      this.vendorDetail,
      this.paymentDetails});

  OrderProcess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    srNo = json['sr_no'];
    processName = json['process_name'];
    processId = json['process_id'];
    barcodeLink = json['barcode_link'];
    barcodeImg = json['barcode_img'];
    processBill = json['process_bill'];
    targetCost = json['target_cost'];
    cost = json['cost'];
    incTaxCost = json['inc_tax_cost'];
    processPartFile = json['process_part_file'];
    processDrawing = json['process_drawing'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    completed = json['completed'];
    woDate = json['wo_date'];
    rfqVendorBool = json['rfq_vendor_bool'];
    reviewed = json['reviewed'];
    proceed = json['proceed'];    
    manufacturingCapabilities = json['manufacturing_capabilities'] != null
        ? new ManufacturingCapabilities.fromJson(
            json['manufacturing_capabilities'])
        : null;
    vendorDetail = json['vendor_detail'] != null
        ? new VendorDetail.fromJson(json['vendor_detail'])
        : null;
    paymentDetails = json['payment_details'] != null
        ? new PaymentDetails.fromJson(json['payment_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sr_no'] = this.srNo;
    data['process_name'] = this.processName;
    data['process_id'] = this.processId;
    data['barcode_link'] = this.barcodeLink;
    data['barcode_img'] = this.barcodeImg;
    data['process_bill'] = this.processBill;
    data['target_cost'] = this.targetCost;
    data['cost'] = this.cost;
    data['inc_tax_cost'] = this.incTaxCost;
    data['process_part_file'] = this.processPartFile;
    data['process_drawing'] = this.processDrawing;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['completed'] = this.completed;
    data['wo_date'] = this.woDate;
    data['rfq_vendor_bool'] = this.rfqVendorBool;
    data['reviewed'] = this.reviewed;
    data['proceed'] = this.proceed;    
    if (this.manufacturingCapabilities != null) {
      data['manufacturing_capabilities'] =
          this.manufacturingCapabilities!.toJson();
    }
    if (this.vendorDetail != null) {
      data['vendor_detail'] = this.vendorDetail!.toJson();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] = this.paymentDetails!.toJson();
    }
    return data;
  }
}

class PaymentDetails {
  int? id;
  String? paymentRef;
  String? paymentMode;
  String? transactionId;
  String? partnerId;
  bool? status;
  double? amount;
  String? timestamp;

  PaymentDetails(
      {this.id,
      this.paymentRef,
      this.paymentMode,
      this.transactionId,
      this.partnerId,
      this.status,
      this.amount,
      this.timestamp});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentRef = json['payment_ref'];
    paymentMode = json['payment_mode'];
    transactionId = json['transaction_id'];
    partnerId = json['partner_id'];
    status = json['status'];
    amount = json['amount'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_ref'] = this.paymentRef;
    data['payment_mode'] = this.paymentMode;
    data['transaction_id'] = this.transactionId;
    data['partner_id'] = this.partnerId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
