import 'dart:typed_data';

import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _addedToCart = false;
  int _pageIndex = 0;
  final PageController controller = PageController(initialPage: 0);
  // String? _townDropdownValue = 'Select town';
  // String? _shopDropdownValue = 'Select our nearest shop';
  // List<String> _towns = ['Select town'];
  // List<String> _shops = ['Select our nearest shop'];
  List<Product> _similarProducts = [
    new Product(name: 'name', price: 220, sale: 10),
    new Product(name: 'name', price: 400, sale: 20),
    new Product(name: 'name', price: 400, sale: 20),
  ];

  Widget rate(double rate){
    return Row(
      children: [
        for(int i=0; i<5; i++)
          Icon(
            (i < rate && i+1 > rate) ? Icons.star_half : Icons.star,
            color: i < rate ? Colors.amber : Colors.grey.shade300,
          )
      ],
    );
  }

  _addToWishlist(){
    Provider.of<WishlistProvider>(context, listen: false).addItem(widget.product, true);
  }

  _removeFromWishlist(){
    Provider.of<WishlistProvider>(context, listen: false).removeItem(widget.product);
  }

  Widget addToCartButton(BuildContext context){
    return InkWell(
      onTap: (){
        if(widget.product.availabilityInStock > 0 && !_addedToCart) {
          widget.product.quantityAddedInCart = 1;
          Provider.of<CartProvider>(context, listen: false).addItem(widget.product, true);
          setState(() {
            _addedToCart = true;
          });
        }
      },
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
              !_addedToCart ?
                Text(
                  'Add to cart',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ) : Icon(Icons.check, color: Colors.white,),
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
    double temp = (1 - (widget.product.discountPrice / widget.product.price)) * 100;
    int sale = temp.truncate();
    int totalRate = 0;
    for(var review in widget.product.reviews){
      totalRate += review.rate;
    }
    double finalRate = totalRate / widget.product.reviews.length;
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
              child: widget.product.images.isNotEmpty ? PageView(
                scrollDirection: Axis.horizontal,
                controller: controller,
                children: [
                  for(var image in widget.product.images)
                    Image.asset(image),
                ],
                onPageChanged: (value){
                  setState(() {
                    _pageIndex = value;
                  });
                },
              ) : Container()
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i=0; i<widget.product.images.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: i == _pageIndex ? Colors.black : Colors.grey[300],
                    ),
                  )
              ],
            ),
            SizedBox(height: 10,),
            Text(
              widget.product.name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5,),
            Text(
                '\$ ' + widget.product.discountPrice.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            //SizedBox(height: 5,),
            if(sale != 0)
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
                    child: Text(sale.toString() + '%'),
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
                    rate(finalRate),
                    Text(
                      '(' + widget.product.reviews.length.toString() + ' reviews)',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: (){
                    if(widget.product.isFavourite) {
                      _removeFromWishlist();
                    }
                    else _addToWishlist();
                    setState(() {
                      widget.product.isFavourite = !widget.product.isFavourite;
                    });
                  },
                  icon: Icon(
                    widget.product.isFavourite? Icons.favorite : Icons.favorite_border,
                    color: primaryColor,
                  ),
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

  // Widget dropDownMenu(bool isTown){
  //   List<String> list = [];
  //   if(isTown) list = _towns;
  //   else list = _shops;
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey.shade300),
  //         borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 15),
  //       child: DropdownButton<String>(
  //         value: isTown ? _townDropdownValue : _shopDropdownValue,
  //         icon: const Icon(Icons.arrow_drop_down),
  //         iconSize: 24,
  //         elevation: 16,
  //         underline: Container(
  //           color: Colors.white,
  //         ),
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             if(isTown) _townDropdownValue = newValue;
  //             else _shopDropdownValue = newValue;
  //           });
  //         },
  //         items: list.map<DropdownMenuItem<String>>((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  Widget similarProductsCard(){
    var provider = Provider.of<AllProductsProvider>(context);
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int index = 0; index < 4; index+=1)
                if(provider.items[index].name != widget.product.name)
                InkWell(
                  onTap: (){
                    Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(provider.items[index], false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetails(product: provider.items[index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 100,
                          color: Colors.grey[200],
                          child: Image.asset(provider.items[index].images[0]),
                        ),
                        Text(
                          provider.items[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$ ' + provider.items[index].discountPrice.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              '\$ ' + provider.items[index].price.toStringAsFixed(2),
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
                                child: Text(((1-(provider.items[index].discountPrice / provider.items[index].price))*100).truncate().toString() + '%'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget reviews(){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: widget.product.reviews.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            for(int index=0; index < widget.product.reviews.length; index+=1)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 25,
                  ),
                  SizedBox(width: 15,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.reviews[index].userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //SizedBox(height: 5,),
                        Text(
                          widget.product.reviews[index].fromDate,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              widget.product.reviews[index].rate.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey
                              ),
                            ),
                            SizedBox(width: 5,),
                            rate(widget.product.reviews[index].rate.roundToDouble()),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          widget.product.reviews[index].content,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Divider(
                          height: 40,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ],
        )
      ) : Center(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('No reviews yet'),
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
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
            onPressed: (){
              Navigator.pushNamed(context, Cart.id);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
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
                  similarProductsCard(),
                  SizedBox(height: 15,),
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  reviews(),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [addToCartButton(context)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
