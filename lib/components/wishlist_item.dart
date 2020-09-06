import 'package:barista/components/custom_snackBar.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/models/wishlist_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce/woocommerce.dart';

class WishlistItem extends StatefulWidget {
  WishlistItem({this.productID, this.width});
  final double width;
  final String productID;

  @override
  _WishlistItemState createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
      bool _loading=true;
      WooProduct product;
      @override
  void initState() {
    super.initState();
     woocommerce.getProductById(id: int.parse(widget.productID)).then((value) => setState((){
      _loading=false;
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
          child: _loading?SpinKitDualRing(color: kPrimaryColor):Row(
            children: [
              Image.network(product.images[0].src,
                  // 'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/8oz-Ivory-Chai-Sttoke-Cup-300x300.jpg',
                  height: widget.width * 0.3,
                  width: widget.width * 0.3),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Container(
                      width: widget.width * 0.60,
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
                            color: Colors.black,fontSize: getFontSize(context, 0),),),
                        SizedBox(width:widget.width*0.1),
                       Align(
                          alignment: Alignment.center,
                          child: Text(
                            product.stockStatus=='instock'?'In Stock':'Out of Stock',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.green,
                              //fontWeight: FontWeight.bold,
                              fontSize: getFontSize(context, 0),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false).add(product.id.toString(), 1, product.price.toString());
                          Provider.of<WishlistModel>(context,listen: false).deleteItem(product.id.toString());
                          Scaffold.of(context).showSnackBar(buildSnackBar(context,'Added to Cart!'));
                        },
                        child: Text(
                          'Add to Cart',
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
                          Provider.of<WishlistModel>(context, listen: false).deleteItem(widget.productID);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        iconSize: 35,
                        
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}