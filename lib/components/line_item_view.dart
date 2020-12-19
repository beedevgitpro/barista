import 'package:barista/response_models/order_list_response_model.dart';
import 'package:flutter/material.dart';


class LineItemView extends StatefulWidget {
  LineItem lineItem;

  LineItemView(this.lineItem);

  @override
  _LineItemViewState createState() => _LineItemViewState();
}

class _LineItemViewState extends State<LineItemView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.lineItem.name,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Price - ',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    color: Colors.grey.shade800,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '\$${widget.lineItem.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Text(
                          '${widget.lineItem.quantity} pcs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
