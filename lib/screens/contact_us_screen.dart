import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/cart_screen.dart';
import 'package:flutter/material.dart';
typedef void setValue(String value);
typedef void validationFunction(String value);
class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with SingleTickerProviderStateMixin {
     final _contactUsScaffoldKey=GlobalKey<ScaffoldState>();
  TabController _tabController;
  double _height;
  double _width;
  double _pixelRatio;
  
  bool errFlag = false,autovalidate=false;
   final orderNumberNode = FocusNode();
   final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final bNameNode = FocusNode();
  final phoneNode = FocusNode();
  final emailNode = FocusNode();
  final messageNode = FocusNode();
  List enquirySubject=['Sales','Returns','Accounts','Wholesale','Other Enquiry'];
  bool _large;
  bool _medium;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          key: _contactUsScaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: AppBar(
                elevation: 3,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu,
                            color: Color(0xff152f51), //Colors.black,
                            size: _large ? 35 : 30),
                        onPressed: () {
                          _contactUsScaffoldKey.currentState.openDrawer();
                        },
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.account_circle,
                                  color: Color(0xff152f51), //Colors.black,
                                  size: _large ? 35 : 30),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.shopping_basket,
                                  color: Color(0xff152f51), //Colors.black,
                                  size: _large ? 35 : 30),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              })
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            drawer: NavigationDrawer(),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                      height: _height * 0.08,
                      child: TabBar(
                        tabs: [
                          Tab(
                              child: Text('Visit Us',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                  ))),
                          Tab(
                              child: Text('Enquire Now',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                  )))
                        ],
                        controller: _tabController,
                      )),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      buildVisitUsTab(),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          runSpacing: 10,
                          children: [

                          ],
                      )
                    ]),
                  ),
                ],
              ),
            ),),);}

  Column buildVisitUsTab() {
    return Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: kPrimaryColor,
                                        size: 35,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${_large?'Address: ':''}11/76 Rushdale St, Knoxfield, Victoria 3180, Australia.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontFamily: kDefaultFontFamily,
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: kPrimaryColor,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${_large?'Phone Number: ':''}(03) 8288 2399',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontFamily: kDefaultFontFamily,
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: kPrimaryColor,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${_large?'Email: ':''}info@baristasupplies.com.au',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontFamily: kDefaultFontFamily,
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: kPrimaryColor,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        '${_large?'Business Hours: ':''}Monday - Friday 9am to 5pm AEST',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18,
                                          fontFamily: kDefaultFontFamily,
                                        ),
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Image.network(
                              'https://www.google.com/maps/about/images/mymaps/mymaps-desktop-16x9.png',
                              fit: BoxFit.fill,
                            ))
                      ],
                    );
  }
            Container buildCustomTextField(setValue setval, String labelText, validationFunction validator, FocusNode fNode, FocusNode nextNode) {
    return Container(
      width: _large ? _width * 0.4 : _width,
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onFieldSubmitted: (value) {
          nextNode==null?FocusScope.of(context).unfocus():nextNode.requestFocus();
        },
        focusNode: fNode,
        onChanged: setval,
        cursorColor: kPrimaryColor,
        textInputAction: nextNode==null?TextInputAction.done:TextInputAction.next,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: kPrimaryColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
