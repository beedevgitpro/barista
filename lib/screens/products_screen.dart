import 'package:barista/components/appbar.dart';
import 'package:barista/components/customLoader.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/shipping_table.dart';
import 'package:barista/constants.dart';

import 'package:barista/models/wishlist_model.dart';
import 'package:barista/providers/cart_provider.dart';
import 'package:barista/providers/products_provider.dart';
import 'package:barista/request_models/add_to_cart_request_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = '/ProductScreen';


  ProductScreen();
 // final WooProduct product;
  @override
  _ProductScreenState createState() => _ProductScreenState();
}
class _ProductScreenState extends State<ProductScreen> {
   final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
  double _width;
  double _pixelRatio;
  bool _large;
  bool _addedToWishlist=false;
  final _productScreenKey=GlobalKey<ScaffoldState>();
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
    getShippingMethods();
    super.initState();
  }

   void showAddToCartSheet(BuildContext context) {
     showModalBottomSheet<void>(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(12),
           topRight: Radius.circular(12),
         ),
       ),
       context: context,
       builder: (BuildContext context) {
         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             height: MediaQuery.of(context).size.height * 0.10,
             color: Colors.red,
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(
                       '${qty} Item',
                       style: TextStyle(
                           fontSize: 18,
                           color: Colors.white,
                           fontWeight: FontWeight.bold),
                     ),
                     Text(
                       '\$${product.price == '' ? 0 : product.price * qty ?? 0}',
                       style: TextStyle(
                           fontSize: 20,
                           color: Colors.white,
                           fontWeight: FontWeight.bold),
                     )
                   ],
                 ),
                 InkWell(
                   onTap: () async {
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamed(CartScreen.routeName);
                   },
                   child: Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         const Text(
                           'View Cart',
                           style: TextStyle(
                               fontSize: 20,
                               color: Colors.white,
                               fontWeight: FontWeight.bold),
                         ),
                         Icon(
                           Icons.arrow_right,
                           color: Colors.white,
                           size: 40,
                         )
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),
         );
       },
     );
   }
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);

    var productId = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        key: _productScreenKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(
            isLarge: _large,
          ),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: FutureBuilder(
    future: Provider.of<ProductsProvider>(context, listen: false)
        .getProductOnId(productId),
          builder:(ctx,snapshot){
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Container(
    child: Center(child: CircularProgressIndicator(),));
    }
    else if (!snapshot.hasData) {
    return Container(child: Text('Oops something went wrong'),);
    }
    product = snapshot.data;

      return
    SafeArea(
              child: Padding(
            padding: EdgeInsets.all(0.0),
            child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.all(10.0),
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
                    padding:  EdgeInsets.symmetric(vertical: 10.0),
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
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    '$qty',
                                    style: TextStyle(
                                      fontFamily: kDefaultFontFamily,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: getFontSize(context, 4),
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
                            onPressed: (){
                              AddToCartRequestModel addToCartRequestModel = new AddToCartRequestModel(
                                  productId: product.id
                                      .toString(),
                                  quantity: qty);
                              var prLoader = Loader(context);
                              prLoader.show();
                              Provider.of<CartProvider>(
                                  context, listen: false)
                                  .addCartItem(
                                  addToCartRequestModel)
                                  .then((value) {
                                prLoader.hide();
                                if (value) {
                                  showAddToCartSheet(context);
                                }
                                else {
                                  _productScreenKey.currentState
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                          'Add To Cart Failed')));
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.shopping_basket,color: Colors.white,),
                                SizedBox(width:9),
                                Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.white,
                                    fontSize: getFontSize(context, 4),
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
                             Provider.of<WishlistModel>(context, listen: false).add(product.id.toString(), qty, product.price.toString());
                             _productScreenKey.currentState.showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,backgroundColor: kPrimaryColor,content:Text(
                                  'Added to Wishlist!',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.white,
                                    fontSize: getFontSize(context, 0),
                                  ),
                                ) ,));
                                setState(() {
                                  _addedToWishlist=!_addedToWishlist;
                                });
                            },
                                    child: Row(
                      children: [
                        Icon(_addedToWishlist?Icons.favorite:Icons.favorite_border,color: kPrimaryColor),
                        SizedBox(width: 6,),
                        Text(
                                    'Add to Wishlist',
                                    style: TextStyle(
                                      fontFamily: kDefaultFontFamily,
                                      color: Colors.black,
                                      fontSize: getFontSize(context, 0),
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
                                    fontSize: getFontSize(context, 0),
                                  ),
                                ),children: [

                                  Text(product.description,style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.black,
                                    fontSize: getFontSize(context, -3),
                                  ),)
                                ],),
                                Divider(color: Colors.black54,height: 0,),
                  ExpansionTile(title: Text(
                                  'Shipping',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getFontSize(context, 0),
                                  ),
                                ),children: [
                                  ShippingTable()
                                ],),
                                Divider(color: Colors.black54,height: 0,),
              ],
            ),
                )),
          ));}
        ),
      )
    );
  }
}