import 'package:staff_flutter_app/models/auth.dart';

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

    if (json['items_new'] != null) {
      itemsNew = <ErpOrderItem>[];
      json['items_new'].forEach((v) {
        itemsNew!.add(ErpOrderItem.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_code'] = refCode;
    data['quote_no'] = quoteNo;
    data['barcode_img'] = barcodeImg;
    data['start_date'] = startDate;
    data['ordered_date'] = orderedDate;
    data['ordered'] = ordered;
    data['lead_time'] = leadTime;
    data['status'] = status;
    data['closed'] = closed;
    data['completed'] = completed;
    if (itemsNew != null) {
      data['items_new'] = itemsNew!.map((v) => v.toJson()).toList();
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
  MaterialDetail? materialDetail;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
    materialDetail = json['material_detail'] != null
        ? MaterialDetail.fromJson(json['material_detail'])
        : null;
    manufacturingTech = json['manufacturing_tech'] != null
        ? ManufacturingCapabilities.fromJson(json['manufacturing_tech'])
        : null;
    materialVendorcode = json['material_vendorcode'] != null
        ? MaterialVendor.fromJson(json['material_vendorcode'])
        : null;
    if (json['process'] != null) {
      process = <Process>[];
      json['process'].forEach((v) {
        process!.add(Process.fromJson(v));
      });
    }
    if (json['movement'] != null) {
      movement = <Movement>[];
      json['movement'].forEach((v) {
        movement!.add(Movement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ordered'] = ordered;
    data['quantity'] = quantity;
    data['surface_finish'] = surfaceFinish;
    data['color'] = color;
    data['thickness'] = thickness;
    data['bend_no'] = bendNo;
    data['price'] = price;
    data['material_price'] = materialPrice;
    data['comment'] = comment;
    data['tech_drawing_file'] = techDrawingFile;
    data['material_required'] = materialRequired;
    data['material_type'] = materialType;
    data['material_x'] = materialX;
    data['material_y'] = materialY;
    data['material_z'] = materialZ;
    data['material_cost'] = materialCost;
    data['erp_stage'] = erpStage;
    data['track_slug'] = trackSlug;
    data['track_status'] = trackStatus;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (document != null) {
      data['document'] = document!.toJson();
    }
    if (materialDetail != null) {
      data['material_detail'] = materialDetail!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (document != null) {
      data['document'] = document!.toJson();
    }
    if (materialDetail != null) {
      data['material_detail'] = materialDetail!.toJson();
    }
    if (manufacturingTech != null) {
      data['manufacturing_tech'] = manufacturingTech!.toJson();
    }
    if (materialVendorcode != null) {
      data['material_vendorcode'] = materialVendorcode!.toJson();
    }
    if (process != null) {
      data['process'] = process!.map((v) => v.toJson()).toList();
    }
    if (movement != null) {
      data['movement'] = movement!.map((v) => v.toJson()).toList();
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (user != null) {
      data['user'] = user!.toJson();
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
  VendorDetail? vendorcode;
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
        ? ManufacturingCapabilities.fromJson(json['manufacturing_capabilities'])
        : null;
    vendorcode = json['vendorcode'] != null
        ? VendorDetail.fromJson(json['vendorcode'])
        : null;
    paymentDetails = json['payment_details'] != null
        ? PaymentDetails.fromJson(json['payment_details'])
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

class VendorDetail {
  int? id;
  String? vendorCode;
  String? companyName;
  String? processName;
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
    if (json['manufacturing_capabilities'] != null) {
      manufacturingCapabilities = <ManufacturingCapabilities>[];
      json['manufacturing_capabilities'].forEach((v) {
        manufacturingCapabilities!.add(ManufacturingCapabilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['vendor_code'] = this.vendorCode;
    data['company_name'] = this.companyName;
    data['process_name'] = this.processName;
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
  List<MaterialDetail>? material;

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
      material = List<MaterialDetail>.from(
        (json['material'] as List)
            .map((materialJson) => MaterialDetail.fromJson(materialJson)),
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

class MaterialDetail {
  int? materialId;
  String? materialTypeName;
  String? materialName;
  String? materialRefName;
  double? density;
  String? billetType;
  double? machiningFactor1;
  double? rate;

  MaterialDetail({
    this.materialId,
    this.materialTypeName,
    this.materialName,
    this.materialRefName,
    this.density,
    this.billetType,
    this.machiningFactor1,
    this.rate,
  });

  MaterialDetail.fromJson(Map<String, dynamic> json) {
    materialId = json['material_id'];
    materialTypeName = json['material_type_name'];
    materialName = json['material_name'];
    materialRefName = json['material_ref_name'];
    density = json['density']?.toDouble();
    billetType = json['billet_type'];
    machiningFactor1 = json['machining_factor1']
        ?.toDouble(); // Handle nullable and convert to double
    rate = json['rate']?.toDouble(); // Handle nullable and convert to double
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'material_id': materialId,
      'material_type_name': materialTypeName,
      'material_name': materialName,
      'material_ref_name': materialRefName,
      'density': density,
      'billet_type': billetType,
      'machining_factor1': machiningFactor1,
      'rate': rate,
    };

    data.removeWhere((key, value) => value == null);

    return data;
  }
}

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
        ? ManufacturingCapabilities.fromJson(json['manufacturing_capabilities'])
        : null;
    vendorDetail = json['vendor_detail'] != null
        ? VendorDetail.fromJson(json['vendor_detail'])
        : null;
    paymentDetails = json['payment_details'] != null
        ? PaymentDetails.fromJson(json['payment_details'])
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
      data['manufacturing_capabilities'] = manufacturingCapabilities!.toJson();
    }
    if (vendorDetail != null) {
      data['vendor_detail'] = vendorDetail!.toJson();
    }
    if (paymentDetails != null) {
      data['payment_details'] = paymentDetails!.toJson();
    }
    return data;
  }
}

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
