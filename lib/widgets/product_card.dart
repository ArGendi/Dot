import 'dart:typed_data';

import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onClick;

  const ProductCard({Key? key, required this.product, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double temp = (1 - (product.discountPrice / product.price)) * 100;
    int sale = temp.truncate();
    return InkWell(
      onTap: onClick,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: product.images.isNotEmpty ?
                            Image.memory(Uint8List.fromList(product.images[0])) : Container(),
                      ),
                      SizedBox(height: 5,),
                      Text(
                          product.name
                      ),
                      Text(
                          '\$ ${product.discountPrice}'
                      ),
                    ],
                  ),
                ),
              ),
              if(sale != 0)
              Positioned(
                right: 0,
                top: 0,
                child: Card(
                  elevation: 0,
                  color: Color(0xffffecde),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sale.toString() + '%'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
