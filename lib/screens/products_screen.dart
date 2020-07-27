import 'package:barista/components/appbar.dart';
import 'package:barista/components/filter_ui.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: 'https://dpecom.beedevstaging.com',
      consumerKey: 'ck_8eae82f5a79ffa846d0df95902123b59bebb47fd',
      consumerSecret: 'cs_ec0bd45cbe8ae92f3384cf95f7c2e36a7573ce82',
      apiPath: '/wp-json/wc/v3/');
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(
            isLarge: _large,
          ),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                'https://www.baristasupplies.com.au/wp-content/uploads/2014/10/Espresso-Machine-Cleaner-Cafetto-1kg-300x300.jpg',
                width: _width * 0.8,
                alignment: Alignment.center,
              ),
              Text(
                'Espresso Machine Cleaner Cafetto (1kg)',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _large ? 26 : 25,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                '\$500',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: _large ? 22 : 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Availability: ',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: _large ? 20 : 18,
                          ),
                        ),
                        Text(
                          'In Stock',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: _large ? 20 : 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'SKU: ',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: _large ? 20 : 18,
                          ),
                        ),
                        Text(
                          'CF-PFD-1',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: _large ? 20 : 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black54),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                                  child: Container(
                      decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.all(Radius.circular(10)),),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(right:BorderSide())
                                ),
                            child: IconButton(icon: Icon(Icons.remove), onPressed:(){},color: kPrimaryColor),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                               border: Border(left:BorderSide())
                                ),
                                    child: IconButton(icon: Icon(Icons.add), onPressed:(){},color: kPrimaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width:20),
                  FlatButton(
                        color: kPrimaryColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.shopping_basket,color: Colors.white,),
                            SizedBox(width:8),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                ],
              ),
              SizedBox(height:15),
              Row(
                children: [
                  Icon(Icons.favorite_border,color: Colors.black54),
                  SizedBox(width: 6,),
                  Text(
                              'Add to Wishlist',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                ],
              ),
              SizedBox(height:15),
              Divider(color: Colors.black54),
              ExpansionTile(title: Text(
                              'Description',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),),
                            
              ExpansionTile(title: Text(
                              'Shipping',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),),
              ExpansionTile(title: Text(
                              'Reviews',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),),
                           
            ],
          )),
        )),
      ),
    );
  }
}
