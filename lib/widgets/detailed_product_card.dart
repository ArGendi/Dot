import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailedProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onClick;

  const DetailedProductCard({Key? key, required this.product, required this.onDelete, required this.onClick}) : super(key: key);

  @override
  _DetailedProductCardState createState() => _DetailedProductCardState();
}

class _DetailedProductCardState extends State<DetailedProductCard> {
  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    double sale = (1- (widget.product.discountPrice / widget.product.price)) * 100;
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: widget.onClick,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Image.asset(
                      widget.product.images[0],
                      fit: BoxFit.cover,
                    ),
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
                          '\$ ' + (widget.product.discountPrice * widget.product.quantityAddedInCart).toStringAsFixed(2),
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
                              '\$ ' + widget.product.price.toStringAsFixed(2),
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
                                child: Text(sale.ceil().toString() + '%'),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  onTap: (){
                    Provider.of<CartProvider>(context, listen: false).addItem(widget.product, true);
                    setState(() {
                      _addedToCart = true;
                    });
                  },
                  child: Card(
                    elevation: 0,
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          !_addedToCart ? 'Add to cart' : 'Added',
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
