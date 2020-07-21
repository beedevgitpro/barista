import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class ProductListing extends StatelessWidget {
  ProductListing({this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://www.baristasupplies.com.au/wp-content/uploads/2014/10/Espresso-Machine-Cleaner-Cafetto-1kg-300x300.jpg',
            height: size,
            width: size,
            alignment: Alignment.center,
          ),
          Text('1Kg Esspreso Clean: Caffeto',maxLines: 2,overflow: TextOverflow.fade,style:TextStyle(
                    fontFamily: kDefaultFontFamily,
                      color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize:17,),textAlign: TextAlign.start,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Row(
                          children: [
                            Text('\$520',style:TextStyle(
                    fontFamily: kDefaultFontFamily,
                            color: Colors.black54, fontWeight: FontWeight.bold,fontSize:18,decoration: TextDecoration.lineThrough),),
                            SizedBox(width:2),
                            Text('\$500',style:TextStyle(
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:10.0),
                        child: Row(children: [
                          Ink(
                            decoration: ShapeDecoration(
            color: kPrimaryColor,
            shape: BeveledRectangleBorder(),),
                            child: IconButton(icon: Icon(Icons.shopping_basket,color: Colors.white, size:22), onPressed: (){},color: kPrimaryColor,)),
                          SizedBox(width:3),
                          Ink(
                            decoration: ShapeDecoration(
            color: Colors.black12,
            shape: BeveledRectangleBorder(),),
                            child: IconButton(icon: Icon(Icons.favorite_border, size:22), onPressed: (){})),
                            SizedBox(width:3),
                          Ink(
                            decoration: ShapeDecoration(
            color: Colors.black12,
            shape: BeveledRectangleBorder(),),
                            child: IconButton(icon: Icon(Icons.open_in_new, size:22), onPressed: (){}))
                        ],),
                      )
        ],
      ),
    );
  }
}