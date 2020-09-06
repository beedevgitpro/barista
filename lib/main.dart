import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/models/wishlist_model.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:barista/screens/barista_splash.dart';
void main() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemStatusBarIconBrightness: Brightness.light,
      // statusBarBrightness: Brightness.dark,
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    
  ));
  runApp(BaristaApp());
}
class BaristaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WishlistModel(),
          child: ChangeNotifierProvider(
        create: (context) => CartModel(),
        child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: kPrimaryColor,
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
  )),
    );
  }
}