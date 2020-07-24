import 'package:barista/constants.dart';
import 'package:barista/screens/login_screen.dart';
import 'package:barista/screens/productslistingscreen.dart';
import 'package:barista/screens/wholesale_screen.dart';
import 'package:barista/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barista/screens/about_us.dart';
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _isLoggedIn() {
    SharedPreferences prefs;
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      if(prefs.getBool('isLoggedIn')??false)
        return true;
      else
        return false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
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
          ExpandingDrawerItem(
            title: 'Coffee Accessories',
            children: [
              'View all',
              'Austrailian Made Products',
              'Barista Kits',
              'Barista Tools',
              'Books',
              'Brushes',
              'Cafe Supplies'
            ],
          ),
          ExpandingDrawerItem(title: 'Cleaning and Maintenance', children: [
            'View All',
            'Barista Bags',
            'Brushes',
            'Cloths',
            'Commercial Cleaning',
            'Water Filters'
          ]),
          ExpandingDrawerItem(title: 'Brewing Gear', children: [
            'View All',
            'Cold Brew',
            'Kettle',
            'Stove Top',
            'Filters',
            'Coffee Grinders'
          ]),
          ExpandingDrawerItem(title: 'Coffee Machine Parts', children: [
            'View All',
            'Anti-burning Arm sleeves',
            'Portafilters',
            'Shower Screens',
            'Grinder Parts',
            'Group Head Seals'
          ]),
          ExpandingDrawerItem(
            title: 'Brands',
            children: [
              'View All',
              '33 Cups',
              'ASCA',
              'AeroPress',
              'Pullman',
              'John Guest',
              'TempTag'
            ],
          ),
          DrawerItem(title: 'Beverages'),
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
            screen: _isLoggedIn()??false ? LoginScreen() : LoginScreen(),
          ),
          DrawerItem(title: 'My Wishlist',screen: WishlistScreen(),),
          DrawerItem(title: 'Gift Cards'),
          DrawerItem(title: 'Blogs'),
          DrawerItem(title: 'About us',screen:AboutUsScreen()),
          DrawerItem(title: 'Contact us'),
          DrawerItem(title: 'Call us: 03 8288 2399'),
          DrawerItem(title: 'Log In'),
        ]),
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
        Navigator.push(
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

class ExpandingDrawerItem extends StatelessWidget {
  const ExpandingDrawerItem({this.title, this.children});
  final String title;
  final List<String> children;
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
          tilePadding: EdgeInsets.symmetric(horizontal: 5),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: [
            for (var title in children)
              Container(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductsListingScreen(title: title)));
                  },
                  dense: true,
                  title: Text(
                    title,
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
