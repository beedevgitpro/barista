import 'package:barista/components/order_item.dart';
import 'package:barista/components/order_single_item.dart';
import 'package:barista/providers/orders_provider.dart';
import 'package:barista/response_models/order_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  static var routeName = '/MyOrdersScreen';

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final GlobalKey<ScaffoldState> _myOrderScreenKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myOrderScreenKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Order\'s',
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
        body: FutureBuilder(
            future: Provider.of<OrderProvider>(context, listen: false)
                .fetchOrderDetails(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Text('You have no orders.'),
                );
              }
              List<OrderListResponseModel> list = snapshot.data;
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  if (list[index].lineItems.length > 1) {
                    return OrderItem(list[index]);
                  } else {
                    return OrderSingleItem(list[index]);
                  }
                },
                itemCount: list.length,
              );
            }));
  }
}
