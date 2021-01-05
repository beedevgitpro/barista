import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/models/wishlist_model.dart';
import 'package:barista/providers/cart_provider.dart';
import 'package:barista/providers/customer_provider.dart';
import 'package:barista/providers/orders_provider.dart';
import 'package:barista/providers/payment_provider.dart';
import 'package:barista/providers/products_provider.dart';
import 'package:barista/screens/cart_screen.dart';
import 'package:barista/screens/checkoutScreen.dart';
import 'package:barista/screens/forgetpassword_screen.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:barista/screens/login_screen.dart';
import 'package:barista/screens/my_account.dart';
import 'package:barista/screens/myorders_screen.dart';
import 'package:barista/screens/payment_method.dart';
import 'package:barista/screens/products_screen.dart';
import 'package:barista/screens/trackorders_screen.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => CartProvider()),
          ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
          ChangeNotifierProvider(create: (ctx)=> WishlistModel(),),
          ChangeNotifierProvider(create: (ctx)=> OrderProvider(),),
          ChangeNotifierProvider(create: (ctx)=> CustomerProvider(),),
          ChangeNotifierProvider(create: (ctx)=> PaymentProvider(),),


        ],
     child: MaterialApp(
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
        routes: {
        ProductScreen.routeName:(ctx)=>ProductScreen(),
          CartScreen.routeName:(ctx) => CartScreen(),
          MyOrdersScreen.routeName: (context) => MyOrdersScreen(),
          TrackOrdersScreen.routeName: (context) => TrackOrdersScreen(),
          CheckoutScreen.routeName:(context) => CheckoutScreen(),
          ForgetPasswordScreen.routeName:(context)=>ForgetPasswordScreen(),
          MyAccount.routeName:(context)=>MyAccount(),
          LoginScreen.routeName:(context)=>LoginScreen(),
          PaymentMethodScreen.routeName:(context)=>PaymentMethodScreen(),


        },
  )
    );
  }
}