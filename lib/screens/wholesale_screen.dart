import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void setValue(String value);
typedef void validationFunction(String value);

class WholesaleScreen extends StatefulWidget {
  @override
  _WholesaleScreenState createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  final _wholesaleFormKey = GlobalKey<FormState>();
  String phone,
      firstName,
      lastName,
      businessName,
      pin,
      website,
      selectedState = null,
      suburb,
      email,
      streetAddress,
      abn,
      selectedBusinessType = null;
  final fName = FocusNode();
  final lName = FocusNode();
  final bName = FocusNode();
  final bNumber = FocusNode();
  final street = FocusNode();
  final suburbNode = FocusNode();
  final phoneNode = FocusNode();
  final emailNode = FocusNode();
  final websiteNode = FocusNode();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
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
  List<String> businessType = [
    'Cafe/Restaurant',
    'Coffee Technician',
    'Retail/Online Store',
    'Coffee Roaster',
    'Drop Shipper'
  ];
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Wholesale Coffee Accessories and More at Barista Supplies',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: _large ? 25 : 25,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Barista Supplies Wholesale',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: _large ? 24 : 24,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Become a Member Today! Once your account is set up you’ll be able to access our already cheap prices at even lower prices! Wholesale pricing is available for Cafes, Roasters, Technicians, Retailers and Wholesalers.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'You will receive an email with your login details once your account has been approved; only a verified member can access their wholesale account.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Fill out the form below and become a member today!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Form(
                    key: _wholesaleFormKey,
                    child: Center(
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
                                if (value.isEmpty) return 'Required';
                              },
                              fName),
                          buildCustomTextField(
                              (value) {
                                lastName = value;
                              },
                              'Last Name',
                              (value) {
                                if (value.isEmpty) return 'Required';
                              },
                              lName),
                          buildCustomTextField(
                              (value) {
                                businessName = value;
                              },
                              'Business Name',
                              (value) {
                                if (value.isEmpty) return 'Required';
                              },
                              bName),
                          Container(
                            width: _large ? _width * 0.4 : _width,
                            padding: EdgeInsets.all(8),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              cursorColor: kPrimaryColor,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                //currentNode.unfocus();
                                FocusScope.of(context).nextFocus();
                              },
                              decoration: InputDecoration(
                                labelText: 'ABN',
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
                                abn = value;
                              },
                              validator: (value) {
                                // if (value.isEmpty) return 'Required';
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          buildCustomTextField(
                              (value) {
                                streetAddress = value;
                              },
                              'Street Address',
                              (value) {
                                if (value.isEmpty) return 'Required';
                              },
                              street),
                          buildCustomTextField(
                              (value) {
                                suburb = value;
                              },
                              'Suburb',
                              (value) {
                                if (value.isEmpty) return 'Required';
                              },
                              suburbNode),
                          Padding(
                            padding: EdgeInsets.all(_large ? 0 : 8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              width: _large ? _width * 0.4 : _width,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
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
                                      onChanged: (value) {
                                        setState(() {
                                          selectedState = value;
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
                                FocusScope.of(context).nextFocus();
                              },
                              focusNode: phoneNode,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
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
                                phone = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) return 'Required';
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          buildCustomTextField(
                              (value) {
                                email = value;
                              },
                              'Email Address',
                              (value) {
                                if (value.isEmpty)
                                  return 'Required';
                                else if (RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(value))
                                  return 'Enter a valid Email address';
                                else
                                  return null;
                              },
                              emailNode),
                          buildCustomTextField(
                            (value) {
                              website = value;
                            },
                            'Website',
                            (value) {
                              if (value.isEmpty) return 'Required';
                            },
                            websiteNode,
                          ),
                          Padding(
                            padding: EdgeInsets.all(_large ? 0 : 8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              width: _large ? _width * 0.4 : _width,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                      hint: Text('Select Business Type',
                                          style: TextStyle(
                                            fontFamily: kDefaultFontFamily,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          )),
                                      value: selectedBusinessType,
                                      items: [
                                        for (String type in businessType)
                                          DropdownMenuItem(
                                            child: Text(type,
                                                style: TextStyle(
                                                  fontFamily:
                                                      kDefaultFontFamily,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                )),
                                            value: type
                                                .toLowerCase()
                                                .split(RegExp(r'[/|\s]'))
                                                .join('_'),
                                          )
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedBusinessType = value;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _large ? 30 : 16,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_wholesaleFormKey.currentState.validate())
                        print('Validated');
                    },
                    child: Container(
                      height: _large ? 60 : 70,
                      width: _large ? _width * 0.4 : double.infinity,
                      color: kPrimaryColor,
                      alignment: Alignment.center,
                      child: Text(
                        'Become a Member',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _large ? 22 : 18,
                          fontFamily: kDefaultFontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildCustomTextField(setValue setval, String labelText,
      validationFunction validator, FocusNode fNode) {
    return Container(
      width: _large ? _width * 0.4 : _width,
      padding: EdgeInsets.all(8),
      child: TextFormField(
        focusNode: fNode,
        onChanged: setval,
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next,
        validator: validator,
        onFieldSubmitted: (value) {
          //currentNode.unfocus();
          FocusScope.of(context).nextFocus();
        },
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
