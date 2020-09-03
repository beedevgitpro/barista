import 'package:barista/constants.dart';
import 'package:barista/responsive_ui.dart';
import 'package:flutter/material.dart';

class FilterUI extends StatefulWidget {
  @override
  _FilterUIState createState() => _FilterUIState();
}

class _FilterUIState extends State<FilterUI> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  double min = 0, max = 200;
  int start, end;
  @override
  void initState() {
    start=min.toInt();
    end=max.toInt();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);

    return buildFilterUI();
  }

  Container buildFilterUI() {
    return Container(
    
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:10),
     child:Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Column(
           children: [
             Divider(color: Colors.black,thickness: 3,indent: _width*0.4,endIndent: _width*0.4,),
             
         Divider(color: Colors.black,thickness: 3,height: 1,indent: _width*0.4,endIndent: _width*0.4,),
           ],
         ),
         Text('Filter by price',style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _large ? 20 : 18,
                        ),textAlign: TextAlign.start,),
        
          
          RangeSlider(activeColor: kPrimaryColor,inactiveColor: Colors.blueGrey,values: RangeValues(start.toDouble(),end.toDouble()), labels: RangeLabels('$start', '$end'),onChanged:(value){
            setState(() {
              start=value.start.round();
              end=value.end.round();
              print('$start ' + '$end');
            });
          },min:min.toDouble(),max:max.toDouble()),
        
        Text('\$$start to \$$end',style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: _large ? 20 : 18,
                        ),textAlign: TextAlign.center),
                //         SizedBox(height:_height*0.02),
                // FlatButton(onPressed: (){}, color: kPrimaryColor,child:),
                // SizedBox(height: _height*0.03,),
     ],) 
    );
  }
}