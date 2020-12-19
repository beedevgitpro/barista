import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:barista/screens/contact_us_screen.dart';
import 'package:barista/screens/login_screen.dart';
import 'package:barista/screens/my_account.dart';
import 'package:barista/screens/myorders_screen.dart';
import 'package:barista/screens/productslistingscreen.dart';
import 'package:barista/screens/wholesale_screen.dart';
import 'package:barista/screens/wishlist_screen.dart';
import 'package:barista/utility/PrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barista/screens/about_us.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woocommerce/woocommerce.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}
class _NavigationDrawerState extends State<NavigationDrawer> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
    List<WooProductCategory> parentCategory=[];
    bool isLoggedIn=false;
    Map parentCategories={
      'Beverages':175,
      'Brands':179,
      'Brewing Gear':178,
      'Cleaning & Maintenance':181,
      'Coffee Accessories':176,
      'Coffee Machine Part':180,
      'Coffee Maker':180,
    };
    getParentCartegories(){
      woocommerce.getProductCategories(parent:0).then((value) => setState(() {
        parentCategory=value;
        for(var i in parentCategory)
          print(i.name +': '+i.id.toString());
        }));
        
    }
  void _isLoggedIn() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        if(value.getBool(PrefHelper.PREF_LOGIN_STATUS)??false)
        isLoggedIn= true;
      else
        isLoggedIn= false;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: ListView(children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 25),
                  onPressed: () {
                    Navigator.pop(context);
                  })),

                  
                  Column(
                    children:[
                       for(String category in parentCategories.keys)
                      ExpandingDrawerItem(title:category,parentID:parentCategories[category],)
                    ],
                  ),
          DrawerItem(title: 'Wholesale',screen: WholesaleScreen(),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Divider(
              color: Colors.white,
              thickness: 1.5,
              height: 20,
            ),
          ),
          DrawerItem(
            title: 'My Account',
            screen: isLoggedIn??false ? MyAccount() : LoginScreen(),
          ),
          DrawerItem(title: 'My Orders',screen: MyOrdersScreen(),),
          DrawerItem(title: 'My Wishlist',screen: WishlistScreen(),),
          DrawerItem(title: 'Gift Cards'),
          // DrawerItem(title: 'Blogs'),
          DrawerItem(title: 'About us',screen:AboutUsScreen()),
          DrawerItem(title: 'Contact us',screen: ContactUsScreen(),),
          DrawerItem(title: 'Call us: 03 8288 2399'),
          DrawerItem(title: isLoggedIn??false ?'Logout':'Login',screen: isLoggedIn==true? null: LoginScreen()),
        ]),
      ),
    );
  }
  }

  Widget logUserOut(BuildContext context) {
   SharedPreferences.getInstance().then((value) => value.clear());
   Navigator.push(
       context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
class ExpandingDrawerItem extends StatefulWidget {
  ExpandingDrawerItem({this.title,this.parentID});
  final String title;
  final int parentID;
  @override
  _ExpandingDrawerItemState createState() => _ExpandingDrawerItemState();
}

class _ExpandingDrawerItemState extends State<ExpandingDrawerItem> {
  final WooCommerce woocommerce = WooCommerce(
      baseUrl: kBaseUrl,
      consumerKey: kConsumerKey,
      consumerSecret: kConsumerSecret,
      apiPath: '/wp-json/wc/v3/');
  List<WooProductCategory> subCategories=[];
  bool _isLoading=true;
    void getSubCategories(){
      woocommerce.getProductCategories(parent:widget.parentID).then((value) => setState((){
        subCategories=value;
        _isLoading=false;
        }));
    }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          unselectedWidgetColor: Colors.white,
          toggleableActiveColor: Colors.white),
      child: ListTileTheme(
        dense: true,
        child: ExpansionTile(
          onExpansionChanged: (isExpanded){
            print(isExpanded);
            if(isExpanded)
                getSubCategories();
      
          },
          tilePadding: EdgeInsets.symmetric(horizontal: 5),
          title: Text(
            widget.title.toUpperCase(),
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getFontSize(context, -2),
            ),
          ),
          children:_isLoading?[SpinKitPulse(color: Colors.white,)]:[
                  for(WooProductCategory category in subCategories)
                  Container(
                child: ListTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsListingScreen(title: category.name,categoryID:category.id)),(r)=>r.isFirst);
                  },
                  dense: true,
                  title: Text(
                    category.name,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: getFontSize(context, -2),
                    ),
                  ),
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}
class DrawerItem extends StatelessWidget {
  const DrawerItem({this.title, this.screen});
  final String title;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        screen==null?logUserOut(context):Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      dense: true,
      contentPadding: EdgeInsets.only(left: 5),
      title: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontFamily: kDefaultFontFamily,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: getFontSize(context, -2),
        ),
      ),
    );
  }
}