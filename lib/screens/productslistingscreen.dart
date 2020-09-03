import 'package:barista/components/appbar.dart';
import 'package:barista/components/filter_ui.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductsListingScreen extends StatefulWidget {
  ProductsListingScreen({this.title,@required this.categoryID});
  final String title;
  final int categoryID;
  @override
  _ProductsListingScreenState createState() => _ProductsListingScreenState();
}

class _ProductsListingScreenState extends State<ProductsListingScreen> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');

  final productListingScaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  double _pixelRatio;
  bool _isOpen = false;
  bool _large;
  var sheetController;
  double min = 0, max = 200;
  int start, end;
  String selectedNoOfItems = '12';
  List<WooProduct> myProducts = [];
  @override
  void initState() {
    start = min.toInt();
    end = max.toInt();
    super.initState();
  }
  getCategories(){
    woocommerce.getProductCategories(parent:0).then((value) {
      print(value.length);
      for(WooProductCategory category in value)
        print(category.name);
    });
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        key: productListingScaffoldKey,
        floatingActionButton: _isOpen
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  Alert(
                    style: AlertStyle(
                     isCloseButton: false 
                    ),
                    context: context, title: 'Filters',content:FilterUI(),buttons: [
                    DialogButton(child: Text('Apply Filters',style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: _large ? 20 : 18,
                            )), onPressed: (){
                              Navigator.pop(context);
                            })
                  ]).show();
                },
                child: Icon(_isOpen ?? false ? Icons.clear : Icons.tune),
                backgroundColor: _isOpen ?? false ? Colors.red : kPrimaryColor,
              ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(
            isLarge: _large,
          ),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: _large
                        ? Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _large ? 26 : 25,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Show:',
                                    style: TextStyle(
                                      fontFamily: kDefaultFontFamily,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: getFontSize(context, 4),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  DropdownButton(
                                      value: selectedNoOfItems,
                                      items: [
                                        DropdownMenuItem(
                                            child: Text(
                                              '12',
                                              style: TextStyle(
                                                fontFamily: kDefaultFontFamily,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: getFontSize(context, 4),
                                              ),
                                            ),
                                            value: '12'),
                                        DropdownMenuItem(
                                            child: Text(
                                              '24',
                                              style: TextStyle(
                                                fontFamily: kDefaultFontFamily,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: getFontSize(context, 4),
                                              ),
                                            ),
                                            value: '24'),
                                        DropdownMenuItem(
                                            child: Text(
                                              '36',
                                              style: TextStyle(
                                                fontFamily: kDefaultFontFamily,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: getFontSize(context, 4),
                                              ),
                                            ),
                                            value: '36'),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedNoOfItems = value;
                                        });
                                      })
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _large ? 26 : 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Show:',
                                      style: TextStyle(
                                        fontFamily: kDefaultFontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: _large ? 22 : 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    DropdownButton(
                                        value: selectedNoOfItems,
                                        items: [
                                          DropdownMenuItem(
                                              child: Text(
                                                '12',
                                                style: TextStyle(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: _large ? 22 : 18,
                                                ),
                                              ),
                                              value: '12'),
                                          DropdownMenuItem(
                                              child: Text(
                                                '24',
                                                style: TextStyle(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: _large ? 22 : 18,
                                                ),
                                              ),
                                              value: '24'),
                                          DropdownMenuItem(
                                              child: Text(
                                                '36',
                                                style: TextStyle(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: _large ? 22 : 18,
                                                ),
                                              ),
                                              value: '36'),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedNoOfItems = value;
                                          });
                                        })
                                  ],
                                ),
                              ),
                            ],
                          )),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: woocommerce.getProducts(perPage: int.parse(selectedNoOfItems),category: '${widget.categoryID}').asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          height: _height*0.7,
                          child: Center(
                            child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SpinKitDualRing(size: 50, color: kPrimaryColor),
                                ),
                          ),
                        );
                      }
                      

                      return Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            spacing: 20,
                            children: [
                              for (WooProduct product in snapshot.data)
                                if (product.name != '')
                                  
                                  if (product.images.isNotEmpty)
                                    ProductListing(
                                        size: _large ? 200 : 180,
                                        productName: product.name,
                                        img: product.images[0].src,
                                        price: product.price.toString(),
                                        regularPrice:product.regularPrice.isEmpty?'0':product.regularPrice,
                                        product: product,
                                        )
                            ],
                          ),
                          Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          width: _large ? _width * 0.2 : _width * .28,
                          color: Colors.black54,
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: getFontSize(context, 4),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: _large ? _width * 0.2 : _width * .28,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          color: kPrimaryColor,
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: getFontSize(context, 4),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                        ],
                      );
                    }),
                
              ]),
            ),
          ),
        ),
      ),
    );
  }
  Container buildFilterUI() {
    return Container(
    
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:10),
     child:Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Column(
           children: [
             Divider(color: Colors.black,thickness: 3,indent: _width*0.4,endIndent: _width*0.4,),
             
         Divider(color: Colors.black,thickness: 3,height: 1,indent: _width*0.4,endIndent: _width*0.4,),
           ],
         ),
         Text('Filter by price',style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _large ? 20 : 18,
                        ),textAlign: TextAlign.start,),
        
          
          RangeSlider(activeColor: kPrimaryColor,inactiveColor: Colors.blueGrey,values: RangeValues(start.toDouble(),end.toDouble()), labels: RangeLabels('$start', '$end'),onChanged:(value){
            setState(() {
              start=value.start.round();
              end=value.end.round();
              print('$start ' + '$end');
            });
          },min:min.toDouble(),max:max.toDouble()),
        
        Text('\$$start to \$$end',style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _large ? 20 : 18,
                        ),textAlign: TextAlign.center),
                //         SizedBox(height:_height*0.02),
                // FlatButton(onPressed: (){}, color: kPrimaryColor,child:),
                // SizedBox(height: _height*0.03,),
     ],) 
    );
  }
}
