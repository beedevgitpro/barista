import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/components/wishlist_item.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
          child: BaristaAppBar(isLarge:_large),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
                          padding: const EdgeInsets.only(left:10.0,top:10),
                          child: Text(
                            'Wishlist',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: _large?26:24,
                            ),
                          ),
                        ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Wrap(
                  //crossAxisAlignment: WrapCrossAlignment.center,
                  //alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 20,
               children: [
                   for (var i = 0; i < 5; i++) 
                   WishlistItem(width: _large?_width*0.5:_width,title: '8oz Ivory Chai Sttoke usable Cup',)
               ], 
              ),
            ),
           ], 
          ),
        ),), 
      ),
    );
  }
}