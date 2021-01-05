import 'package:barista/response_models/customer_detail_response_model.dart';
import 'package:barista/utility/webservice.dart';
import 'package:flutter/material.dart';


class CustomerProvider with ChangeNotifier {
  CustomerDetailResponseModel _customerDetail;

  Future<CustomerDetailResponseModel> getCustomerData() async {
    // _cartList.forEach((key, cartI) {
    //   total += cartI.price * cartI.quantity;
    // });
    _customerDetail = await WebService.fetchCustomerDetails();
    notifyListeners();
    return _customerDetail;
  }
  CustomerDetailResponseModel get getCustomerDetail {
    return _customerDetail;
  }
}
