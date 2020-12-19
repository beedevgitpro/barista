import 'dart:ui';

import 'package:barista/components/payment_method_item.dart';
import 'package:barista/providers/payment_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../responsive_text.dart';

class PaymentMethodScreen extends StatefulWidget {
  static var routeName = '/PaymentMethodScreen';
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);
    final paymentMItemList = paymentProvider.getPaymentMethodList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Payment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getFontSize(context, 8),
              color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.orange,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
           IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.orange,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF4F4F4),
        
      ),
      body: Container(
        
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
                        child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
                child: Container(
                  margin: const EdgeInsets.all(30.0),
                  child: ListView.builder(
                    itemCount: paymentMItemList.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          child: PaymentMethodItem(index),
                          value: paymentMItemList[index]);
                    },
                  ),
                ),
              ),
            ),
            /* Container(
              color:Colors.grey[100],
              child:Column(children: [

                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal:32),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total',style: TextStyle(fontSize: getFontSize(context, 1),color: Colors.black),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('\$',style: TextStyle(fontSize: getFontSize(context, 0),color: Colors.black),),
                          Text(' ${cartProvider.getTotalAmount}',style: TextStyle(fontSize: getFontSize(context, 1),color: Colors.black,),)
                        ],
                      )

                  ],),
                ),

                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal:32),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery',style: TextStyle(fontSize: getFontSize(context, 1),color: Colors.black),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('\$',style: TextStyle(fontSize: getFontSize(context, 0),color: Colors.black),),
                          Text(' ${20}',style: TextStyle(fontSize: getFontSize(context, 1),color: Colors.black,),)
                        ],
                      )

                  ],),
                ),
                

                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal:32),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',style: TextStyle(fontSize: getFontSize(context, 4),fontWeight: FontWeight.bold,color: Colors.black),),
                      Row(
                        children: [
                          Text('\$',style: TextStyle(fontSize: getFontSize(context, 3),color:Theme.of(context).primaryColor),),
                          Text(' ${cartProvider.getTotalAmount}',style: TextStyle(fontSize: getFontSize(context, 4),fontWeight: FontWeight.bold,color: Colors.black),)
                        ],
                      )

                  ],),
                ),

                Container(
                  margin:  EdgeInsets.symmetric(horizontal:32,vertical: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0) ,shape: BoxShape.rectangle ,gradient: LinearGradient(begin:Alignment.topCenter,end: Alignment.bottomCenter ,colors: [Colors.orange[400],Theme.of(context).primaryColor])),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 20.0,
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Text(
                                  "PAY NOW",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

              ],)
            )*/

          ],
        ),
      ),
    );

  }
}