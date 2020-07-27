import 'package:barista/components/cart_item.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
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
                  return false?Center(
                     child: Text('Your Cart is currently empty',style: TextStyle(
                      fontFamily: kDefaultFontFamily, fontSize: 16
                     ),),
                   ):
          SingleChildScrollView(
          child: Column(
             children: [
                for (var i = 0; i < 5; i++) 
                   CartItem(width: _large?_width*0.5:_width,title: '8oz Ivory Chai Sttoke usable Cup',)
             ], 
            ),
          );})
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: kPrimaryColor,
            alignment: Alignment.center,
            child: Text(false?'Back To Shopping':'Checkout',style: TextStyle(
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