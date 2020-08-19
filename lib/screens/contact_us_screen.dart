import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
typedef void SetValue(String value);
typedef void ValidationFunction(String value);
class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with SingleTickerProviderStateMixin {
     final _contactUsScaffoldKey=GlobalKey<ScaffoldState>();
     final _enquiryFormKey=GlobalKey<FormState>();
  TabController _tabController;
  double _height;
  double _width;
  double _pixelRatio;
  String phone,email,firstName,lastName,orderNumber,companyName,selectedType='Sales';
  bool errFlag = false,autovalidate=false;
  Map enquiryTypes = {
    'Sales': 'Sales',
    'Returns': 'Returns',
    'Accounts': 'Accounts',
    'Wholesale': 'Wholesale',
    'Other Enquiry': 'Other Enquiry'
   
  };
   final orderNumberNode = FocusNode();
   final enquiryTypeNode = FocusNode();
   final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final companyNameNode = FocusNode();
  final phoneNode = FocusNode();
  final emailNode = FocusNode();
  final messageNode = FocusNode();
  List enquirySubject=['Sales','Returns','Accounts','Wholesale','Other Enquiry'];
  bool _large;

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
                                    fontSize: getFontSize(context, 0),
                                  ))),
                          Tab(
                              child: Text('Enquire Now',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getFontSize(context, 0),
                                  )))
                        ],
                        controller: _tabController,
                      )),
                  Expanded(
                    child: TabBarView(controller: _tabController, children: [
                      buildVisitUsTab(),
                      buildEnquiryForm()
                    ]),
                  ),
                ],
              ),
            ),),);}

  Form buildEnquiryForm() {
    return Form(
      key: _enquiryFormKey,
      autovalidate: autovalidate,
          child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            buildCustomTextField(
                                (value) {
                                  firstName = value;
                                },
                                'First Name',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      fNameNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                fNameNode,
                                lNameNode),
                            buildCustomTextField(
                                (value) {
                                  lastName = value;
                                },
                                'Last Name',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      lNameNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                lNameNode,
                                emailNode),
                                buildCustomTextField(
                                (value) {
                                  email = value;
                                },
                                'Email Address',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      emailNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                emailNode,
                                companyNameNode),
                                buildCustomTextField(
                                (value) {
                                  companyName = value;
                                },
                                'Company Name',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      companyNameNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                companyNameNode,
                                phoneNode),
                                 buildCustomTextField(
                                (value) {
                                  phone = value;
                                },
                                'Phone Number',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      phoneNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                phoneNode,
                                orderNumberNode,isNumber:true),
                                buildCustomTextField(
                                (value) {
                                  orderNumber = value;
                                },
                                'Order Number (If relevant)',
                                (value) {
                                  return null;
                                
                                },
                                orderNumberNode,
                                null),
                                buildEnquiryTypeDropdown(),
                                Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    onPressed: (){
                                      if(_enquiryFormKey.currentState.validate())
                                      {

                                      }else{
                                        autovalidate=true;
                                      }
                                    },
                                    color: kPrimaryColor,
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal:12.0,vertical: 10),
                                      child: Text('Send Message',style: TextStyle(fontFamily: kDefaultFontFamily,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: getFontSize(context, 0),),),
                                    ),
                                  ),
                                )
                          ],
                      ),
    );
  }

  Padding buildEnquiryTypeDropdown() {
    return Padding(
                          padding: EdgeInsets.all(_large ? 0 : 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: _large ? _width * 0.4 : _width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButtonFormField(
                                    hint: Text('Select Enquiry Type',
                                        style: TextStyle(
                                          fontFamily: kDefaultFontFamily,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: getFontSize(context, -2),
                                        )),
                                    value: selectedType,
                                    items: [
                                      for (String enquiryType in enquiryTypes.keys)
                                        DropdownMenuItem(
                                            child: Text(enquiryType.toString(),
                                                style: TextStyle(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontSize: getFontSize(context, -2),
                                                )),
                                            value: enquiryTypes[enquiryType].toString())
                                    ],
                                    validator: (value) {
                                      if (value == null) {
                                        if (!errFlag) {
                                          errFlag = true;
                                          enquiryTypeNode.requestFocus();
                                        }
                                        return 'Selection required!';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType= value;
                                        messageNode.requestFocus();
                                      });
                                    }),
                              ),
                            ),
                          ),
                        );
  }

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
                                          fontSize: getFontSize(context, 0),
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
                                          fontSize: getFontSize(context, 0),
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
                                          fontSize: getFontSize(context, 0),
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
                                          fontSize: getFontSize(context, 0),
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
            Container buildCustomTextField(SetValue setval, String labelText, ValidationFunction validator, FocusNode fNode, FocusNode nextNode,{bool isNumber=false}) {
    return Container(
      width: _large ? _width * 0.4 : _width,
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onFieldSubmitted: (value) {
          nextNode==null?FocusScope.of(context).unfocus():nextNode.requestFocus();
        },
        keyboardType: isNumber?TextInputType.phone:TextInputType.text,
        inputFormatters: isNumber?[
          WhitelistingTextInputFormatter.digitsOnly,
        ]:[],
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
