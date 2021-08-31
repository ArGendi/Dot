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
  String? _townDropdownValue = 'Select town';
  String? _shopDropdownValue = 'Select our nearest shop';
  List<String> _towns = ['Select town'];
  List<String> _shops = ['Select our nearest shop'];
  List<Product> _similarProducts = [
    new Product(name: 'name', price: 220, sale: 10),
    new Product(name: 'name', price: 400, sale: 20),
    new Product(name: 'name', price: 400, sale: 20),
  ];

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
                '\$ ' + priceAfterSale.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            //SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  '\$ ' + widget.product.price.toStringAsFixed(2),
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

  Widget productSpecification(String title, String content){
    return Row(
      children: [
        Text(
          title + ': ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(content,),
      ],
    );
  }

  Widget productDescriptionCard(){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
            SizedBox(height: 20,),
            Text(
              'Product specifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30,
              color: Colors.grey,
            ),
            productSpecification('SKU', widget.product.sku),
            productSpecification('Color', widget.product.color),
            productSpecification('Main material', widget.product.mainMaterial),
            productSpecification('Model', widget.product.model),
            productSpecification('Product country', widget.product.productCountry),
            productSpecification('Product line', widget.product.productLine),
            productSpecification('Size', widget.product.size + ' (L x W x H cm)'),
            productSpecification('Weight', widget.product.weight.toStringAsFixed(1) + ' (kg)'),
            productSpecification('Website', widget.product.website),
            // SizedBox(height: 20,),
            // Text(
            //   'information about delivery',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Divider(
            //   height: 30,
            //   color: Colors.grey,
            // ),
            // dropDownMenu(true),
            // SizedBox(height: 5,),
            // dropDownMenu(false),
          ],
        ),
      ),
    );
  }

  Widget dropDownMenu(bool isTown){
    List<String> list = [];
    if(isTown) list = _towns;
    else list = _shops;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButton<String>(
          value: isTown ? _townDropdownValue : _shopDropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            color: Colors.white,
          ),
          onChanged: (String? newValue) {
            setState(() {
              if(isTown) _townDropdownValue = newValue;
              else _shopDropdownValue = newValue;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget similarProductsCard(){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int index = 0; index < _similarProducts.length; index+=1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.grey[200],
                      ),
                      Text(
                        _similarProducts[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$ ' + ((_similarProducts[index].price / 100) * (100 - _similarProducts[index].sale)).toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                            '\$ ' + _similarProducts[index].price.toStringAsFixed(2),
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
                              child: Text(_similarProducts[index].sale.toString() + '%'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
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
                  SizedBox(height: 15,),
                  Text(
                    'Product description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5,),
                  productDescriptionCard(),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Similar products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Text(
                          'See all >',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  similarProductsCard()
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