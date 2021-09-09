import 'package:ecommerce/models/info.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    int delivery = 15;
    int sum = 0;
    int tax = 10;
    int itemsQuantity = 0;
    for(var item in cartProvider.items) {
      sum += item.discountPrice * item.quantityAddedInCart;
      itemsQuantity += item.quantityAddedInCart;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Items: ' + itemsQuantity.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5,),
        Text(
          'Subtotals: ' + sum.toStringAsFixed(2) + ' ' + cartProvider.items[0].unitPrice,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        //SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax: ' + tax.toStringAsFixed(2) + ' ' + cartProvider.items[0].unitPrice,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Total:',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery: ' + delivery.toStringAsFixed(2) + ' ' + cartProvider.items[0].unitPrice,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              (sum + delivery + tax).toStringAsFixed(2) + ' ' + cartProvider.items[0].unitPrice,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ],
    );
  }
}
