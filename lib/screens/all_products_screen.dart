import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  static String id = 'all products';
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  // List<Product> products = [
  //   Product(name: 'name', price: 200, sale: 10),
  //   Product(name: 'name', price: 200, sale: 0),
  //   Product(name: 'name', price: 200, sale: 0),
  //   Product(name: 'name', price: 200, sale: 0),
  // ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Card(
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
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: provider.items.length,
        itemBuilder: (BuildContext context, int index){
          return ProductCard(
            product: provider.items[index],
            onClick: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetails(product: provider.items[index])),
              );
            },
          );
        },
      ),
    );
  }
}
