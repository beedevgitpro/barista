import 'package:barista/components/cart_item.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/providers/cart_provider.dart';
import 'package:barista/response_models/get_total_response_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

import 'checkoutScreen.dart';
class CartScreen extends StatefulWidget {
  static var routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() async{

    await Provider.of<CartProvider>(context, listen: false)
        .fetchCartDetails();
    await Provider.of<CartProvider>(context, listen: false)
        .getTotalAmount();

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'My Cart',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context, 8),
                color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Theme.of(context).accentColor,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            // IconButton(
            //     icon: Icon(
            //       Icons.close,
            //       color: Colors.orange,
            //       size: 24,
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     })
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFF4F4F4),
        ),
        body:_isLoading?Center(child: CircularProgressIndicator(),) : Consumer<CartProvider>(
            builder: (key, cart, _) {
              var cartItemList = cart.getCartItems;
              var totalsResponse = cart.getTotals;
              return cart.getCartItems.length>0?
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child:
                        Container(
                            color: Color(0xFFF4F4F4),
                            child:

                            ListView.builder(
                              itemCount: cartItemList.length,
                              itemBuilder: (context, index) {
                                return CartItem(cartItemList.keys.toList()[index],
                                    cartItemList.values.toList()[index]);
                              },
                            )

                        )
                    ),
                    Container(
                        color: Color(0xFFF4F4F4),
                        child: Column(
                          children: [
                            // Container(
                            //   padding: const EdgeInsets.all(12.0),
                            //   margin: EdgeInsets.symmetric(horizontal:32),
                            //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text('Selected Item',style: TextStyle(fontSize: getFontSize(context, 3)),),
                            //       Text(' ',style: TextStyle(fontSize: getFontSize(context, 3)),)
                            //
                            //     ],),
                            // ),

                            Container(
                              padding: const EdgeInsets.all(12.0),
                              margin: EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${totalsResponse.subtotal}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery fee',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${totalsResponse.shippingTotal}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '(-) Discount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${totalsResponse.discountTotal}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            fontSize: getFontSize(context, 4),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '\$',
                                            style: TextStyle(
                                                fontSize:
                                                getFontSize(context, 3),
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                          Text(
                                            '${totalsResponse.total}',
                                            style: TextStyle(
                                                fontSize:
                                                getFontSize(context, 4),
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),


                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(CheckoutScreen.routeName);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Theme
                                            .of(context)
                                            .accentColor,
                                          Theme
                                              .of(context)
                                              .accentColor
                                        ])),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "ORDER NOW",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),

                  ],
                ),
              ):
              Container(
                child: Center(
                  child: Text('Your Cart is Empty.'),
                ),
              );
            }
        )
    );
  }
}