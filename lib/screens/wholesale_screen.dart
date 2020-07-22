import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';

typedef void setValue(String value);
typedef void validationFunction(String value);
class WholesaleScreen extends StatefulWidget {
  @override
  _WholesaleScreenState createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  final _wholesaleFormKey = GlobalKey<FormState>();
  String phone,firstName,lastName,businessName,pin,website,suburb,email;
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
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        buildCustomTextField((value) {firstName=value;}, 'First Name', (value) {if (value.isEmpty) return 'Required';}),
                        buildCustomTextField((value) {lastName=value;}, 'Last Name', (value) {if (value.isEmpty) return 'Required';}),
                        buildCustomTextField((value) {businessName=value;}, 'Business Name', (value) {if (value.isEmpty) return 'Required';}),
                        
                        buildCustomTextField((value){email=value;},'Email Address',(value) {
                    if (value.isEmpty) return 'Required';
                    else if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))
                      return 'Enter a valid Email address';
                    else
                      return null;
                  },),
                      buildCustomTextField((value) {website=value;}, 'Website', (value) {if (value.isEmpty) return 'Required';}),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildCustomTextField(setValue setval,String hintText,validationFunction validator) {
    return Container(width: _large?_width*0.5:_width,
                      child: TextFormField(
                  onChanged: setval,
                  cursorColor: kPrimaryColor,
                  textInputAction: TextInputAction.next,
                  validator: validator,
                  onFieldSubmitted: (value) {
                    //currentNode.unfocus();
                    FocusScope.of(context).nextFocus();
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
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
