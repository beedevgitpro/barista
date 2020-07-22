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
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String selectedNoOfItems='12';
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
                  padding: const EdgeInsets.symmetric(vertical:12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: _large?25:25,
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
                          SizedBox(width: 5,),
                          DropdownButton(
                            value: selectedNoOfItems,
                            items: [
                            DropdownMenuItem(child: Text('12',style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                            )),value: '12'),
                            DropdownMenuItem(child: Text('24',style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                            )),value: '24'),
                            DropdownMenuItem(child: Text('36',style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                            )),value: '36'),
                          ], onChanged: (value){
                            setState(() {
                              selectedNoOfItems=value;
                            });
                            
                          })
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
               
                
                 Wrap(
              //crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 10,
              spacing: 20,
           children: [
               for (var i = 0; i < int.parse(selectedNoOfItems); i++) 
               ProductListing(size: _large?200:180,)
           ], 
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:30.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){}, child: Container(
                padding:EdgeInsets.symmetric(vertical:8.0),
                width:_large?_width*0.2:_width*.28,
                color: Colors.black54,
                child: Text(
                  'Previous',style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                ),
              ),),
              SizedBox(width:15),
              GestureDetector(
                
                onTap: (){}, child: Container(
                  width: _large?_width*0.2:_width*.28,
                  padding:EdgeInsets.symmetric(vertical:8.0),
                  color: kPrimaryColor,
                  child: Text(
                  'Next',style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
              ),
                ),),
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
