import 'package:barista/constants.dart';
import 'package:flutter/material.dart';

class ShippingTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          Text(
            'SHIPPING OPTIONS',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'SHIPPING COST',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'TRANSIT TIME',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ]),
        TableRow(children: [
          Text(
            'Standard Shipping',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'Flat Rate \$10',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '1-4 Business Days',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ]),
        TableRow(children: [
          Text(
            'Express Shipping',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'From \$12.40',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '1-3 Business Days',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ]),
        TableRow(children: [
          Text(
            'International',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'Calculated at Checkout',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '2-10 Business Days',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ]),
        TableRow(children: [
          Text(
            'Pick Up from Warehouse	',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '11/76 Rushdale St, Knoxfield, Victoria 3180',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'Same Business Day',
            style: TextStyle(
              fontFamily: kDefaultFontFamily,
              color: Colors.black,
              //fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ]),
      ],
    );
  }
}
