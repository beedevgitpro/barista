import 'package:barista/constants.dart';
import 'package:barista/screens/contact_us_screen.dart';
import 'package:barista/screens/login_screen.dart';
import 'package:barista/screens/my_account.dart';
import 'package:barista/screens/productslistingscreen.dart';
import 'package:barista/screens/wholesale_screen.dart';
import 'package:barista/screens/wishlist_screen.dart';
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
      baseUrl: 'https://revamp.baristasupplies.com.au/',
      consumerKey: 'ck_4625dea30b0c7207161329d3aaf2435b38da34ae',
      consumerSecret: 'cs_e43af5c06ecb97a956af5fd44fafc0e65962d32c',
      apiPath: '/wp-json/wc/v3/');
    List<WooProductCategory> parentCategory=[];
    bool isLoggedIn=false;
    bool _isLoading=true;
    getParentCartegories(){
      woocommerce.getProductCategories(parent:0).then((value) => setState(() {parentCategory=value;_isLoading=false;}));
      
    }
  void _isLoggedIn() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        if(value.getBool('isLoggedIn')??false)
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
    getParentCartegories();
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
                    children: _isLoading?[SpinKitDualRing(color: Colors.white,)]:[
                       for(WooProductCategory category in parentCategory)
                        if(category.name.toLowerCase()!='default category')
                      ExpandingDrawerItem(title:category.name.split('&amp;').join(''),parentID:category.id,)
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
          DrawerItem(title: 'My Wishlist',screen: WishlistScreen(),),
          DrawerItem(title: 'Gift Cards'),
          // DrawerItem(title: 'Blogs'),
          DrawerItem(title: 'About us',screen:AboutUsScreen()),
          DrawerItem(title: 'Contact us',screen: ContactUsScreen(),),
          DrawerItem(title: 'Call us: 03 8288 2399'),
          DrawerItem(title: isLoggedIn??false ?'Logout':'Login',screen: isLoggedIn??false ? LoginScreen() : LoginScreen()),
        ]),
      ),
    );
  }
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
      baseUrl: 'https://revamp.baristasupplies.com.au/',
      consumerKey: 'ck_4625dea30b0c7207161329d3aaf2435b38da34ae',
      consumerSecret: 'cs_e43af5c06ecb97a956af5fd44fafc0e65962d32c',
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
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children:_isLoading?[SpinKitPulse(color: Colors.white,)]:[
                  for(WooProductCategory category in subCategories)
                  Container(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsListingScreen(title: category.name,categoryID:category.id)));
                  },
                  dense: true,
                  title: Text(
                    category.name,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
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
        screen==null?launch('tel://0382882399'):Navigator.push(
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
          fontSize: 16,
        ),
      ),
    );
  }
}

