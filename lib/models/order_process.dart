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
        ?  ManufacturingCapabilities.fromJson(
            json['manufacturing_capabilities'])
        : null;
    vendorDetail = json['vendor_detail'] != null
        ?  VendorDetail.fromJson(json['vendor_detail'])
        : null;
    paymentDetails = json['payment_details'] != null
        ?  PaymentDetails.fromJson(json['payment_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sr_no'] = srNo;
    data['process_name'] = processName;
    data['process_id'] = processId;
    data['barcode_link'] = barcodeLink;
    data['barcode_img'] = barcodeImg;
    data['process_bill'] = processBill;
    data['target_cost'] = targetCost;
    data['cost'] = cost;
    data['inc_tax_cost'] = incTaxCost;
    data['process_part_file'] = processPartFile;
    data['process_drawing'] = processDrawing;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['completed'] = completed;
    data['wo_date'] = woDate;
    data['rfq_vendor_bool'] = rfqVendorBool;
    data['reviewed'] = reviewed;
    data['proceed'] = proceed;    
    if (manufacturingCapabilities != null) {
      data['manufacturing_capabilities'] =
          manufacturingCapabilities!.toJson();
    }
    if (vendorDetail != null) {
      data['vendor_detail'] = vendorDetail!.toJson();
    }
    if (paymentDetails != null) {
      data['payment_details'] =paymentDetails!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payment_ref'] = paymentRef;
    data['payment_mode'] = paymentMode;
    data['transaction_id'] = transactionId;
    data['partner_id'] = partnerId;
    data['status'] = status;
    data['amount'] = amount;
    data['timestamp'] = timestamp;
    return data;
  }
}
