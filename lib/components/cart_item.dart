import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class CartItem extends StatefulWidget {

  CartItem({this.productID, this.width,this.qty});
  final double width;
  final String productID;
  final int qty;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
    final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
  WooProduct product;

    @override
  void initState() {
    super.initState();
    woocommerce.getProductById(id: int.parse(widget.productID)).then((value) => setState((){
    
      product=value;}));
  }
  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
        width: widget.width,
        height: widget.width * 0.35,
        child: Row(
            children: [
              Image.network(product.images[0].src,
                  //'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/8oz-Ivory-Chai-Sttoke-Cup-300x300.jpg',
                  height: widget.width * 0.3,
                  width: widget.width * 0.3),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                      width: widget.width * 0.50,
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: getFontSize(context, -1),
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price}',style:TextStyle(
                        fontFamily: kDefaultFontFamily,
                                color: Colors.black, fontSize: getFontSize(context, 0),),),
                      SizedBox(width:widget.width*0.1),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          product.stockStatus=='instock'?'In Stock':'Out of Stock',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: product.stockStatus=='instock'?Colors.green:Colors.red,
                            //fontWeight: FontWeight.bold,
                            fontSize: getFontSize(context, -2),
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
                          'Add to Wishlist',
                          style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                            fontSize: getFontSize(context, -2),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        padding: EdgeInsets.all(8),
                        onPressed: () {
                          setState(() {
                        Provider.of<CartModel>(context, listen: false).deleteItem(widget.productID);
                  });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        iconSize: 35,
                        // child: Text(
                        //   'Delete',
                        //   style: TextStyle(
                        //     fontFamily: kDefaultFontFamily,
                        //     color: Colors.white,
                        //     //fontWeight: FontWeight.bold,
                        //     fontSize: getFontSize(context, -2),
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
                  setState(() {
                    Provider.of<CartModel>(context, listen: false).incrementQuantity(widget.productID);
                  });
                  
                  }),
                  Text(widget.qty.toString(),style: TextStyle(
                            fontFamily: kDefaultFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: getFontSize(context, 0),
                          ),),
                  IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){
                  //decrementqty
                  setState(() {
                    if(widget.qty>1)
                  Provider.of<CartModel>(context, listen: false).decrementQuantity(widget.productID);
                  else
                  Provider.of<CartModel>(context, listen: false).deleteItem(widget.productID);
                  });
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
