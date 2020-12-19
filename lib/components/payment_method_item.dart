import 'package:barista/models/payment_method_model.dart';
import 'package:barista/providers/payment_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PaymentMethodItem extends StatefulWidget {
  int index;

  PaymentMethodItem(this.index);
  @override
  _PaymentMethodItemState createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<PaymentMethodItem> {
  @override
  Widget build(BuildContext context) {
    var paymentMethod = Provider.of<PaymentMethodModel>(context, listen: false);
    var selectedPayment =
        Provider.of<PaymentProvider>(context).getSelectedPayment;
    return InkWell(
      onTap: () {
        Provider.of<PaymentProvider>(context, listen: false)
            .selectPaymentMethod(widget.index);
      },
      child: Card(
        elevation: paymentMethod.isSelected ? 10 : 0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
        ),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // FittedBox(
              //   child: Image.network(widget._cartItem.imageUrl,
              //       fit: BoxFit.fill, height: 120, width: 120),
              // ),
              Flexible(
                child: Radio(
                  activeColor: Theme
                      .of(context)
                      .primaryColor,
                  groupValue: paymentMethod.methodName,
                  onChanged: (value) {
                    Provider.of<PaymentProvider>(context, listen: false)
                        .selectPaymentMethod(widget.index);
                  },
                  value: selectedPayment.methodName,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeInImage(
                    image: AssetImage(paymentMethod.icon),
                    placeholder:
                        AssetImage('assets/images/no_image_placeholder.png'),
                    height: 32,
                    width: 32,
                  ),
                ),
              ),
              SizedBox(width: 8),

              Flexible(
                  child: Text(
                paymentMethod.methodName,
                style: TextStyle(color: Colors.black),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
