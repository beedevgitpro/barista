import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  CartItem({this.title, this.width});
  final double width;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
        width: width,
        height: width * 0.35,
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
                   Container(
                      width: width * 0.50,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$500',style:TextStyle(
                        fontFamily: kDefaultFontFamily,
                                color: Colors.black, fontSize:18,),),
                      SizedBox(width:width*0.1),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'In Stock',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.green,
                            //fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
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
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                IconButton(icon: Icon(Icons.keyboard_arrow_up), onPressed: (){
                  //incrementqty
                  }),
                  Text('1',style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                  IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){
                  //decrementqty
                  })
               ], 
              )
            ],
        ),
      ),
          ),
    );
  }
}
