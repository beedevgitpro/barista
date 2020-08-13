import 'package:barista/components/appbar.dart';
import 'package:barista/components/filter_ui.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/components/shipping_table.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart' show parse;

class ProductScreen extends StatefulWidget {
  ProductScreen({this.product});
  final WooProduct product;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
   final WooCommerce woocommerce = WooCommerce(
      baseUrl: 'https://revamp.baristasupplies.com.au/',
      consumerKey: 'ck_4625dea30b0c7207161329d3aaf2435b38da34ae',
      consumerSecret: 'cs_e43af5c06ecb97a956af5fd44fafc0e65962d32c',
      apiPath: '/wp-json/wc/v3/');
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  WooProduct product;
  int qty=1;
  getShippingMethods(){
    woocommerce.getShippingZones().then((value){
      for(WooShippingZone method in value){
        print('Method: '+method.name);
      }
    });
  }
  @override
  void initState() {
    product=widget.product;
    getShippingMethods();
    super.initState();
  }
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
          padding: EdgeInsets.all(0.0),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Image.network(
                  product.images[0].src,
                  width: _width * 0.8,
                  alignment: Alignment.center,
                ),
                Text(
                  product.name,
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: _large ? 26 : 25,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  '\$${product.price}',
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
                            'Availability: '.toUpperCase(),
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: _large ? 20 : 18,
                            ),
                          ),
                          Text(
                            '${product.stockStatus}'.toUpperCase(),
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
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: _large ? 20 : 18,
                            ),
                          ),
                          Text(
                            '${product.sku}'.toUpperCase(),
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
                              child: IconButton(icon: Icon(Icons.remove), onPressed:(){
                                if(qty>1)
                                setState(() {
                                  qty--;
                                });
                                },color: kPrimaryColor),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '$qty',
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
                                      child: IconButton(icon: Icon(Icons.add), onPressed:(){
                                         setState(() {
                                  qty++;
                                });
                                      },color: kPrimaryColor),
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
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false).add(product.id.toString(), qty, product.price.toString());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.shopping_basket,color: Colors.white,),
                              SizedBox(width:8),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.white,
                                  
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                  ],
                ),
                SizedBox(height:15),
                FlatButton(
                  onPressed: () {
                           
                          },
                                  child: Row(
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
                ),
                SizedBox(height:15),
                Divider(color: Colors.black54,height: 0,),
                ExpansionTile(title: Text(
                                'Description',
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),children: [
                                // .replaceAll('<p>','').replaceAll('</p>','')
                                Text(parse(product.description).outerHtml,style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),)
                              ],),
                              Divider(color: Colors.black54,height: 0,),
                ExpansionTile(title: Text(
                                'Shipping',
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),children: [
                                ShippingTable()
                              ],),
                              Divider(color: Colors.black54,height: 0,),
                // ExpansionTile(title: Text(
                //                 'Reviews',
                //                 style: TextStyle(
                //                   fontFamily: kDefaultFontFamily,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 18,
                //                 ),
                //               ),
                //               children: [
                //                 for(WooProductReview review in product.)
                //               ],
                //               ),
                             
            ],
          ),
              )),
        )),
      ),
    );
  }
}
