import 'dart:convert';

import 'package:barista/response_models/customer_detail_response_model.dart';


CreateOrderRequestModel createOrderRequestModelFromJson(String str) =>
    CreateOrderRequestModel.fromJson(json.decode(str));

String createOrderRequestModelToJson(CreateOrderRequestModel data) =>
    json.encode(data.toJson());

class CreateOrderRequestModel {
  CreateOrderRequestModel({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.customerId,
    this.lineItems,
    //  this.shippingLines,
  });

  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  Ing billing;
  Ing shipping;
  int customerId;
  List<LineItem> lineItems;

  // List<ShippingLine> shippingLines;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderRequestModel(
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        setPaid: json["set_paid"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        customerId: json["customer_id"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        // shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "customer_id": customerId,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        //  "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
      };
}

/*class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
  };
}*/

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
    // this.variationId,
  });

  int productId;
  int quantity;

  // int variationId;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"],
        quantity: json["quantity"],
        // variationId: json["variation_id"] == null ? null : json["variation_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        //   "variation_id": variationId == null ? null : variationId,
      };
}

class ShippingLine {
  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        methodId: json["method_id"],
        methodTitle: json["method_title"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "method_id": methodId,
        "method_title": methodTitle,
        "total": total,
      };
}
