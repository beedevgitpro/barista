import 'package:barista/components/appbar.dart';
import 'package:barista/components/customLoader.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/response_models/login_response_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:barista/utility/PrefHelper.dart';
import 'package:barista/utility/webservice.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';

class LoginScreen extends StatefulWidget {
  static String routeName;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
    final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      );
  final _loginFormKey = GlobalKey<FormState>();
  final _registrationFormKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _autoValidate=false;
  double _width;
  double _pixelRatio;
  bool _large;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Register'),
          content: SingleChildScrollView(
            child: Form(
              key: _registrationFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    cursorColor: kPrimaryColor,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) return 'Required';
                      else if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value))
                        return 'Enter a valid Email Address';
                      else
                        return null;
                    },
                    onFieldSubmitted: (value) {
                      //currentNode.unfocus();
                      FocusScope.of(context).nextFocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'Your Email Address',
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
                  Text(
                    'A password will be sent to your Email address',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: getFontSize(context, -2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.black12,
              padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontSize: getFontSize(context, 0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
              onPressed: () {
                //Register
                if(_registrationFormKey.currentState.validate())
                  print('Validated');
              },
              child: Text(
                'Register',
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.white,
                  fontSize: getFontSize(context, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onPanDown: (_){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getFontSize(context, 10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _loginFormKey,
                    autovalidate: _autoValidate,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              email = value;
                            },
                            cursorColor: kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter Username/Email Address';
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).nextFocus();
                            },
                            decoration: InputDecoration(
                              hintText: 'Username or Email Address',
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
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter your Password';
                              return null;
                            },
                            cursorColor: kPrimaryColor,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton(
                                color: kPrimaryColor,
                                padding: EdgeInsets.symmetric(vertical:8,horizontal: 15),
                                onPressed: () async{
                                  final pr=Loader(context);
                                  if(_loginFormKey.currentState.validate())
                                  try{
                                    pr.show();
                                    //   final token = await woocommerce.authenticateViaJWT(username: email, password: password);

                                    LoginResponseModel response =
                                    await WebService.loginUser(
                                        email, password);
                                    if (response.token != null) {
                                      //   int userID = response.data.id;
                                      String name = response.userDisplayName;
                                      SharedPreferences.getInstance()
                                          .then((value) {
                                        // value.setInt(
                                        //     PrefHelper.PREF_USER_ID, userID);
                                        value.setString(PrefHelper.PREF_USER_ID,
                                            response.userId);
                                        value.setString(
                                            PrefHelper.PREF_USER_NAME, name);
                                        value.setBool(
                                            PrefHelper.PREF_LOGIN_STATUS, true);
                                        value.setString(
                                            PrefHelper.PREF_AUTH_TOKEN,
                                            response.token);
                                      });
                                      pr.hide();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LandingScreen()), (route) => false);

                                    }
                                  }
                                  on WooCommerceError catch(e){
                                    pr.hide();
                                    print(e.code.split(' ')[1]);
                                    Alert(
                                        context: context,
                                        title: e.code.split(' ')[1] ==
                                            'invalid_username'
                                            ? 'Invalid Username'
                                            : 'Invalid Password',
                                        image:
                                        Image.asset('assets/images/logo.png'),
                                        style: AlertStyle(
                                            isCloseButton: false,
                                            titleStyle: TextStyle(
                                              // color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: getFontSize(context, 4),
                                            )),
                                        buttons: [
                                          DialogButton(
                                              color:
                                              Theme.of(context).primaryColor,
                                              child: Text(
                                                'CLOSE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize:
                                                  getFontSize(context, 0),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ]).show();
                                  }
                                  else
                                  setState(() {
                                    _autoValidate=true;
                                  });
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: Colors.white,
                                    fontSize: getFontSize(context, 0),
                                  ),
                                ),
                              ),
                              Text('Forgot Password?',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontFamily: kDefaultFontFamily,
                                    fontSize: getFontSize(context, 0),
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          if(false)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: kDefaultFontFamily,
                                    fontSize: getFontSize(context, 0),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  _showMyDialog();
                                },
                                child: Text(' Register',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontFamily: kDefaultFontFamily,
                                      fontSize: getFontSize(context, 0),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}