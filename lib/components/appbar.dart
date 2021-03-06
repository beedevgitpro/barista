import 'package:barista/providers/cart_provider.dart';
import 'package:barista/screens/cart_screen.dart';
import 'package:barista/screens/login_screen.dart';
import 'package:barista/screens/my_account.dart';
import 'package:barista/utility/PrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'badge.dart';
class BaristaAppBar extends StatelessWidget {
  BaristaAppBar({@required this.isLarge});
  final bool isLarge;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
          padding: EdgeInsets.symmetric(vertical:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.menu,color: Color(0xff152f51),//Colors.black,
       size: isLarge?38:33), onPressed: (){
         Scaffold.of(context).openDrawer();
       },),
              GestureDetector(
                onTap: (){
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                              child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.account_circle,color: Color(0xff152f51),//Colors.black,
       size:isLarge?38:33), onPressed: () async{

                    SharedPreferences prefs =await SharedPreferences.getInstance();
                    var isLoggedIn = prefs.getBool(PrefHelper.PREF_LOGIN_STATUS);
                    isLoggedIn??false ? Navigator.of(context).pushNamed(MyAccount.routeName) : Navigator.of(context).pushNamed(LoginScreen.routeName);
                  }),

                  Consumer<CartProvider>(
                      child: IconButton(icon: Icon(Icons.shopping_basket,color: Color(0xff152f51),//Colors.black,
                          size: isLarge?38:33), onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CartScreen()),(r)=>r.isFirst);
                      }),
                      builder: (ctx, cart, ch) =>
                          Badge(
                            child: ch,
                            value: cart.getCartItems.length.toString() ?? '0',
                            color: Colors.red,
                            countColor: Colors.white,
                          ))

                ],
              ),
            ],
          ),
          ),
    );
  }
}