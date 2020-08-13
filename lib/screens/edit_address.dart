import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';
typedef void setValue(String value);
typedef void validationFunction(String value);
class EditAddress extends StatefulWidget {
  EditAddress({this.customer});
  WooCustomer customer;
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _addressFormKey=GlobalKey<FormState>();
  final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final bNameNode = FocusNode();
  final streetNode = FocusNode();
  final suburbNode = FocusNode();
  final stateNode = FocusNode();
  final postcodeNode = FocusNode();
  bool errFlag=false;
   Map states = {
    'Australian Capital Territory': 'ACT',
    'Northern Territory': 'NT',
    'South Australia': 'SA',
    'Queensland': 'QLD',
    'New South Wales': 'NSW',
    'Tasmania': 'TAS',
    'Victoria': 'VIC',
    'Western Australia': 'WA'
  };
  String firstName,
      lastName,
      businessName,suburb,selectedState,streetAddress,postcode;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large,_medium;
  int userID;
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: 'https://revamp.baristasupplies.com.au/',
      consumerKey: 'ck_4625dea30b0c7207161329d3aaf2435b38da34ae',
      consumerSecret: 'cs_e43af5c06ecb97a956af5fd44fafc0e65962d32c',
      );
  @override
  void initState() {
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
       appBar:PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
         backgroundColor: Colors.white,
            drawer: NavigationDrawer(),
          body: SafeArea(child: SingleChildScrollView(child: Column(children: [
            Form(
                      key: _addressFormKey,
                      child: Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            buildCustomTextField(widget.customer.billing.firstName,
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
                            buildCustomTextField(widget.customer.billing.lastName,
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
                                bNameNode),
                            buildCustomTextField('',
                                (value) {
                                  businessName = value;
                                },
                                'Company',
                                (value){return null;},
                                bNameNode,
                                streetNode),
                            
                            buildCustomTextField(widget.customer.billing.address1,
                                (value) {
                                  streetAddress = value;
                                },
                                'Street Address',
                                (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      streetNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                streetNode,
                                suburbNode),
                            buildCustomTextField(widget.customer.billing.city,
                                (value) {
                                  suburb = value;
                                },
                                'Suburb',
                                (value) {
                                  if (value.isEmpty) {
                                    {
                                      if (!errFlag) errFlag = true;
                                      suburbNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                suburbNode,
                                null),
                            Padding(
                              padding: EdgeInsets.all(_large ? 0 : 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: _large ? _width * 0.4 : _width,
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonFormField(
                                        hint: Text('Select State',
                                            style: TextStyle(
                                              fontFamily: kDefaultFontFamily,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            )),
                                        value: selectedState,
                                        items: [
                                          for (String state in states.keys)
                                            DropdownMenuItem(
                                                child: Text(state.toString(),
                                                    style: TextStyle(
                                                      fontFamily:
                                                          kDefaultFontFamily,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16,
                                                    )),
                                                value: states[state].toString())
                                        ],
                                        validator: (value) {
                                          if (value == null) {
                                            if (!errFlag) {
                                              errFlag = true;
                                              stateNode.requestFocus();
                                            }
                                            return 'Selection required!';
                                          }
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            selectedState = value;
                                            postcodeNode.requestFocus();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: _large ? _width * 0.4 : _width,
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                cursorColor: kPrimaryColor,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  //currentNode.unfocus();
                                  postcodeNode.unfocus();
                                },
                                initialValue: widget.customer.billing.postcode,
                                focusNode: postcodeNode,
                                decoration: InputDecoration(
                                  labelText: 'Postcode',
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
                                onChanged: (value) {
                                  postcode = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    if (!errFlag) {
                                      errFlag = true;
                                      postcodeNode.requestFocus();
                                    }
                                    return 'Required';
                                  }
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: (){},
                      child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text('Save Address',style: TextStyle(
                                                        fontFamily:
                                                            kDefaultFontFamily,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16,
                                                      ),),
                    ),)
          ],),),),
      ),
    );
  }
   Container buildCustomTextField(String initialValue,setValue setval, String labelText,
      validationFunction validator, FocusNode fNode, FocusNode nextNode) {
    return Container(
      width: _large ? _width * 0.4 : _width,
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onFieldSubmitted: (value) {
          nextNode==null?FocusScope.of(context).unfocus():nextNode.requestFocus();
        },
        focusNode: fNode,
        initialValue: initialValue,
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