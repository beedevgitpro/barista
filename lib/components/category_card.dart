import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
 CategoryCard({this.size,this.src});
  final double size;
  final String src;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      padding: EdgeInsets.symmetric(horizontal:10,vertical: 5),
      child: Column(
        children: [
          Image.network(
            src,
            width: size,
            height: size,
            alignment: Alignment.center,
          ),
          Container(
            width:size,
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