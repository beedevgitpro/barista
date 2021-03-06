import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';

final double kLargeFont=19;
final double kMediumFont=18;
final double kSmallFont=16;
double getFontSize(BuildContext context,double factor){
  bool _large = ResponsiveWidget.isScreenLarge( MediaQuery.of(context).size.width, MediaQuery.of(context).devicePixelRatio);
   bool  _medium = ResponsiveWidget.isScreenMedium( MediaQuery.of(context).size.width, MediaQuery.of(context).devicePixelRatio);
   return (_large?kLargeFont:(_medium?kMediumFont:kSmallFont))+factor;
}