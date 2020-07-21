import 'package:barista/components/appbar.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
void main() {
  runApp(BaristaApp()
    );
}
class BaristaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child:
    MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // canvasColor: Colors.black,
      accentColor: Color(0xff152f51),
     appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0
     )
    ),
    home: SplashScreen(
      seconds: 5,
      navigateAfterSeconds: LandingScreen(),
      image: Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.white,
      photoSize:150,
      loaderColor: kPrimaryColor
    ),
  ));
  }
}