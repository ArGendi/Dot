import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<String> shops = ['Fashion', 'Food', 'Furniture', 'Electrical'];
  List<List<Product>> allProducts = [
    [
      new Product(name: 'name', price: 220, sale: 10),
      new Product(name: 'name', price: 400, sale: 20),
      new Product(name: 'name', price: 220, sale: 10),
      new Product(name: 'name', price: 400, sale: 20),
    ],
    [
      new Product(name: 'name', price: 220, sale: 10),
      new Product(name: 'name', price: 400, sale: 20),
    ],
    [
      new Product(name: 'name', price: 220, sale: 10),
      new Product(name: 'name', price: 400, sale: 20),
    ],
    [
      new Product(name: 'name', price: 220, sale: 10),
      new Product(name: 'name', price: 400, sale: 20),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shops[index],),
                    Divider(
                      height: 20,
                      color: Colors.grey,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.7
                      ),
                      itemCount: allProducts[index].length,
                      itemBuilder: (BuildContext context, int i){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey[200],
                              ),
                            ),
                            Text(allProducts[index][i].name)
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
