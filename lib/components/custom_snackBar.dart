import 'package:barista/constants.dart';
import 'package:barista/responsive_text.dart';
import 'package:flutter/material.dart';

  SnackBar buildSnackBar(context,snackBarText) {
    return SnackBar(
      backgroundColor: kPrimaryColor,content:Text(
                                snackBarText,
                                style: TextStyle(
                                  fontFamily: kDefaultFontFamily,
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 0),
                                ),
      ),
    duration: Duration(milliseconds: 500),
    behavior: SnackBarBehavior.floating,
  );
  }