import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/landingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with SingleTickerProviderStateMixin{
  TabController _tabController;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large,_medium;
  int userID;
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: 'https://revamp.baristasupplies.com.au/',
      consumerKey: 'ck_4625dea30b0c7207161329d3aaf2435b38da34ae',
      consumerSecret: 'cs_e43af5c06ecb97a956af5fd44fafc0e65962d32c',
      );
  Widget addressesScreen(){
    return SingleChildScrollView(child: Column(
         children: [
           Padding(
             padding:  EdgeInsets.all(10.0),
             child: Container(
               decoration: BoxDecoration(
                border: Border.all(), 
               ),
                padding:  EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Billing Address',style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 18,fontWeight: FontWeight.bold),),
                     IconButton(icon: Icon(Icons.add_circle,color: kPrimaryColor,size: 35,), onPressed: (){
                     })
                   ],
             ),
                 ],
               ),),
           ),
           Padding(
             padding: EdgeInsets.all(10.0),
             child: Container(
               decoration: BoxDecoration(
                border: Border.all(), 
               ),
                padding: EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Shipping Address',style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 18,fontWeight: FontWeight.bold),),
                    Icon(Icons.add_circle,color: kPrimaryColor,size:35)
                   ],
             ),
             
                 ],
               ),),
           )
           
         ], 
        ),);
  }
  Widget ordersScreen(){
    return  
        StreamBuilder(
          stream: woocommerce.getOrders(customer:userID).asStream(),
          builder: (context,snapshot){
            if(snapshot.data ==null)
              {
                return Center(child:Text('No orders to display',style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 18),));}
            return SingleChildScrollView(
                          child: Column(
                children: [
                  for(WooOrder order in snapshot.data)
                    ListTile(
                      
                      leading: Text(order.dateCreated,style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 16),),
                      title:Text(order.number,style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 16),),
                      subtitle: Text(order.total,style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 16),),
                      trailing: Column(
                        children: [
                          FlatButton(
                            color: kPrimaryColor,
                            onPressed: (){},
                            child: Text('View',style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 16,color: Colors.white),)),
                          Text(order.status,style: TextStyle(fontFamily: kDefaultFontFamily,fontSize: 16),),
                        ],
                      ),
                    )
                ],
              ),
            );
        }
    );
  }
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value){
      setState(() {
      userID=value.getInt('userID');
      });
    });
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
         backgroundColor: Colors.white,
            drawer: NavigationDrawer(),
        body: SafeArea(child: Column(
         children: [
           Container(
                      height: _height * 0.08,
                      child: TabBar(
                        tabs: [
                          Tab(
                              child: Text('Account',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontFamily: kDefaultFontFamily,
                                    fontSize: 18,
                                  ))),
                                   Tab(
                              child: Text('Addresses',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                  ))),
                          Tab(
                              child: Text('Orders',
                                  style: TextStyle(
                                    fontFamily: kDefaultFontFamily,
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                  )))
                        ],
                        controller: _tabController,
                      )),
                      Expanded(child: 
                      TabBarView(
                        controller: _tabController,
                        children: [
                        FlatButton(child: Text('Get Details'),onPressed: (){
                        SharedPreferences.getInstance().then((value)async{
                          WooCustomer currentUser=await woocommerce.getCustomerById(id: value.getInt('userID'));
                        
                          print(currentUser.firstName);
                          
                        });
                      },),
                      addressesScreen(),
                      ordersScreen()
                      ]),
                      
                      )
         ], 
        ),),
      ),
    );
  }
}