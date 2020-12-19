import 'package:barista/request_models/add_to_cart_request_model.dart';
import 'package:barista/request_models/cart_delete_request_model.dart';
import 'package:barista/request_models/update_cartitem_request_model.dart';
import 'package:barista/response_models/get_cart_response_model.dart';
import 'package:barista/response_models/get_total_response_model.dart';
import 'package:barista/utility/webservice.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  // List<CartModel> _cartList=[
  //   CartModel(productTitle: 'Pure Thai Fish',
  //       imageUrl:
  //           'https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_960_720.jpg',
  //       ratingInText: '4.0',
  //       price: 20.0,
  //       rating: 4,
  //       weight: 1.5),CartModel(  productTitle: 'Thailand Special Banana',
  //       imageUrl:
  //           'https://cdn.pixabay.com/photo/2016/01/03/17/59/bananas-1119790_960_720.jpg',
  //       ratingInText: '5.0',
  //       price: 25.40,
  //       rating: 5,
  //       weight: 2)
  // ];

  Map<String, GetCartResponseModel> _cartList = {};
  GetTotalResponseModel _totals;

  Map<String, GetCartResponseModel> get getCartItems {
    return {..._cartList};
  }

  Future<GetTotalResponseModel> getTotalAmount() async {
    // _cartList.forEach((key, cartI) {
    //   total += cartI.price * cartI.quantity;
    // });
    _totals = await WebService.getTotals();
    return _totals;
  }

  GetTotalResponseModel get getTotals {
    return _totals;
  }

  Future<bool> addCartItem(AddToCartRequestModel addToCartRequestModel) async {
    // if (_cartList.containsKey(product.id)) {
    //   _cartList.update(
    //       product.id.toString(),
    //           (existing_cartitem) => CartModel(
    //           id: existing_cartitem.id,
    //           productTitle: existing_cartitem.productTitle,
    //           imageUrl: existing_cartitem.imageUrl,
    //           rating: existing_cartitem.rating,
    //           weight: existing_cartitem.weight,
    //           ratingInText: existing_cartitem.ratingInText,
    //           quantity: existing_cartitem.quantity + 1,
    //           price: existing_cartitem.price));
    // } else {
    //   _cartList.putIfAbsent(
    //       product.id.toString(),
    //           () =>
    //           CartModel(
    //               id: product.id.toString(),
    //               productTitle: product.name,
    //               imageUrl: product.images[0].toString(),
    //               rating: product.ratingCount.toDouble(),
    //               weight: double.parse(product.weight) ?? 1,
    //               ratingInText: product.ratingCount.toString(),
    //               quantity: 1,
    //               price: double.parse(product.price)));
    // }
    var value = await WebService.addToCart(addToCartRequestModel);

    if (value != null) {
      //await fetchCartDetails();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> updateCartItem(
      UpdateCartItemRequestModel updateCartItemRequestModel) async {
    // if (_cartList.containsKey(product.id)) {
    //   _cartList.update(
    //       product.id.toString(),
    //           (existing_cartitem) => CartModel(
    //           id: existing_cartitem.id,
    //           productTitle: existing_cartitem.productTitle,
    //           imageUrl: existing_cartitem.imageUrl,
    //           rating: existing_cartitem.rating,
    //           weight: existing_cartitem.weight,
    //           ratingInText: existing_cartitem.ratingInText,
    //           quantity: existing_cartitem.quantity + 1,
    //           price: existing_cartitem.price));
    // } else {
    //   _cartList.putIfAbsent(
    //       product.id.toString(),
    //           () =>
    //           CartModel(
    //               id: product.id.toString(),
    //               productTitle: product.name,
    //               imageUrl: product.images[0].toString(),
    //               rating: product.ratingCount.toDouble(),
    //               weight: double.parse(product.weight) ?? 1,
    //               ratingInText: product.ratingCount.toString(),
    //               quantity: 1,
    //               price: double.parse(product.price)));
    // }
    var value = await WebService.updateCartItem(updateCartItemRequestModel);

    if (value) {
      await fetchCartDetails();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void removeSingleItem(String productId) {
    // if (!_cartList.containsKey(productId)) {
    //   return;
    // } else if (_cartList[productId].quantity > 1) {
    //   _cartList.update(
    //       productId,
    //           (existing_cartitem) =>
    //           CartModel(
    //               id: existing_cartitem.id,
    //               productTitle: existing_cartitem.productTitle,
    //               imageUrl: existing_cartitem.imageUrl,
    //               rating: existing_cartitem.rating,
    //               weight: existing_cartitem.weight,
    //               ratingInText: existing_cartitem.ratingInText,
    //               quantity: existing_cartitem.quantity - 1,
    //               price: existing_cartitem.price));
    // } else {
    //   _cartList.remove(productId);
    // }
    notifyListeners();
  }

  Future<Map<String, GetCartResponseModel>> fetchCartDetails() async {
    _cartList = await WebService.getCartList();
    notifyListeners();
    return _cartList;
  }

  Future<bool> removeCart(CartDeleteRequestModel cartDeleteRequestModel) async {
    var result = await WebService.removeCartItem(cartDeleteRequestModel);
    notifyListeners();
    return result;
  }
}
