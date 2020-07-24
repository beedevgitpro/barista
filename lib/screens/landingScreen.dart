import 'package:barista/components/appbar.dart';
import 'package:barista/components/category_card.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  SharedPreferences prefs;
  Widget browseCategories() {
    return Container(
        color: Colors.black12,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Browse our Categories'.toUpperCase(),
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < 10; i++)
                      CategoryCard(size:_large?225:200,src:'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Coffee-Storage-300x300.png')
                  ],
                ),
              ),
            )
          ],
        ));
  // }
}

Widget justArrived(){
  return Container(
    //color: Colors.black12,
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0,horizontal:5),
              child: Text(
                'Just Arrived'.toUpperCase(),
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
        Wrap(
          //crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 10,
         children: [
           for (var i = 0; i < 10; i++) 
           ProductListing(size: _large?200:180,)
         ], 
        ),
      ],
    ),
  );
}
Widget blogPosts(BuildContext context){
  return Container(
    padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                Text(
                  'Latest Blog Posts'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
             
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < 10; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // color: Colors.black12,
                       width: MediaQuery.of(context).size.width*0.9, 
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                           children: [
                             Image.network('https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Temptag-Pro-400x220.jpg',height:MediaQuery.of(context).size.width*0.4/1.8,width: MediaQuery.of(context).size.width*0.4,)
                           ], 
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                                                      child: FlatButton(
                              color: kPrimaryColor,
                              onPressed: (){},
                              child: Text(
                  'Read More'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),),
                          )
                        ], 
                       ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
  );
}
Widget featuredProducts(){
  // const FeaturedProducts({
  // });
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Featured Products'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                   
                  ],
                ),
                Row(children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      onPressed: null)
                ]),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [for (var i = 0; i < 10; i++) Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: ProductListing(size: _large?225:200,),
                  )],
                ),
              ),
            )
          ],
        ));
}
@override
  void initState() {
    SharedPreferences.getInstance().then((value) => prefs=value);
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
          child: BaristaAppBar(),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _large?
                    Container(
                      height: 350.0,
                      child: Row(children: [
                        Expanded(flex: 2,child: ImagePanel(
                          src:
                              'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitchers-blue-.png',
                          onTap: () {}),),
                        Expanded(
                          flex: 1,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(flex: 1,child:  ImagePanel(
                      src:
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Cafetto-Cleaning.jpg',
                      onTap: () {}),),
                              Expanded(flex:1,child: ImagePanel(
                      src:
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Coffee-Tampers.jpg',

                      onTap: () {}),)
                            ],
                          ),
                        ),
                        Expanded(flex: 1,child:ImagePanel(
                      src:
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitcher-blue-.png',
                      onTap: () {}),)
                      ],),
                    )
                    :Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImagePanel(
                        src:
                            'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitchers-blue-.png',
                        onTap: () {}),
                     ImagePanel(
                    src:
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Cafetto-Cleaning.jpg',
                    onTap: () {}),
                ImagePanel(
                    src:
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Coffee-Tampers.jpg',
                    onTap: () {}),
                    ImagePanel(
                    src:
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitcher-blue-.png',
                    onTap: () {}),
                  ],
                ),
                featuredProducts(),
                SizedBox(height: 10),
                browseCategories(),
                SizedBox(height: 10),
                justArrived(),
                SizedBox(height:10),
                // blogPosts(context),
                // SizedBox(height:10),
                // Container(
                //   padding: EdgeInsets.all(15),
                //   width: double.infinity,
                //   alignment: Alignment.center,
                //   color: kPrimaryColor,
                //  child: Text('© Copyright 2020. All Rights Reserved.',style: TextStyle(
                //   color: Colors.white,
                //   fontFamily: kDefaultFontFamily,
                //   fontSize: 16,
                //  ),), 
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class ImagePanel extends StatelessWidget {
  const ImagePanel({
    this.src,
    this.onTap,
  });
  final String src;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(3),
        child: GestureDetector(
            onTap: onTap,
            child: Image.network(src,
                alignment: Alignment.center, fit: BoxFit.contain)));
  }
}
