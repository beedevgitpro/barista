import 'package:barista/constants.dart';
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
                        color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize:17,),textAlign: TextAlign.start,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical:10.0),
                          child: Row(
                            children: [
                              Text(double.parse(regularPrice)>double.parse(price)?'\$$regularPrice':'',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                              color: Colors.black54, fontWeight: FontWeight.bold,fontSize:18,decoration: TextDecoration.lineThrough),),
                              SizedBox(width:2),
                              Text('\$$price',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize:18,),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical:10.0),
                          child: Text('or 4 payments of \$5 with Afterpay',style:TextStyle(
                      fontFamily: kDefaultFontFamily,
                                color: Colors.black54, fontWeight: FontWeight.normal,fontSize:16,)),
                        ),
              //           Padding(
              //             padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 8),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //               Ink(
              //                 decoration: ShapeDecoration(
              // color: kPrimaryColor,
              // shape: BeveledRectangleBorder(),),
              //                 child: IconButton(icon: Icon(Icons.shopping_basket,color: Colors.white, size:22), onPressed: (){},color: kPrimaryColor,)),
              //               SizedBox(width:3),
              //               Ink(
              //                 decoration: ShapeDecoration(
              // color: Colors.black12,
              // shape: BeveledRectangleBorder(),),
              //                 child: IconButton(icon: Icon(Icons.favorite_border, size:22), onPressed: (){})),
              //                 SizedBox(width:3),
              //               Ink(
              //                 decoration: ShapeDecoration(
              // color: Colors.black12,
              // shape: BeveledRectangleBorder(),),
              //                 child: IconButton(icon: Icon(Icons.open_in_new, size:22), onPressed: (){}))
              //             ],),
              //           )
          ],
        ),
      ),
    );
  }
}