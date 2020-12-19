import 'dart:convert';

AddToCartRequestModel addToCartRequestModelFromJson(String str) =>
    AddToCartRequestModel.fromJson(json.decode(str));

String addToCartRequestModelToJson(AddToCartRequestModel data) =>
    json.encode(data.toJson());

class AddToCartRequestModel {
  AddToCartRequestModel({
    this.productId,
    this.quantity,
  });

  String productId;
  int quantity;

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) =>
      AddToCartRequestModel(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
  };
}
