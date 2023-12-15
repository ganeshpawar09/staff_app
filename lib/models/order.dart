import 'package:staff_flutter_app/models/auth.dart';
import 'package:staff_flutter_app/models/data.dart';
import 'package:staff_flutter_app/models/material_vendor.dart';

class ErpOrder {
  int? id;
  String? refCode;
  String? quoteNo;
  String? barcodeImg;
  String? startDate;
  String? orderedDate;
  bool? ordered;
  int? leadTime;
  String? status;
  bool? closed;
  bool? completed;
  List<ErpOrderItem>? itemsNew;

  ErpOrder({
    this.id,
    this.refCode,
    this.quoteNo,
    this.barcodeImg,
    this.startDate,
    this.orderedDate,
    this.ordered,
    this.leadTime,
    this.status,
    this.closed,
    this.completed,
    this.itemsNew,
  });

  ErpOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCode = json['ref_code'];
    quoteNo = json['quote_no'];
    barcodeImg = json['barcode_img'];
    startDate = json['start_date'];
    orderedDate = json['ordered_date'];
    ordered = json['ordered'];
    leadTime = json['lead_time'];
    status = json['status'];
    closed = json['closed'];
    completed = json['completed'];
    // itemsNew = json['items_new'] != null
    //     ? new ErpOrderItem.fromJson(json['items_new'])
    //     : null;
    if (json['items_new'] != null) {
      itemsNew = <ErpOrderItem>[];
      json['items_new'].forEach((v) {
        itemsNew!.add(new ErpOrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_code'] = this.refCode;
    data['quote_no'] = this.quoteNo;
    data['barcode_img'] = this.barcodeImg;
    data['start_date'] = this.startDate;
    data['ordered_date'] = this.orderedDate;
    data['ordered'] = this.ordered;
    data['lead_time'] = this.leadTime;
    data['status'] = this.status;
    data['closed'] = this.closed;
    data['completed'] = this.completed;
    if (this.itemsNew != null) {
      data['items_new'] = this.itemsNew!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ErpOrderItem {
  int? id;
  bool? ordered;
  int? quantity;
  String? surfaceFinish;
  String? color;
  int? thickness;
  int? bendNo;
  double? price;
  double? materialPrice;
  String? comment;
  String? techDrawingFile;
  bool? materialRequired;
  String? materialType;
  double? materialX;
  double? materialY;
  double? materialZ;
  double? materialCost;
  int? erpStage;
  String? trackSlug;
  String? trackStatus;
  User? user;
  Document? document;
  PartMaterial? materialDetail;
  ManufacturingCapabilities? manufacturingTech;
  MaterialVendor? materialVendorcode;
  List<Process>? process;
  List<Movement>? movement;

  ErpOrderItem(
      {this.id,
      this.ordered,
      this.quantity,
      this.surfaceFinish,
      this.color,
      this.thickness,
      this.bendNo,
      this.price,
      this.materialPrice,
      this.comment,
      this.techDrawingFile,
      this.materialRequired,
      this.materialType,
      this.materialX,
      this.materialY,
      this.materialZ,
      this.materialCost,
      this.erpStage,
      this.trackSlug,
      this.trackStatus,
      this.user,
      this.document,
      this.materialDetail,
      this.manufacturingTech,
      this.materialVendorcode,
      this.process,
      this.movement});

  ErpOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordered = json['ordered'];
    quantity = json['quantity'];
    surfaceFinish = json['surface_finish'];
    color = json['color'];
    thickness = json['thickness'];
    bendNo = json['bend_no'];
    price = json['price'];
    materialPrice = json['material_price'];
    comment = json['comment'];
    techDrawingFile = json['tech_drawing_file'];
    materialRequired = json['material_required'];
    materialType = json['material_type'];
    materialX = json['material_x'];
    materialY = json['material_y'];
    materialZ = json['material_z'];
    materialCost = json['material_cost'];
    erpStage = json['erp_stage'];
    trackSlug = json['track_slug'];
    trackStatus = json['track_status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
    materialDetail = json['material_detail'] != null
        ? new PartMaterial.fromJson(json['material_detail'])
        : null;
    manufacturingTech = json['manufacturing_tech'] != null
        ? new ManufacturingCapabilities.fromJson(json['manufacturing_tech'])
        : null;
    materialVendorcode = json['material_vendorcode'] != null
        ? new MaterialVendor.fromJson(json['material_vendorcode'])
        : null;
    if (json['process'] != null) {
      process = <Process>[];
      json['process'].forEach((v) {
        process!.add(new Process.fromJson(v));
      });
    }
    if (json['movement'] != null) {
      movement = <Movement>[];
      json['movement'].forEach((v) {
        movement!.add(new Movement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ordered'] = this.ordered;
    data['quantity'] = this.quantity;
    data['surface_finish'] = this.surfaceFinish;
    data['color'] = this.color;
    data['thickness'] = this.thickness;
    data['bend_no'] = this.bendNo;
    data['price'] = this.price;
    data['material_price'] = this.materialPrice;
    data['comment'] = this.comment;
    data['tech_drawing_file'] = this.techDrawingFile;
    data['material_required'] = this.materialRequired;
    data['material_type'] = this.materialType;
    data['material_x'] = this.materialX;
    data['material_y'] = this.materialY;
    data['material_z'] = this.materialZ;
    data['material_cost'] = this.materialCost;
    data['erp_stage'] = this.erpStage;
    data['track_slug'] = this.trackSlug;
    data['track_status'] = this.trackStatus;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.document != null) {
      data['document'] = this.document!.toJson();
    }
    if (this.materialDetail != null) {
      data['material_detail'] = this.materialDetail!.toJson();
    }
    if (this.manufacturingTech != null) {
      data['manufacturing_tech'] = this.manufacturingTech!.toJson();
    }
    if (this.materialVendorcode != null) {
      data['material_vendorcode'] = this.materialVendorcode!.toJson();
    }
    if (this.process != null) {
      data['process'] = this.process!.map((v) => v.toJson()).toList();
    }
    if (this.movement != null) {
      data['movement'] = this.movement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Document {
  int? id;
  String? partId;
  String? barcodeLink;
  String? barcodeImg;
  String? description;
  String? filetype;
  String? document;
  String? uploadedAt;
  String? slug;
  double? volume;
  double? perimeter;
  int? startingPoint;
  double? surfaceArea;
  double? dimensionX;
  double? dimensionY;
  double? dimensionZ;
  User? user;

  Document(
      {this.id,
      this.partId,
      this.barcodeLink,
      this.barcodeImg,
      this.description,
      this.filetype,
      this.document,
      this.uploadedAt,
      this.slug,
      this.volume,
      this.perimeter,
      this.startingPoint,
      this.surfaceArea,
      this.dimensionX,
      this.dimensionY,
      this.dimensionZ,
      this.user});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partId = json['part_id'];
    barcodeLink = json['barcode_link'];
    barcodeImg = json['barcode_img'];
    description = json['description'];
    filetype = json['filetype'];
    document = json['document'];
    uploadedAt = json['uploaded_at'];
    slug = json['slug'];
    volume = json['volume'];
    perimeter = json['perimeter'];
    startingPoint = json['starting_point'];
    surfaceArea = json['surface_area'];
    dimensionX = json['dimension_x'];
    dimensionY = json['dimension_y'];
    dimensionZ = json['dimension_z'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['part_id'] = this.partId;
    data['barcode_link'] = this.barcodeLink;
    data['barcode_img'] = this.barcodeImg;
    data['description'] = this.description;
    data['filetype'] = this.filetype;
    data['document'] = this.document;
    data['uploaded_at'] = this.uploadedAt;
    data['slug'] = this.slug;
    data['volume'] = this.volume;
    data['perimeter'] = this.perimeter;
    data['starting_point'] = this.startingPoint;
    data['surface_area'] = this.surfaceArea;
    data['dimension_x'] = this.dimensionX;
    data['dimension_y'] = this.dimensionY;
    data['dimension_z'] = this.dimensionZ;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Process {
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
  ManufacturingCapabilities? manufacturingCapabilities;
  Vendorcode? vendorcode;
  PaymentDetails? paymentDetails;

  Process(
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
      this.manufacturingCapabilities,
      this.vendorcode,
      this.paymentDetails});

  Process.fromJson(Map<String, dynamic> json) {
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
    manufacturingCapabilities = json['manufacturing_capabilities'] != null
        ? new ManufacturingCapabilities.fromJson(
            json['manufacturing_capabilities'])
        : null;
    vendorcode = json['vendorcode'] != null
        ? new Vendorcode.fromJson(json['vendorcode'])
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
    if (this.manufacturingCapabilities != null) {
      data['manufacturing_capabilities'] =
          this.manufacturingCapabilities!.toJson();
    }
    if (this.vendorcode != null) {
      data['vendorcode'] = this.vendorcode!.toJson();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] = this.paymentDetails!.toJson();
    }
    return data;
  }
}

class Vendorcode {
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

  Vendorcode(
      {this.vendorCode,
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

  Vendorcode.fromJson(Map<String, dynamic> json) {
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

class ManufacturingCapabilities {
  int? capId;
  String? capRefName;
  String? capName;
  double? bedSizeX;
  double? bedSizeY;
  double? bedSizeZ;
  String? capType;
  bool? priceCalculator;
  bool? instantQuote;
  List<PartMaterial>? material;

  ManufacturingCapabilities(
      {this.capId,
      this.capRefName,
      this.capName,
      this.bedSizeX,
      this.bedSizeY,
      this.bedSizeZ,
      this.capType,
      this.priceCalculator,
      this.instantQuote,
      this.material});

  ManufacturingCapabilities.fromJson(Map<String, dynamic> json) {
    capId = json['cap_id'];
    capRefName = json['cap_ref_name'];
    capName = json['cap_name'];
    bedSizeX = json['bed_size_x'];
    bedSizeY = json['bed_size_y'];
    bedSizeZ = json['bed_size_z'];
    capType = json['cap_type'];
    priceCalculator = json['price_calculator'];
    instantQuote = json['instant_quote'];

    // Check if 'material' is present in the JSON and is a List
    if (json['material'] != null && json['material'] is List) {
      material = List<PartMaterial>.from(
        (json['material'] as List)
            .map((materialJson) => PartMaterial.fromJson(materialJson)),
      );
    } else {
      material = null; // or an empty list, depending on your use case
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cap_id'] = this.capId;
    data['cap_ref_name'] = this.capRefName;
    data['cap_name'] = this.capName;
    data['bed_size_x'] = this.bedSizeX;
    data['bed_size_y'] = this.bedSizeY;
    data['bed_size_z'] = this.bedSizeZ;
    data['cap_type'] = this.capType;
    data['price_calculator'] = this.priceCalculator;
    data['instant_quote'] = this.instantQuote;
    data['material'] = this.material;
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

class Movement {
  int? id;
  int? srNo;
  String? movementId;
  String? barcodeLink;
  String? barcodeImg;
  String? source;
  String? destination;
  String? transportType;
  String? transportSize;
  double? transportWeight;
  double? transportCost;
  String? startDate;
  String? endDate;
  bool? completed;
  bool? request;
  bool? started;
  bool? picked;
  Rider? rider;

  Movement(
      {this.id,
      this.srNo,
      this.movementId,
      this.barcodeLink,
      this.barcodeImg,
      this.source,
      this.destination,
      this.transportType,
      this.transportSize,
      this.transportWeight,
      this.transportCost,
      this.startDate,
      this.endDate,
      this.completed,
      this.request,
      this.started,
      this.picked,
      this.rider});

  Movement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    srNo = json['sr_no'];
    movementId = json['movement_id'];
    barcodeLink = json['barcode_link'];
    barcodeImg = json['barcode_img'];
    source = json['source'];
    destination = json['destination'];
    transportType = json['transport_type'];
    transportSize = json['transport_size'];
    transportWeight = json['transport_weight'];
    transportCost = json['transport_cost'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    completed = json['completed'];
    request = json['request'];
    started = json['started'];
    picked = json['picked'];
    rider = json['rider'] != null ? new Rider.fromJson(json['rider']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sr_no'] = this.srNo;
    data['movement_id'] = this.movementId;
    data['barcode_link'] = this.barcodeLink;
    data['barcode_img'] = this.barcodeImg;
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['transport_type'] = this.transportType;
    data['transport_size'] = this.transportSize;
    data['transport_weight'] = this.transportWeight;
    data['transport_cost'] = this.transportCost;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['completed'] = this.completed;
    data['request'] = this.request;
    data['started'] = this.started;
    data['picked'] = this.picked;
    if (this.rider != null) {
      data['rider'] = this.rider!.toJson();
    }
    return data;
  }
}

class Rider {
  int? id;
  String? contactNo;
  bool? contactNoVerification;
  String? email;
  bool? emailVerification;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  int? pin;
  User? user;

  Rider(
      {this.id,
      this.contactNo,
      this.contactNoVerification,
      this.email,
      this.emailVerification,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.pin,
      this.user});

  Rider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactNo = json['contact_no'];
    contactNoVerification = json['contact_no_verification'];
    email = json['email'];
    emailVerification = json['email_verification'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pin = json['pin'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_no'] = this.contactNo;
    data['contact_no_verification'] = this.contactNoVerification;
    data['email'] = this.email;
    data['email_verification'] = this.emailVerification;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin'] = this.pin;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
