import 'package:barista/models/payment_method_model.dart';
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentMethodModel> _paymentMethodList = [
    PaymentMethodModel(
        icon: 'assets/images/paypal.png',
        methodName: 'PayPal',
        isSelected: false),
    PaymentMethodModel(
        icon: 'assets/images/credit_card.png',
        methodName: 'Credit Card',
        isSelected: false),
    PaymentMethodModel(
        icon: 'assets/images/apple.png',
        methodName: 'Apple Pay',
        isSelected: false),
    PaymentMethodModel(
        icon: 'assets/images/google.png',
        methodName: 'Google',
        isSelected: false),
  ];

  PaymentMethodModel _selectedPayment;

  List<PaymentMethodModel> get getPaymentMethodList {
    return _paymentMethodList;
  }

  void selectPaymentMethod(int index) {
    if (_selectedPayment != null) {
      _selectedPayment.isSelected = false;
    }
    _paymentMethodList[index].isSelected =
        !_paymentMethodList[index].isSelected;
    _selectedPayment = _paymentMethodList[index];
    notifyListeners();
  }

  PaymentMethodModel get getSelectedPayment {
    if (_selectedPayment == null) {
      return _paymentMethodList.first;
    }
    return _selectedPayment;
  }

}