import 'package:barista/response_models/order_list_response_model.dart';
import 'package:flutter/material.dart';

class TrackOrdersScreen extends StatefulWidget {
  static var routeName = '/TrackOrdersScreen';

  @override
  _TrackOrdersScreenState createState() => _TrackOrdersScreenState();
}

class _TrackOrdersScreenState extends State<TrackOrdersScreen> {
  final GlobalKey<ScaffoldState> _myOrderScreenKey =
      new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  List<Step> steps = [
    Step(
        title: Row(children: [
          ImageIcon(
            AssetImage('assets/images/Group 12338.png'),
            size: 40,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Order Placed',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text('We have received your order on 2-Nov-2020')
              ],
            ),
          ),
        ]),
        isActive: true,
        state: StepState.complete,
        content: Container()),
    Step(
      isActive: false,
      state: StepState.disabled,
      content: Container(),
      title: Row(
        children: [
          ImageIcon(
            AssetImage('assets/images/Group 12339.png'),
            size: 40,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Order Processed',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text('We are preparing your order')
            ],
          ),
        ],
      ),
    ),
    Step(
      isActive: false,
      state: StepState.disabled,
      content: Container(),
      title: Row(
        children: [
          ImageIcon(
            AssetImage('assets/images/Group 12340.png'),
            size: 40,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Out For Delivery',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text('You order is out for delivery')
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Map orderMap = ModalRoute.of(context).settings.arguments;
    OrderListResponseModel orderModel = orderMap['order_model'];
    LineItem lineItem = orderMap['line_item'];
    return Scaffold(
      key: _myOrderScreenKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Track Order\'s',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, right: 12.0, bottom: 8.0, left: 12.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 4.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 10),
                            child: Text(
                              'Order Number : ${orderModel.orderNumber}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade600),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.25,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.25,
                                padding: EdgeInsets.all(8),
                                // color: Colors.red,
                                child: Image.network(
                                  'https://www.unlockfood.ca/EatRightOntario/media/Website-images-resized/How-to-store-fruit-to-keep-it-fresh-resized.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${lineItem.name}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          // Text(
                                          //   '2-Nov-2020',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .headline6
                                          //       .copyWith(
                                          //           fontSize: 14,
                                          //           color: Colors.black,
                                          //           fontWeight: FontWeight.normal),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Price: \$ ${lineItem.price}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                            ),
                                            child: Text(
                                              '${lineItem.quantity} pcs',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Estimated Delivery on 5 Nov',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        '${orderModel.shippingAddress.address1},${orderModel
                            .shippingAddress.address2},${orderModel
                            .shippingAddress.city},${orderModel.shippingAddress
                            .postcode},${orderModel.shippingAddress
                            .state},${orderModel.shippingAddress.country}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption
                            .copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        '${orderModel.paymentDetails.methodTitle}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
                    ),
                    title: Text(
                      'Payment Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${lineItem.subtotal}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery fee',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ 0',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '(-) Discount',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${0}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  '\$ ${lineItem.total}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Tracking Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    children: [
                      Stepper(
                        steps: steps,
                        currentStep: 0,
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue,
                              VoidCallback onStepCancel}) {
                          return Row(
                            children: <Widget>[],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
