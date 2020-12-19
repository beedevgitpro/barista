import 'dart:convert';

UpdateCartItemRequestModel updateCartItemRequestModelFromJson(String str) =>
    UpdateCartItemRequestModel.fromJson(json.decode(str));

String updateCartItemRequestModelToJson(UpdateCartItemRequestModel data) =>
    json.encode(data.toJson());

class UpdateCartItemRequestModel {
  UpdateCartItemRequestModel({
    this.cartItemKey,
    this.quantity,
  });

  String cartItemKey;
  int quantity;

  factory UpdateCartItemRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateCartItemRequestModel(
        cartItemKey: json["cart_item_key"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "cart_item_key": cartItemKey,
        "quantity": quantity,
      };
}
