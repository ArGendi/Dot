import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<String> shops = ['Fashion'];
  // List<List<Product>> allProducts = [
  //   [
  //     new Product(name: 'name', price: 220, sale: 10),
  //     new Product(name: 'name', price: 400, sale: 20),
  //     new Product(name: 'name', price: 220, sale: 10),
  //     new Product(name: 'name', price: 400, sale: 20),
  //   ],
  //   [
  //     new Product(name: 'name', price: 220, sale: 10),
  //     new Product(name: 'name', price: 400, sale: 20),
  //   ],
  //   [
  //     new Product(name: 'name', price: 220, sale: 10),
  //     new Product(name: 'name', price: 400, sale: 20),
  //   ],
  //   [
  //     new Product(name: 'name', price: 220, sale: 10),
  //     new Product(name: 'name', price: 400, sale: 20),
  //   ],
  // ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllProductsProvider>(context);
    var localization = AppLocalization.of(context);
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
                    Text(localization!.translate(shops[index]).toString(),),
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
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.7
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int i){
                        return InkWell(
                          onTap: (){
                            Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(provider.items[i], true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetails(product: provider.items[i])),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Image.asset(
                                    provider.items[i].images[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(provider.items[i].name)
                            ],
                          ),
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
