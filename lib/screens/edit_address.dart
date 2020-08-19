import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woocommerce/woocommerce.dart';
typedef void SetValue(String value);
typedef void ValidationFunction(String value);
class EditAddress extends StatefulWidget {
  EditAddress({this.customer,this.isBilling});
  final WooCustomer customer;
  final bool isBilling;
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _addressFormKey=GlobalKey<FormState>();
  final fNameNode = FocusNode();
  final lNameNode = FocusNode();
  final bNameNode = FocusNode();
  final emailNode = FocusNode();
  final phoneNode = FocusNode();
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
      businessName,suburb,selectedState,streetAddress,postcode,phone,email;
  double _width;
  double _pixelRatio;
  bool _large;
  int userID;
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      );
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
       appBar:PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
         backgroundColor: Colors.white,
            drawer: NavigationDrawer(),
          body: SafeArea(child: SingleChildScrollView(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
                    padding: const EdgeInsets.only(left:10.0,top:10),
                          child: Text(
                            widget.isBilling?'Billing Address':'Shipping Address',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: _large?26:24,
                            ),
                          ),
                        ),
            SizedBox(height: 20,),
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
                                              fontSize: getFontSize(context, -2),
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
                                                      fontSize: getFontSize(context, -2),
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
                                          return null;
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
                                  return null;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('Back',style: TextStyle(
                                                              fontFamily:
                                                                  kDefaultFontFamily,
                                                              color: kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              fontSize: getFontSize(context, 0),
                                                            ),),
                          ),),
                        ),
                        Padding(
                      padding:  EdgeInsets.all(10.0),
                      child: FlatButton(
                        color: kPrimaryColor,
                        onPressed: ()async{
                          if(_addressFormKey.currentState.validate())
                          await woocommerce.updateCustomer(id: widget.customer.id,data:{
                            if(widget.isBilling)...{"billing": {
                                "first_name": firstName,
                                  "last_name":lastName,
    "company": businessName,
    "address_1": streetAddress,
    "address_2": "",
    "city": suburb,
    "state": selectedState,
    "postcode": postcode,
    "country": "US",
    "email": "john.doe@example.com",
    "phone": phone
                          }}else...{
                            "shipping": {
                                "first_name": firstName,
                                  "last_name":lastName,
    "company": businessName,
    "address_1": streetAddress,
    "address_2": "",
    "city": suburb,
    "state": selectedState,
    "postcode": postcode,
    "country": "US",
    "email": "john.doe@example.com",
    "phone": phone
                          }
                          }
                          });
                        },
                        child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Save Address',style: TextStyle(
                                                          fontFamily:
                                                              kDefaultFontFamily,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: getFontSize(context, 0),
                                                        ),),
                      ),),
                    )
                      ],
                    ),
                    
          ],),),),
      ),
    );
  }
   Container buildCustomTextField(String initialValue,SetValue setval, String labelText,
      ValidationFunction validator, FocusNode fNode, FocusNode nextNode) {
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