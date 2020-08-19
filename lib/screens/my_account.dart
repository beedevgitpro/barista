import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';

typedef void SetValue(String value);
typedef void ValidationFunction(String value);

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with SingleTickerProviderStateMixin {
  final _accountDetailsFormKey = GlobalKey<FormState>();
  TabController _tabController;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool autovalidate = false, errFlag = false;
  int userID;
  final currentPasswordNode = FocusNode();
  final enquiryTypeNode = FocusNode();
  final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final displayNameNode = FocusNode();
  final phoneNode = FocusNode();
  final emailNode = FocusNode();
  final messageNode = FocusNode();
  bool _loading=true;
  WooCustomer customer;
  TextEditingController  newPasswordController=TextEditingController();
  TextEditingController  emailController=TextEditingController();
  TextEditingController  firstNameController=TextEditingController();
  TextEditingController  lastNameController=TextEditingController();
  TextEditingController  currentPasswordController=TextEditingController();
  TextEditingController  confirmPasswordController=TextEditingController();
  TextEditingController  displayNameController=TextEditingController();
  String selectedType = 'Sales';
  final WooCommerce woocommerce = WooCommerce(
    baseUrl: kBaseUrl,
    consumerKey: kConsumerKey,
    consumerSecret: kConsumerSecret,
  );

  Widget addressesScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Billing Address',
                        style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            fontSize: getFontSize(context, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: kPrimaryColor,
                            size: 35,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAddress(isBilling: false,customer: customer,)));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            fontSize: getFontSize(context, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle,
                            color: kPrimaryColor, size: 35),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAddress(isBilling: false,customer: customer,)));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildCustomTextField(TextEditingController _textController, String labelText,
      ValidationFunction validator, FocusNode fNode, FocusNode nextNode,
      {bool isNumber = false}) {
    return Container(
      width: _large ? _width * 0.4 : _width,
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onFieldSubmitted: (value) {
          nextNode == null
              ? FocusScope.of(context).unfocus()
              : nextNode.requestFocus();
        },
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        inputFormatters: isNumber
            ? [
                WhitelistingTextInputFormatter.digitsOnly,
              ]
            : [],
        focusNode: fNode,
        controller: _textController,
        cursorColor: kPrimaryColor,
        textInputAction:
            nextNode == null ? TextInputAction.done : TextInputAction.next,
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

  Widget buildAccountDetailsForm() {
    return _loading?
    Center(child: SpinKitDualRing(color: kPrimaryColor,size:40))
    :Form(
      key: _accountDetailsFormKey,
      autovalidate: autovalidate,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 10,
        children: [
          buildCustomTextField(
              
                firstNameController
              ,
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
             
                lastNameController,
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
            emailController,
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
              displayNameNode),
          buildCustomTextField(
              
                displayNameController,
              'Display Name',
              (value) {
                if (value.isEmpty) {
                  if (!errFlag) {
                    errFlag = true;
                    displayNameNode.requestFocus();
                  }
                  return 'Required';
                }
              },
              displayNameNode,
              phoneNode),
          buildCustomTextField(
                currentPasswordController ,
              'Current Password',
              (value) {
                if(currentPasswordController.text.isNotEmpty && newPasswordController.text.isEmpty)
                  return 'Please confirm the new Password';
                else if(confirmPasswordController.text !=newPasswordController.text)
                  return 'Confirm Password & Password fields must match';
                return null;
              },
              phoneNode,
              currentPasswordNode),
          buildCustomTextField(
                newPasswordController,
              'New Password',
              (value) {
                return null;
              },
              currentPasswordNode,
              null),
          buildCustomTextField(
              
                confirmPasswordController,
              'Confirm New Password',
              (value) {
                if(newPasswordController.text.isNotEmpty && confirmPasswordController.text.isEmpty)
                  return 'Please confirm the new Password';
                return null;
              },
              currentPasswordNode,
              null),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () {
                if (_accountDetailsFormKey.currentState.validate()) {
                } else {
                  autovalidate = true;
                }
              },
              color: kPrimaryColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: getFontSize(context, 0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ordersScreen() {
    return StreamBuilder(
        stream: woocommerce
            .getOrders(customer: userID)
            .asStream()
            .asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Text(
              'No orders to display',
              style: TextStyle(fontFamily: kDefaultFontFamily, fontSize: getFontSize(context, 0)),
            ));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                for (WooOrder order in snapshot.data)
                  ListTile(
                    leading: Text(
                      order.dateCreated,
                      style: TextStyle(
                          fontFamily: kDefaultFontFamily, fontSize: getFontSize(context, -2)),
                    ),
                    title: Text(
                      order.number,
                      style: TextStyle(
                          fontFamily: kDefaultFontFamily, fontSize: getFontSize(context, -2)),
                    ),
                    subtitle: Text(
                      order.total,
                      style: TextStyle(
                          fontFamily: kDefaultFontFamily, fontSize: getFontSize(context, -2)),
                    ),
                    trailing: Column(
                      children: [
                        FlatButton(
                            color: kPrimaryColor,
                            onPressed: () {},
                            child: Text(
                              'View',
                              style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  fontSize: getFontSize(context, -2),
                                  color: Colors.white),
                            )),
                        Text(
                          order.status,
                          style: TextStyle(
                              fontFamily: kDefaultFontFamily, fontSize: getFontSize(context, -2)),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        userID = value.getInt('userID');
        woocommerce.getCustomerById(id: userID).then(
          (value){
            customer=value;
            emailController.text=customer.email;
            firstNameController.text=customer.firstName;
            lastNameController.text=customer.lastName;
            displayNameController.text=customer.username;
            setState(() {
               _loading=false;
            });
            });
      });
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    newPasswordController.dispose();
    emailController.dispose();
    displayNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    currentPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge: _large),
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
                          child: Text('Account',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: kDefaultFontFamily,
                                fontSize: getFontSize(context, 0),
                              ))),
                      Tab(
                          child: Text('Addresses',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: kPrimaryColor,
                                fontSize: getFontSize(context, 0),
                              ))),
                      Tab(
                          child: Text('Orders',
                              style: TextStyle(
                                fontFamily: kDefaultFontFamily,
                                color: kPrimaryColor,
                                fontSize: getFontSize(context, 0),
                              )))
                    ],
                    controller: _tabController,
                  )),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  buildAccountDetailsForm(),
                  addressesScreen(),
                  ordersScreen()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
