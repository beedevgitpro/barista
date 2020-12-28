import 'dart:convert';

import 'package:flutter/foundation.dart';

GetCartResponseModel getCartResponseModelFromJson(String str) =>
    GetCartResponseModel.fromJson(json.decode(str));

String getCartResponseModelToJson(GetCartResponseModel data) =>
    json.encode(data.toJson());

class GetCartResponseModel with ChangeNotifier {
  GetCartResponseModel({
    this.key,
    this.productId,
    this.variationId,
    this.quantity,
    this.dataHash,
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTax,
    this.productName,
    this.productTitle,
    this.productPrice,
    this.productImage,
  });

  String key;
  int productId;
  int variationId;
  int quantity;
  String dataHash;
  dynamic lineSubtotal;
  dynamic lineSubtotalTax;
  dynamic lineTotal;
  dynamic lineTax;
  String productName;
  String productTitle;
  String productPrice;
  String productImage;

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCartResponseModel(
        key: json["key"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        dataHash: json["data_hash"],
        lineSubtotal: json["line_subtotal"],
        lineSubtotalTax: json["line_subtotal_tax"].toDouble(),
        lineTotal: json["line_total"].toDouble(),
        lineTax: json["line_tax"].toDouble(),
        productName: json["product_name"],
        productTitle: json["product_title"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "data_hash": dataHash,
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "product_name": productName,
    "product_title": productTitle,
    "product_price": productPrice,
    "product_image": productImage,
  };
}
