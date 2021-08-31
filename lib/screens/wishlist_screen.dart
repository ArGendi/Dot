import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/detailed_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  Widget emptyWishlist(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'All your wishlist will be saved here in order to add them into the cart at anytime.',
          ),
          SizedBox(height: 30,),
          CustomButton(text: 'Add new Product', onclick: (){})
        ],
      ),
    );
  }

  Widget filledWishlist(List<Product> items){
    List<Product> reversedItems = items.reversed.toList();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              DetailedProductCard(
                product: reversedItems[index],
                onDelete: (){
                  deleteItemFromWishlist(reversedItems[index]);
                },
              ),
              SizedBox(height: 5,),
            ],
          );
        },
      ),
    );
  }

  deleteItemFromWishlist(Product product){
    Provider.of<WishlistProvider>(context, listen: false).removeItem(product);
  }

  @override
  Widget build(BuildContext context) {
    var wishlistProvider = Provider.of<WishlistProvider>(context);
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
      body: wishlistProvider.items.isEmpty ? emptyWishlist() :
            filledWishlist(wishlistProvider.items),
    );
  }
}
