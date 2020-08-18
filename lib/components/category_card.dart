import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
 CategoryCard({this.size,this.src,this.categoryName});
  final double size;
  final String src;
  final String categoryName;
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
              this.categoryName,
              style: TextStyle(
                  fontFamily: kDefaultFontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSize(context, 0),
                  ),
                  textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}