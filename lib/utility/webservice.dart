import 'dart:convert';
import 'dart:io';

import 'package:barista/request_models/add_to_cart_request_model.dart';
import 'package:barista/request_models/cart_delete_request_model.dart';
import 'package:barista/request_models/create_order_request_model.dart';
import 'package:barista/request_models/update_cartitem_request_model.dart';
import 'package:barista/response_models/add_to_cart_response_model.dart';
import 'package:barista/response_models/customer_detail_response_model.dart';
import 'package:barista/response_models/get_cart_response_model.dart';
import 'package:barista/response_models/get_total_response_model.dart';
import 'package:barista/response_models/login_response_model.dart';
import 'package:barista/response_models/order_list_response_model.dart';
import 'package:barista/response_models/order_response_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../constants.dart';
import 'PrefHelper.dart';

class WebService{
  static String message;


  static Future<LoginResponseModel> loginUser(
      String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    LoginResponseModel loginResponseModel;
    try {
      var response = await Dio().post(kTokenUrl,
          data: {"username": email, "password": password},
          options: new Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
          }));
      if (response.statusCode == 200) {
        loginResponseModel = LoginResponseModel.fromJson(response.data);
        prefs.setString(PrefHelper.PREF_AUTH_TOKEN, loginResponseModel.token);

        prefs.setString(PrefHelper.PREF_USER_ID, loginResponseModel.userId);
         prefs.setString(PrefHelper.PREF_USER_NAME, loginResponseModel.userEmail);



        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        final dir = Directory(appDocPath);
        dir.deleteSync(recursive: true);
      }
    } on DioError catch (error) {
      print(error.message);
    }
    return loginResponseModel;
  }

  static Future<AddToCartResponseModel> addToCart(
      AddToCartRequestModel addToCartRequestModel) async {
    AddToCartResponseModel addToCartResponseModel;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString(PrefHelper.PREF_AUTH_TOKEN);
      var jsonData = addToCartRequestModel.toJson();
      var headersData = {
        HttpHeaders.authorizationHeader:
        bearerToken == null ? null : 'Bearer $bearerToken',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      Dio dio = new Dio();
      if (prefs.getBool(PrefHelper.PREF_LOGIN_STATUS) == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
        dio.interceptors.add(CookieManager(cookieJar));
      }
      var response = await dio.post(kCoCartUrl + 'add-item',
          data: jsonData, options: new Options(headers: headersData));

      if (response.statusCode == 200) {
        print(response.toString());
        addToCartResponseModel = AddToCartResponseModel.fromJson(jsonDecode(response.toString()));
        //  prefs.setString(PrefHelper.PREF_OFFLINE_CART_KEY, addToCartResponseModel.key);
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return addToCartResponseModel;
  }


  static Future<bool> updateCartItem(
      UpdateCartItemRequestModel updateCartItemRequestModel) async {
    bool rStatus = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString(PrefHelper.PREF_AUTH_TOKEN);
      //  var offlineCartKey = prefs.getString(PrefHelper.PREF_OFFLINE_CART_KEY);
      var jsonData = updateCartItemRequestModel.toJson();
      Dio dio = new Dio();
      if (prefs.getBool(PrefHelper.PREF_LOGIN_STATUS) == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
        dio.interceptors.add(CookieManager(cookieJar));
      }
      var response = await dio.post(kCoCartUrl + 'item',
          data: jsonData,
          options: new Options(headers: {
            HttpHeaders.authorizationHeader:
            bearerToken == null ? null : 'Bearer $bearerToken',
            //  'cart_key':offlineCartKey,
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 200) {
        rStatus = true;
        // await getCartList();
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return rStatus;
  }

  static Future<Map<String, GetCartResponseModel>> getCartList() async {
    dynamic responseMap;
    Map<String, GetCartResponseModel> cartMap = {};
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString(PrefHelper.PREF_AUTH_TOKEN);
      //  var offlineCartKey = prefs.getString(PrefHelper.PREF_OFFLINE_CART_KEY);
      //  var jsonData = addToCartRequestModel.toJson();
      var headersData = {
        HttpHeaders.authorizationHeader:
        bearerToken == null ? null : 'Bearer $bearerToken',
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      Dio dio = new Dio();
      if (prefs.getBool(PrefHelper.PREF_LOGIN_STATUS) == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
        dio.interceptors.add(CookieManager(cookieJar));
      }
      var response = await dio.get(kCoCartUrl + 'get-cart',
          queryParameters: {"thumb": true},
          options: new Options(headers: headersData));
      if (response.statusCode == 200) {
        responseMap = jsonDecode(response.toString());

        // responseMap.values.forEach((element) {
        //     var el = element;
        //     GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(el);
        //     print(el);
        // });

        if(responseMap.length>0){
          responseMap.forEach((key, value) {
            GetCartResponseModel getCartResponseModel =
            GetCartResponseModel.fromJson(value);
            cartMap.putIfAbsent(key, () => getCartResponseModel);
          });
        }


        // cartMap = AddToCartResponseModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return cartMap;
  }

  static Future<bool> removeCartItem(
      CartDeleteRequestModel cartDeleteRequestModel) async {
    bool success = false;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString(PrefHelper.PREF_AUTH_TOKEN);
      //  var offlineCartKey = prefs.getString(PrefHelper.PREF_OFFLINE_CART_KEY);
      var jsonData = cartDeleteRequestModel.toJson();
      Dio dio = new Dio();
      if (prefs.getBool(PrefHelper.PREF_LOGIN_STATUS) == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
        dio.interceptors.add(CookieManager(cookieJar));
      }
      var response = await dio.delete(kCoCartUrl + 'item',
          data: jsonData,
          options: new Options(headers: {
            HttpHeaders.authorizationHeader:
            bearerToken == null ? null : 'Bearer $bearerToken',
            // 'cart_key':offlineCartKey,
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 200) {
        success = true;
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return success;
  }

  static Future<GetTotalResponseModel> getTotals() async {
    GetTotalResponseModel getTotalResponseModel;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var bearerToken = prefs.getString(PrefHelper.PREF_AUTH_TOKEN);
      //  var jsonData = addToCartRequestModel.toJson();
      //   var offlineCartKey = prefs.getString(PrefHelper.PREF_OFFLINE_CART_KEY);
      Dio dio = new Dio();
      if (prefs.getBool(PrefHelper.PREF_LOGIN_STATUS) == null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
        dio.interceptors.add(CookieManager(cookieJar));
      }
      var response = await dio.get(kCoCartUrl + 'totals',
          options: new Options(headers: {
            HttpHeaders.authorizationHeader:
            bearerToken == null ? null : 'Bearer $bearerToken',
            //  'cart_key':offlineCartKey,
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      if (response.statusCode == 200) {
        getTotalResponseModel = GetTotalResponseModel.fromJson(response.data);

        return getTotalResponseModel;

        // cartMap = AddToCartResponseModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<OrderResponseModel> createOrder(
      CreateOrderRequestModel createOrderRequestModel) async {
    OrderResponseModel createOrderResponseModel;
    try {
      var authHeader = base64.encode(
        utf8.encode(kConsumerKey + ":" + kConsumerSecret),
      );
      var jsonData = createOrderRequestModel.toJson();
      print(jsonEncode(jsonData));

      var response = await Dio().post(kWebServiceUrl + 'orders',
          data: jsonData,
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authHeader',
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 201) {
        createOrderResponseModel = OrderResponseModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return createOrderResponseModel;
  }

  static Future<List<OrderListResponseModel>> fetchOrderDetails() async {
    List<OrderListResponseModel> orderDetailsList = [];
    Map<String, dynamic> responseMap ={};
    try {
      SharedPreferences prefs = await SharedPreferences. getInstance();
      String userId = prefs.getString(PrefHelper.PREF_USER_ID);
      var authHeader = base64.encode(
          utf8.encode(kConsumerKey + ":" + kConsumerSecret));
      var response = await Dio().get(
          'https://revamp.baristasupplies.com.au/wc-api/v3/customers/' +
              '$userId/orders',
          options: new Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Basic $authHeader',
                HttpHeaders.contentTypeHeader: 'application/json'}));
      if (response.statusCode == 200) {
        responseMap = jsonDecode(response.toString());

        // responseMap.values.forEach((element) {
        //     var el = element;
        //     GetCartResponseModel getCartResponseModel = GetCartResponseModel.fromJson(el);
        //     print(el);
        // });

        List list = responseMap.values.first;
        // list.map((value){
        //      OrderResponseModel orderResponseModel =
        //     OrderResponseModel.fromJson(value);
        //     orderDetailsList.add(orderResponseModel);
        // });
        list.forEach((value) {
          OrderListResponseModel orderListResponseModel =
          OrderListResponseModel.fromJson(value);
          orderDetailsList.add(orderListResponseModel);
        });

        // list.forEach(value) {
        //   OrderResponseModel orderResponseModel =
        //   OrderResponseModel.fromJson(value);
        //   orderDetailsList.add(orderResponseModel);
        // });

      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return orderDetailsList;
  }

  static Future<CustomerDetailResponseModel> fetchCustomerDetails() async {
    CustomerDetailResponseModel customerDetailResponseModel;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString(PrefHelper.PREF_USER_ID);
      var authHeader =
      base64.encode(utf8.encode(kConsumerKey + ":" + kConsumerSecret));
      var response = await Dio().get(kWebServiceUrl + 'customers/$userId',
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authHeader',
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 200) {
        customerDetailResponseModel =
            CustomerDetailResponseModel.fromJson(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error.toString());
    }
    return customerDetailResponseModel;
  }



    static Future ForgetPasswordAPI({
      String email}) async {
    try {
      var response = await Dio().post(kBaseUrl+'',
          data: {"user_login": email,},
          options: new Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (response.statusCode == 200) {
            message=jsonDecode(response.data['message']);
      }
      else if(response.statusCode==401){
          message=jsonDecode(response.data['message']);
      }
      else{
         message=jsonDecode(response.data['message']);
      }
    } on DioError catch (error) {
      print(error.message);
      message='This $email is not registered with us';
     
    }
    return message;
  }


}