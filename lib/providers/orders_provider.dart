import 'package:barista/request_models/create_order_request_model.dart';
import 'package:barista/response_models/order_list_response_model.dart';
import 'package:barista/response_models/order_response_model.dart';
import 'package:barista/utility/webservice.dart';
import 'package:flutter/material.dart';


class OrderProvider with ChangeNotifier {
  List<OrderListResponseModel> orderDetails = [];

  Future<List<OrderListResponseModel>> fetchOrderDetails() async {
    orderDetails = await WebService.fetchOrderDetails();
    notifyListeners();
    return orderDetails;
  }

  List<OrderListResponseModel> get getOrderDetails {
    return [...orderDetails];
  }

  Future<OrderResponseModel> createOrder(
      CreateOrderRequestModel createOrderRequestModel) async {
    var createdOrder = await WebService.createOrder(createOrderRequestModel);
    notifyListeners();
    return createdOrder;
  }
}
