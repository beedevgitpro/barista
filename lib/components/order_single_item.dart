import 'package:barista/response_models/order_list_response_model.dart';
import 'package:barista/screens/trackorders_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderSingleItem extends StatefulWidget {
  OrderListResponseModel order;

  OrderSingleItem(this.order);

  @override
  _OrderSingleItemState createState() => _OrderSingleItemState();
}

class _OrderSingleItemState extends State<OrderSingleItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(TrackOrdersScreen.routeName,
            arguments: {
              'order_model': widget.order,
              'line_item': widget.order.lineItems[0]
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Card(
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                /*Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.all(8),
                  // color: Colors.red,
                  child: Image.network(
                    'https://www.unlockfood.ca/EatRightOntario/media/Website-images-resized/How-to-store-fruit-to-keep-it-fresh-resized.jpg',
                    fit: BoxFit.cover,
                  ),
                ),*/
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.lineItems[0].name,
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Order Number : ',
                              style: Theme.of(context).textTheme.headline3.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Theme.of(context).accentColor),
                            ),
                            Text(
                              '${widget.order.orderNumber}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Price : ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${widget.order.currency} ${widget.order.total}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Text(
                                '${widget.order.lineItems[0].quantity} pcs',
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
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Payment Method : ',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: 16,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.order.paymentDetails.methodTitle}',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            )
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
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Order placed on ',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Colors.grey.shade800,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                            Text(
                              DateFormat("dd MMM yyyy")
                                  .format(widget.order.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        /* Container(
                          padding: EdgeInsets.symmetric(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Price - ',
                                    style: Theme.of(context).textTheme.headline3.copyWith(
                                        color: Colors.grey.shade800,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '\$${widget.order.lineItems[0].price}',
                                    style: Theme.of(context).textTheme.headline4.copyWith(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        )*/
                        /* Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.only(left: 10),
                              title: Text(
                                'Show Items',
                                textAlign: TextAlign.end,
                              ),
                              children: widget.order.lineItems
                                  .map((lineItem) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      TrackOrdersScreen.routeName,
                                      arguments: {
                                        'order_model': widget.order,
                                        'line_item': lineItem
                                      },
                                    );
                                  },
                                  child: LineItemView(lineItem)))
                                  .toList(),
                            ))*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
