import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  WishlistItem({this.title, this.width});
  final double width;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.3,
      child: Row(
        children: [
          Image.network(
              'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/8oz-Ivory-Chai-Sttoke-Cup-300x300.jpg',
              height: width * 0.3,
              width: width * 0.3),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                                  Expanded(

                                                                      child: Container(
                                                                        width: width * 0.60,
                                      child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                                    ),
                                  ),
                               
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    color: kPrimaryColor,
                      padding: EdgeInsets.all(8),
                      onPressed: () {},
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),),
                      SizedBox(width:8),
                      IconButton(
                      padding: EdgeInsets.all(8),
                      onPressed: () {},
                      icon: Icon(Icons.delete,color: Colors.red,),
                      iconSize: 35,
                      // child: Text(
                      //   'Delete',
                      //   style: TextStyle(
                      //     fontFamily: kDefaultFontFamily,
                      //     color: Colors.white,
                      //     //fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //   ),
                      // ),),
                      )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
