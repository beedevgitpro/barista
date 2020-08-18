import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String fName,lName,state,suburb,cName,street,country,postcode,phone,email;
  bool autoValidate=false,errFlag=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Form(
        child: Column(
          children: [
            Expanded(child: null)
          ],
        ),
      ),
    );
  }
}