import 'package:flutter/material.dart';

class PaymentMethodModel with ChangeNotifier{
  String icon;
  String methodName;
  bool isSelected;

  PaymentMethodModel({this.icon,this.methodName,this.isSelected});

}