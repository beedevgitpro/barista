import 'dart:convert';

AddToCartResponseModel addToCartResponseModelFromJson(String str) =>
    AddToCartResponseModel.fromJson(json.decode(str));

String addToCartResponseModelToJson(AddToCartResponseModel data) =>
    json.encode(data.toJson());

class AddToCartResponseModel {
  AddToCartResponseModel({
    this.key,
    this.productId,
    this.variationId,
    this.variation,
    this.quantity,
    this.dataHash,
    this.lineTaxData,
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTax,
    this.data,
    this.productName,
    this.productTitle,
    this.productPrice,
  });

  String key;
  int productId;
  int variationId;
  List<dynamic> variation;
  int quantity;
  String dataHash;
  LineTaxData lineTaxData;
  int lineSubtotal;
  int lineSubtotalTax;
  int lineTotal;
  int lineTax;
  Data data;
  String productName;
  String productTitle;
  String productPrice;

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) =>
      AddToCartResponseModel(
        key: json["key"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        variation: List<dynamic>.from(json["variation"].map((x) => x)),
        quantity: json["quantity"],
        dataHash: json["data_hash"],
        lineTaxData: LineTaxData.fromJson(json["line_tax_data"]),
        lineSubtotal: json["line_subtotal"],
        lineSubtotalTax: json["line_subtotal_tax"],
        lineTotal: json["line_total"],
        lineTax: json["line_tax"],
        data: Data.fromJson(json["data"]),
        productName: json["product_name"],
        productTitle: json["product_title"],
        productPrice: json["product_price"],
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "variation": List<dynamic>.from(variation.map((x) => x)),
    "quantity": quantity,
    "data_hash": dataHash,
    "line_tax_data": lineTaxData.toJson(),
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "data": data.toJson(),
    "product_name": productName,
    "product_title": productTitle,
    "product_price": productPrice,
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

class LineTaxData {
  LineTaxData({
    this.subtotal,
    this.total,
  });

  List<dynamic> subtotal;
  List<dynamic> total;

  factory LineTaxData.fromJson(Map<String, dynamic> json) => LineTaxData(
    subtotal: List<dynamic>.from(json["subtotal"].map((x) => x)),
    total: List<dynamic>.from(json["total"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "subtotal": List<dynamic>.from(subtotal.map((x) => x)),
    "total": List<dynamic>.from(total.map((x) => x)),
  };
}
