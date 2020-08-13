import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class CartModel extends ChangeNotifier{
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences prefs;
  final List<Map> items = [];
  int index=0;
  double total=0;
  void saveState() async {
   prefs = await SharedPreferences.getInstance();
   List<String> lst=[];
   for (var item in items){
     lst.add(jsonEncode(item));
   }
   prefs.setStringList('CartState',lst);
   print(prefs.getStringList('CartState'));
  }
  void clearState() async{
    prefs = await SharedPreferences.getInstance();
    items.clear();
    prefs.setStringList('CartState', null);
    calculateTotalPrice();
    notifyListeners();
  }
  bool isCartEmpty(){
    return items.isEmpty;
  }
  void retrieveState()async{
    prefs = await SharedPreferences.getInstance();
    if(prefs.getStringList('CartState')!=null){
      List<String> lst=prefs.getStringList('CartState');
      for(var item in lst)
        items.add(jsonDecode(item));
      calculateTotalPrice();
    }
    else
      print('null');
    notifyListeners();
  }
  void add(String productID,int qty,String price) {
    if(items.indexWhere((item)=>item['productID']==productID)<0)
    {
      items.add({'productID':productID,'price':double.parse(price),'quantity':qty});
      calculateTotalPrice();}
    else{
      incrementQuantity(productID);
    }
    saveState();
    notifyListeners();
  }
  void deleteItem(String productID)
  {
    items.removeAt(items.indexWhere((item)=>item['productID']==productID));
    calculateTotalPrice();
    saveState();
    notifyListeners();
  }
  void incrementQuantity(String productID){
    items[items.indexWhere((item)=>item['productID']==productID)]['quantity']++;
    calculateTotalPrice();
    saveState();
    notifyListeners();
  }
  void decrementQuantity(String productID){
    items[items.indexWhere((item)=>item['productID']==productID)]['quantity']--;
    calculateTotalPrice();
    saveState();
    notifyListeners();
  }
  void calculateTotalPrice(){
    total=0;
    if(items.isEmpty){
      return;
    }
    for (Map item in items){
      total=total+item['quantity']*item['price'];
    }
    notifyListeners();
  }
}