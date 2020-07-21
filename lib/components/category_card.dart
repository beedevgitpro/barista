import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
//  CategoryCard({});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
      child: Column(
        children: [
          Image.network(
            'https://www.baristasupplies.com.au/wp-content/uploads/2019/10/Coffee-Storage-300x300.png',
            width: 210,
            height: 210,
            alignment: Alignment.center,
          ),
          Container(
            width:200,
            padding: EdgeInsets.symmetric(vertical:10,horizontal:15),
            color: kPrimaryColor,
            child: Text(
              'Essentials',
              style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}