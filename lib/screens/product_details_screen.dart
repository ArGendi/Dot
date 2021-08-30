import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Widget productRate(){
    return Row(
      children: [
        for(int i=0; i<5; i++)
          Icon(
            Icons.star,
            color: i < widget.product.rate ? Colors.amber : Colors.grey.shade300,
          )
      ],
    );
  }

  Widget addToCartButton(){
    return InkWell(
      onTap: (){},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.product.availabilityInStock != 0 ? primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              Text(
                'Add to cart',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Icon(
                Icons.add_shopping_cart,
                color: widget.product.availabilityInStock != 0 ? primaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstCard(){
    double priceAfterSale = (widget.product.price / 100) * (100 - widget.product.sale);
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.shade200,
            ),
            SizedBox(height: 20,),
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              widget.product.price.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            //SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  '\$ ' + priceAfterSale.toStringAsFixed(2),
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 5,),
                Card(
                  elevation: 0,
                  color: Color(0xffffecde),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(widget.product.sale.toString() + '%'),
                  ),
                ),
              ],
            ),
            Text('delivery from \$15 around Dot shop',),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productRate(),
                    Text(
                      '(' + widget.product.numberOfReviews.toString() + ' reviews)',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.share,
                        color: primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        widget.product.isFavourite? Icons.favorite : Icons.favorite_border,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: 30,
              color: Colors.grey,
            ),
            if(widget.product.availabilityInStock != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'In stock',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.product.availabilityInStock.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            if(widget.product.availabilityInStock == 0)
              Text(
                'Out of stock',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget productDescriptionCard(){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30,
              color: Colors.grey,
            ),
            Text(widget.product.description,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          onTap: (){
            showSearch(context: context, delegate: Search());
          },
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  firstCard(),
                  SizedBox(height: 10,),
                  Text(
                    'Product description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  productDescriptionCard(),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [addToCartButton()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
