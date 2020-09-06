import 'package:barista/components/appbar.dart';
import 'package:barista/components/category_card.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/components/product_listing.dart';
import 'package:barista/constants.dart';
import 'package:barista/models/cart_model.dart';
import 'package:barista/models/wishlist_model.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/productslistingscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
  double _width;
  double _pixelRatio;
  bool _large;
  SharedPreferences prefs;
  Widget browseCategories() {
    return StreamBuilder(
                    stream: woocommerce.getProductCategories(orderBy:'id',perPage: 30).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                        // return Center(
                        //   child:
                        //       SpinKitDualRing(size: 40, color: kPrimaryColor),
                        // );
                      }
                      // print(snapshot.data.length);
                      // for (WooProduct product in snapshot.data) {
                      //   for (WooProductItemAttribute attr in product.attributes) 
                      //   print(attr.name);
                      //   // for (WooProductImage i in product.images)
                      //   //   if (i != null)
                      //   //   print(i.src ?? 'lol');
                      // }

                      return Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Browse our Categories'.toUpperCase(),
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSize(context, 0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
                            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (WooProductCategory category in snapshot.data)
                            if(category.image!=null)
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsListingScreen(categoryID: category.id,title: category.name,)));
                              },
                              child: CategoryCard(size:_large?225:200,src:category.image.src,categoryName: category.name,))
                  ],
                ),
              ),
            ),
                          ],
                        ),
                      );
                    });
}

Widget justArrived(){
  return Container(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
             StreamBuilder(
                    stream: woocommerce.getProducts(orderBy: 'date',perPage: 15).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      

                      return Column(
                        children: [
                          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0,horizontal:5),
              child: Text(
                'Just Arrived'.toUpperCase(),
                style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSize(context, 0),
                ),
                textAlign: TextAlign.start,
              ),
            ),
                          Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
          runSpacing: 10,
          spacing: 10,
         children: [
           for (WooProduct product in snapshot.data)
           ProductListing(size: _large?200:180,img: product.images[0].src,price:'500',productName:product.name,regularPrice: '999',product: product,)
         ], 
        ),
                        ],
                      );
                    }),
        
      ],
    ),
  );
}
Widget imagePanel(String src,
   VoidCallback onTap) {
    return Container(
        padding: EdgeInsets.all(3),
        child: GestureDetector(
            onTap: onTap,
            child: Image.network(src,
                alignment: Alignment.center, fit: BoxFit.contain,loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) {
             
            return child;
            }
          return Container(
            
          );
        },)));
  }
Widget featuredProducts(){
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            
            StreamBuilder(
                    stream: woocommerce.getProducts(featured:true).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      return Column(
                        children: [
                          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Featured Products'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getFontSize(context, 0),
                      ),
                    ),
                   
                  ],
                ),
                Row(children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      onPressed: null)
                ]),
              ],
            ),
                          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [for (WooProduct product in snapshot.data) Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: ProductListing(size: _large?200:180,product: product,img: product.images[0].src,price:product.price,productName:product.name,regularPrice:product.regularPrice,)
                  )],
                ),
              ),
            ),
                        ],
                      );
                    }),
            
          ],
        ));
}
@override
  void initState() {
    SharedPreferences.getInstance().then((value) => prefs=value);
    super.initState();
    Provider.of<CartModel>(context, listen: false).retrieveState();
    Provider.of<WishlistModel>(context, listen: false).retrieveState();
  }
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: BaristaAppBar(isLarge:_large),
        ),
        backgroundColor: Colors.white,
        drawer: NavigationDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _large?
                    Container(
                      height: 350.0,
                      child: Row(children: [
                        Expanded(flex: 2,child: imagePanel(
                              'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitchers-blue-.png',
                           () {}),),
                        Expanded(
                          flex: 1,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(flex: 1,child:  imagePanel(
                     
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Cafetto-Cleaning.jpg',
                       () {}),),
                              Expanded(flex:1,child: imagePanel(
                     
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Coffee-Tampers.jpg',

                       () {}),)
                            ],
                          ),
                        ),
                        Expanded(flex: 1,child:imagePanel(
                     
                          'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitcher-blue-.png',
                       () {}),)
                      ],),
                    )
                    :Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imagePanel(
                        
                            'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitchers-blue-.png',
                       () {}),
                     imagePanel(
                   
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Cafetto-Cleaning.jpg',
                   () {}),
                imagePanel(
                    
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/09/Coffee-Tampers.jpg',
                     () {}),
                    imagePanel(
                  
                        'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Milk-Pitcher-blue-.png',
                    () {}),
                  ],
                ),
                Column(
                  children: [
                    featuredProducts(),
                    SizedBox(height: 10),
                browseCategories(),
                SizedBox(height: 10),
                justArrived(),
                SizedBox(height:10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}