import 'package:barista/screens/cart_screen.dart';
import 'package:flutter/material.dart';
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
       size:isLarge?38:33), onPressed: (){}),
                  IconButton(icon: Icon(Icons.shopping_basket,color: Color(0xff152f51),//Colors.black,
       size: isLarge?38:33), onPressed: (){
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CartScreen()),(r)=>r.isFirst);
       })
                ],
              ),
            ],
          ),
          ),
    );
  }
}