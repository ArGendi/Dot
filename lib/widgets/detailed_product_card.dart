import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;

  const DetailedProductCard({Key? key, required this.product, required this.onDelete}) : super(key: key);

  @override
  _DetailedProductCardState createState() => _DetailedProductCardState();
}

class _DetailedProductCardState extends State<DetailedProductCard> {

  @override
  Widget build(BuildContext context) {
    double priceAfterSale = (widget.product.price / 100) * (100 - widget.product.sale);
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$ ' + widget.product.price.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if(widget.product.sale != 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$ ' + priceAfterSale.toStringAsFixed(2),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                            ),
                          ),
                          Card(
                            elevation: 0,
                            color: Color(0xffffecde),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.product.sale.toString() + '%'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 28,
                  onPressed: widget.onDelete,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Card(
                    elevation: 0,
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
