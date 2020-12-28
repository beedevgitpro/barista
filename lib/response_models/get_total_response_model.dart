import 'dart:convert';

GetTotalResponseModel getTotalResponseModelFromJson(String str) =>
    GetTotalResponseModel.fromJson(json.decode(str));

String getTotalResponseModelToJson(GetTotalResponseModel data) =>
    json.encode(data.toJson());

class GetTotalResponseModel {
  GetTotalResponseModel({
    this.subtotal,
    this.subtotalTax,
    this.shippingTotal,
    this.shippingTax,
    this.discountTotal,
    this.discountTax,
    this.cartContentsTotal,
    this.cartContentsTax,
    this.feeTotal,
    this.feeTax,
    this.feeTaxes,
    this.total,
    this.totalTax,
  });

  /*dynamic lineSubtotal;
  dynamic lineSubtotalTax;
  dynamic lineTotal;
  dynamic lineTax;*/

  dynamic subtotal;
  dynamic subtotalTax;
  dynamic shippingTotal;
  dynamic shippingTax;
  dynamic discountTotal;
  dynamic discountTax;
  dynamic cartContentsTotal;
  dynamic cartContentsTax;
  dynamic feeTotal;
  dynamic feeTax;
  List<dynamic> feeTaxes;
  dynamic total;
  dynamic totalTax;

  factory GetTotalResponseModel.fromJson(Map<String, dynamic> json) =>
      GetTotalResponseModel(
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"].toDouble(),
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"].toDouble(),
        discountTotal: json["discount_total"].toDouble(),
        discountTax: json["discount_tax"],
        cartContentsTotal: json["cart_contents_total"],
        cartContentsTax: json["cart_contents_tax"].toDouble(),
        feeTotal: json["fee_total"],
        feeTax: json["fee_tax"],
        feeTaxes: List<dynamic>.from(json["fee_taxes"].map((x) => x)),
        total: json["total"],
        totalTax: json["total_tax"],
      );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "cart_contents_total": cartContentsTotal,
    "cart_contents_tax": cartContentsTax,
    "fee_total": feeTotal,
    "fee_tax": feeTax,
    "fee_taxes": List<dynamic>.from(feeTaxes.map((x) => x)),
    "total": total,
    "total_tax": totalTax,
  };
}
