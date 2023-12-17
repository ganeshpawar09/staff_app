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
    if (json['material'] != null) {
      material = <PartMaterial>[];
      json['material'].forEach((v) {
        material!.add(PartMaterial.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cap_id'] = capId;
    data['cap_ref_name'] = capRefName;
    data['cap_name'] = capName;
    data['bed_size_x'] = bedSizeX;
    data['bed_size_y'] = bedSizeY;
    data['bed_size_z'] = bedSizeZ;
    data['cap_type'] = capType;
    data['price_calculator'] = priceCalculator;
    data['instant_quote'] = instantQuote;
    if (material != null) {
      data['material'] = material!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartMaterial {
  int? materialId;
  String? materialTypeName;
  String? materialName;
  String? materialRefName;
  double? density;
  String? billetType;
  double? machiningFactor1;
  double? rate;

  PartMaterial({
    this.materialId,
    this.materialTypeName,
    this.materialName,
    this.materialRefName,
    this.density,
    this.billetType,
    this.machiningFactor1,
    this.rate,
  });

  PartMaterial.fromJson(Map<String, dynamic> json) {
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
