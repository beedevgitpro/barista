import 'package:barista/components/cart_item.dart';
import 'package:barista/components/customLoader.dart';
import 'package:barista/providers/cart_provider.dart';
import 'package:barista/providers/customer_provider.dart';
import 'package:barista/providers/orders_provider.dart';
import 'package:barista/providers/payment_provider.dart';
import 'package:barista/request_models/create_order_request_model.dart';
import 'package:barista/response_models/customer_detail_response_model.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:barista/screens/payment_method.dart';
import 'package:barista/utility/PrefHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../responsive_text.dart';

class CheckoutScreen extends StatefulWidget {
  static var routeName = '/CheckoutScreen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController strPromo = TextEditingController();

  Map cartItemList;

  var paymentProvider;
  var customerProvider;

  final GlobalKey<ScaffoldState> _checkoutScreenKey =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getCustomerData();
    super.initState();
  }

  getCustomerData() async {
    await Provider.of<CustomerProvider>(context, listen: false)
        .getCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _checkoutScreenKey,
      appBar: AppBar(
        title: Text(
          'Checkout'.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black12,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery at',
                          style: TextStyle(
                              fontSize: getFontSize(context, 1),
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Consumer<CustomerProvider>(
                          builder: (ctx, customer, _) {
                            customerProvider = customer;
                            return Text(customer
                                .getCustomerDetail?.shipping?.address1 ??
                                'No Address Found');
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Text('Change',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
          Container(
              color: Color(0xFFF4F4F4),
              child: Consumer<CartProvider>(
                builder: (ctx, cart, _) {
                  cartItemList = cart.getCartItems;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartItemList.length,
                    itemBuilder: (context, index) {
                      return CartItem(cartItemList.keys.toList()[index],
                          cartItemList.values.toList()[index]);
                    },
                  );
                },
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Apply Promo Code',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: strPromo,
                  onChanged: (value) {
                    // strMobile.text = value;
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Theme.of(context).primaryColor,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter a valid promocode';
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'View Offers',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    hintText: 'Enter a promo code',
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Add Payment Method',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PaymentMethodScreen.routeName);
                  },
                  child: Consumer<PaymentProvider>(

                      builder: (ctx, paymentMethod, _) {
                        paymentProvider = paymentMethod;

                        return Card(
                          elevation: 0,
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                                topLeft: Radius.circular(2),
                                topRight: Radius.circular(2)),
                          ),
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // FittedBox(
                                      //   child: Image.network(widget._cartItem.imageUrl,
                                      //       fit: BoxFit.fill, height: 120, width: 120),
                                      // ),

                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FadeInImage(
                                            image: AssetImage(
                                                paymentMethod.getSelectedPayment
                                                    .icon),
                                            placeholder: AssetImage(
                                                'assets/images/no_image_placeholder.png'),
                                            height: 32,
                                            width: 32,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),

                                      Flexible(
                                          child: Text(
                                            paymentMethod.getSelectedPayment
                                                .methodName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          )),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
          ),
          Consumer<CartProvider>(
            builder: (ctx, cart, _) {
              var totalsResponse = cart.getTotals;
              return Container(
                padding: const EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${totalsResponse.subtotal}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery fee',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${totalsResponse.shippingTotal}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '(-) Discount',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ ${totalsResponse.discountTotal}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontSize: getFontSize(context, 3),
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              '${totalsResponse.total}',
                              style: TextStyle(
                                  fontSize: getFontSize(context, 4),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String userId = prefs.getString(PrefHelper.PREF_USER_ID);
              List<LineItem> lineItems = [];
              cartItemList.values.toList().forEach((element) {
                lineItems.add(LineItem(
                    productId: element.productId, quantity: element.quantity));
              });
              try {
                Ing shipping = customerProvider.getCustomerDetail?.shipping;
                Ing billing = customerProvider.getCustomerDetail?.billing;

                CreateOrderRequestModel createOrderRequestModel =
                    new CreateOrderRequestModel(
                        paymentMethod: paymentProvider.getSelectedPayment
                        .methodName,
                    paymentMethodTitle: paymentProvider.getSelectedPayment
                        .methodName,
                    customerId: int.parse(userId),
                    shipping: shipping,
                    billing: billing,
                    lineItems: lineItems,
                    setPaid: true);

                var prLoader = Loader(context);
                prLoader.show();
                Provider.of<OrderProvider>(context, listen: false).createOrder(
                    createOrderRequestModel).then((value) {
                  prLoader.hide();
                  if (value != null) {
                    _checkoutScreenKey.currentState.showSnackBar(
                        SnackBar(content: Text('Order Placed Successfully.')));
                    Navigator.pushReplacementNamed(
                        context, LandingScreen.routeName);
                  }
                });
              } catch (error) {
                print(error.toString());
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme
                            .of(context)
                            .accentColor,
                        Theme.of(context).accentColor
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
                      "PAY NOW",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFF4F4F4),
    );
  }
}
