import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       elevation: 0,
       iconTheme: IconThemeData(
         size: 40,
        color: Colors.black 
       ),
      title: Text('Cart',style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),),
     ), 
     body: SafeArea(
            child: Column(
        children: [
          
          Expanded(child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return true?Center(
                     child: Text('Your Cart is currently empty',style: TextStyle(
                      fontFamily: kDefaultFontFamily, fontSize: 16
                     ),),
                   ):
          SingleChildScrollView(
          child: Column(
             children: [
               
             ], 
            ),
          );})
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: kPrimaryColor,
            alignment: Alignment.center,
            child: Text(true?'Back To Shopping':'Checkout',style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),),
        ], 
       ),
     ),
    );
  }
}