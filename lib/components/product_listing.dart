import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce/models/products.dart';

class ProductListing extends StatelessWidget {
  ProductListing({this.size,this.productName,this.img,this.price,@required this.regularPrice,@required this.product});
  final WooProduct product;
  final double size;
  final String productName;
  final String regularPrice;
  final img;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>ProductScreen(product:product)));
        },
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              img,
              height: size,
              width: size,
              alignment: Alignment.center,
            ),
            Text(productName,style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                        color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize: getFontSize(context, -1),),textAlign: TextAlign.start,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical:10.0),
                          child: Row(
                            children: [
                              Text(double.parse(regularPrice)>double.parse(price)?'\$$regularPrice':'',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                              color: Colors.black54, fontWeight: FontWeight.bold,fontSize: getFontSize(context, 0),decoration: TextDecoration.lineThrough),),
                              SizedBox(width:2),
                              Text('\$$price',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize: getFontSize(context, 0),),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical:10.0),
                          child: Text('or 4 payments of \$5 with Afterpay',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                                color: Colors.black54, fontWeight: FontWeight.normal,fontSize: getFontSize(context, -2),)),
                        ),
          ],
        ),
      ),
    );
  }
}