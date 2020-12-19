import 'package:barista/providers/cart_provider.dart';
import 'package:barista/request_models/cart_delete_request_model.dart';
import 'package:barista/request_models/update_cartitem_request_model.dart';
import 'package:barista/response_models/get_cart_response_model.dart';
import 'package:barista/screens/products_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../responsive_text.dart';
import 'customLoader.dart';

class CartItem extends StatefulWidget {
  final String productKey;
  GetCartResponseModel _cartItem;
  bool _isSelected = false;

  CartItem(this.productKey, this._cartItem);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget._cartItem.key),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeCart(
            new CartDeleteRequestModel(cartItemKey: widget._cartItem.key));
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductScreen.routeName,
              arguments: widget._cartItem.productId);
        },
        child: Card(
          elevation: 1,
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)),
          ),
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // FittedBox(
              //   child: Image.network(widget._cartItem.imageUrl,
              //       fit: BoxFit.fill, height: 120, width: 120),
              // ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeInImage(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.3,
                    image: widget._cartItem.productImage != null
                        ? NetworkImage(widget._cartItem.productImage)
                        : AssetImage('assets/images/no_image_placeholder.png'),
                    placeholder:
                    AssetImage('assets/images/no_image_placeholder.png'),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget._cartItem.productTitle,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: getFontSize(context, 2)),
                          textAlign: TextAlign.start,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     SmoothStarRating(
                        //       allowHalfRating: false,
                        //       onRated: (v) {
                        //         setState(() {
                        //           widget._cartItem.ratingInText = v.toString();
                        //         });
                        //       },
                        //       starCount: 5,
                        //       rating: widget._cartItem.rating,
                        //       size: 20.0,
                        //       isReadOnly: false,
                        //       color: Colors.yellow,
                        //       borderColor: Colors.yellow,
                        //     ),
                        //     Text(
                        //       widget._cartItem.ratingInText,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black38,
                        //           fontSize: getFontSize(context, -1)),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            // Chip(
                            //   backgroundColor: Colors.orange[50],
                            //   label: Text(
                            //     'KG',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.orange,
                            //         fontSize: getFontSize(context, -1)),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 12,
                            // ),
                            Text(
                              '\$',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${widget._cartItem.productPrice.substring(1)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    int reducedQuantity =
                                    widget._cartItem.quantity -= 1;
                                    UpdateCartItemRequestModel
                                    updateCartItemRequestModel =
                                    new UpdateCartItemRequestModel(
                                        cartItemKey:
                                        widget._cartItem.key,
                                        quantity: reducedQuantity);
                                    var prLoader = Loader(context);
                                    prLoader.show();
                                    Provider.of<CartProvider>(context,
                                        listen: false)
                                        .updateCartItem(
                                        updateCartItemRequestModel)
                                        .then((value) {
                                      prLoader.hide();
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        shape: BoxShape.rectangle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Theme.of(context)
                                                  .accentColor,
                                              Theme.of(context).accentColor
                                            ])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.remove,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Consumer<CartProvider>(
                                  builder: (key, cart, _) => Text(
                                    '${widget._cartItem.quantity.toString()}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                InkWell(
                                  onTap: () {
                                    int increasedQuantity =
                                    widget._cartItem.quantity += 1;
                                    UpdateCartItemRequestModel
                                    updateCartItemRequestModel =
                                    new UpdateCartItemRequestModel(
                                        cartItemKey:
                                        widget._cartItem.key,
                                        quantity: increasedQuantity);
                                    var prLoader = Loader(context);
                                    prLoader.show();
                                    Provider.of<CartProvider>(context,
                                        listen: false)
                                        .updateCartItem(
                                        updateCartItemRequestModel)
                                        .then((value) {
                                      prLoader.hide();
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        shape: BoxShape.rectangle,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Theme
                                                  .of(context)
                                                  .accentColor,
                                              Theme
                                                  .of(context)
                                                  .accentColor
                                            ])),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.add,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 56,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
