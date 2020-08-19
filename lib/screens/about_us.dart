import 'package:barista/components/appbar.dart';
import 'package:barista/components/navdrawer.dart';
import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:barista/screens/wholesale_screen.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  double _width;
  double _pixelRatio;
  bool _large;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Barista Supplies from the Coffee Capital – Melbourne',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: _large ? 26 : 24,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Barista Supplies is a Australian owned and operated business, with over 20 years experience in the coffee industry. We import a wide range of barista tools, coffee accessories, coffee brewing gear, coffee machine cleaning and maintenance supplies directly from leading International and Local manufacturers to offer the highest quality products at the best price.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Our passion for coffee shines through everything we do. Our director Alec Maroush has over a decade of coffee experience from café operations, consulting and assisting national franchises on improving coffee consistency and quality. Alec has been judging for the Australian Specialty Coffee Association (ASCA) at the Regional and National Barista & Latte Art Competitions for 5 years. Each year, Alec gets invited to judge at the Australian International Coffee Awards, which is always an honor to be part of an Internationally recognized event. At Barista Supplies we believe strongly in supporting local made products, we stock a wide range of Australian made products from Australian owned and operated businesses. We are always looking for new innovative products to introduce to the market and we are very proud to be the exclusive distributor for a range of brands Australia Wide.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Barista Supplies Wholesale',
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: _large ? 24 : 24,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Do you order coffee accessories, brewing gear or cleaning and maintenance items in bulk? Have you considered becoming a wholesale account member? Members gain exclusive access to even cheaper and more competitive prices. If you would like to become a reseller or are interested in retailing Barista Supplies products please contact us. Join the Barista Supplies family and enjoy these perks:',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: kDefaultFontFamily,
                      color: Colors.black54,
                      fontSize: _large ? 18 : 16,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                for (String listItem in [
                  'High quality products at competitive prices',
                  'Excellent customer service',
                  'Safe and secure member login',
                  'User-friendly shopping',
                  'Range of payment options',
                  'Same-day dispatch (Orders placed before 3pm AEST)',
                  'Order tracking',
                  'Flat rate \$10 standard shipping* (excluding International and Express orders)'
                ])
                  Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 8, top: 10),
                    child: Row(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.navigate_next)),
                        
                        Expanded(
                          child: Text(
                            '$listItem',
                            style: TextStyle(
                              fontFamily: kDefaultFontFamily,
                              color: Colors.black54,
                              fontSize: _large ? 18 : 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WholesaleScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    //padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      'Become a Wholesale Account Member',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        color: Colors.white,
                        fontSize: _large ? 22 : 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
