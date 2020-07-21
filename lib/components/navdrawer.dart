import 'package:barista/constants.dart';
import 'package:barista/screens/productslistingscreen.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: ListView(children: [
          Align(alignment:Alignment.centerRight,child: IconButton(icon: Icon(Icons.close,color: Colors.white,size:25), onPressed: (){
            Navigator.pop(context);
          })),
          ExpandingDrawerItem(
            title: 'Coffee Accessories',
            children: [
              'Austrailian Made Products',
              'Barista Kits',
              'Barista Tools',
              'Books',
              'Brushes',
              'Cafe Supplies'
            ],
          ),
          ExpandingDrawerItem(title: 'Cleaning and Maintenance', children: [
            'Barista Bags',
            'Brushes',
            'Cloths',
            'Commercial Cleaning',
            'Water Filters'
          ]),
          ExpandingDrawerItem(title: 'Brewing Gear', children: ['Cold Brew','Kettle','Stove Top','Filters','Coffee Grinders']),
          ExpandingDrawerItem(title: 'Coffee Machine Parts', children: [
            'Anti-burning Arm sleeves',
            'Portafilters',
            'Shower Screens',
            'Grinder Parts',
            'Group Head Seals'
          ]),
          ExpandingDrawerItem(title: 'Brands', children: ['33 Cups','ASCA','AeroPress','Pullman','John Guest','TempTag'],),
          DrawerItem(title:'Beverages'),
          DrawerItem(title:'Wholesale'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:0.0),
            child: Divider(
             color:Colors.white,
             thickness: 1.5,
             height: 20,
            ),
            
          ),
          DrawerItem(title:'My Account'),
          DrawerItem(title:'My Wishlist'),
          DrawerItem(title:'Gift Cards'),
          DrawerItem(title:'Blogs'),
          DrawerItem(title:'About us'),
          DrawerItem(title:'Contact us'),
          DrawerItem(title:'Call us: 03 8288 2399'),
          DrawerItem(title:'Log In'),
        ]),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left:5),
          title: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontFamily: kDefaultFontFamily,
                  color: Colors.white, fontWeight: FontWeight.bold,fontSize:16,),
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
          toggleableActiveColor: Colors.white
          ),
          
      child: ListTileTheme(
        dense: true,
              child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal:5),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize:16,
            ),
          ),
          children: [
            for (var title in children)
              Container(
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsListingScreen(title:title)));
                    },
                dense: true,
                title: Text(
                  title,
                  style: TextStyle(
                    fontFamily: kDefaultFontFamily,
                      color: Colors.white, fontWeight: FontWeight.normal,fontSize:16,),
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
