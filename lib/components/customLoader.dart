import 'package:barista/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loader{
    Loader(this.context);
    BuildContext context;
    Future<void> show() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
              child: AlertDialog(
                shape: CircleBorder(),
          content: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle
            ),
            width: 50,
            height: 70,
                    child: SpinKitRing(
                      lineWidth: 10,
              size: 60,
              color: kPrimaryColor
            ),
          ),
        ),
      );
    },
  );
}
void hide(){
 Navigator.of(context).pop();
}
}