import 'dart:convert';

CartDeleteRequestModel cartDeleteRequestModelFromJson(String str) =>
    CartDeleteRequestModel.fromJson(json.decode(str));

String cartDeleteRequestModelToJson(CartDeleteRequestModel data) =>
    json.encode(data.toJson());

class CartDeleteRequestModel {
  CartDeleteRequestModel({
    this.cartItemKey,
  });

  String cartItemKey;

  factory CartDeleteRequestModel.fromJson(Map<String, dynamic> json) =>
      CartDeleteRequestModel(
        cartItemKey: json["cart_item_key"],
      );

  Map<String, dynamic> toJson() => {
        "cart_item_key": cartItemKey,
      };
}
