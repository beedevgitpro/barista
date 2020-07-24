import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';

class ProductsListingScreen extends StatefulWidget {
  ProductsListingScreen({this.title});
  final String title;
  @override
  _ProductsListingScreenState createState() => _ProductsListingScreenState();
}

class _ProductsListingScreenState extends State<ProductsListingScreen> {
  final productListingScaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  double _pixelRatio;
  bool _isOpen = false;
  bool _large;
  bool _medium;
  double min = 0, max = 200;
  int start = 0, end = 200;
  String selectedNoOfItems = '12';
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        key: productListingScaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: _isOpen ?? false
              ? () {
                  //sheetController.closed.then((value) => print('sheetclosed'));

                  setState(() {
                    _isOpen = false;
                  });
                  Navigator.pop(context);
                }
              : () {
                  productListingScaffoldKey.currentState
                      .showBottomSheet((context) => Container(
                            color: Colors.white,
                            height: _height * 0.3,
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Filter by price:',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _large ? 22 : 18,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: _width * 0.7,
                                        child: RangeSlider(
                                          values: RangeValues(
                                              start.toDouble(), end.toDouble()),
                                          onChanged: (values) {
                                            setState(() {
                                              start = values.start.round();
                                              end = values.end.round();
                                              print(start);
                                            });
                                          },
                                          min: 0,
                                          max: 200,
                                          labels: RangeLabels('0', '200'),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '200 - 300',
                                      style: TextStyle(
                                        fontFamily: kDefaultFontFamily,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: _large ? 26 : 25,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
                  setState(() {
                    _isOpen = true;
                  });
                  print(_isOpen);
                },
          child: Icon(_isOpen ?? false ? Icons.clear : Icons.tune),
          backgroundColor: _isOpen ?? false ? Colors.red : kPrimaryColor,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(),
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
                  child: _large?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
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
                              fontSize: 22,
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
                                        fontSize: 22,
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
                                        fontSize: 22,
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
                                        fontSize: 22,
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
                  ):
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: const EdgeInsets.only(left: 10.0),
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
                        padding:  EdgeInsets.symmetric(horizontal:10.0),
                        child: Row(
                          children: [
                            Text(
                              'Show:',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: _large?22:18,
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
                                          fontSize: _large?22:18,
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
                                          fontSize: _large?22:18,
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
                                          fontSize: _large?22:18,
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
                  )
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  //crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 20,
                  children: [
                    for (var i = 0; i < int.parse(selectedNoOfItems); i++)
                      ProductListing(
                        size: _large ? 200 : 180,
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
                              fontSize: 22,
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
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
