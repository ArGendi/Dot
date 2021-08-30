import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/detailed_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({Key? key}) : super(key: key);

  @override
  _RecentlyViewedState createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  Widget emptyWishlist(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.visibility_off,
            color: Colors.grey,
            size: 70,
          ),
          SizedBox(height: 10,),
          Text(
            'Your Recently Viewed list is empty',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget filledWishlist(List<Product> items){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              DetailedProductCard(
                product: items[index],
                onDelete: (){
                  deleteItemFromWishlist(items[index]);
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
    Provider.of<RecentlyViewedProvider>(context, listen: false).removeItem(product);
  }

  @override
  Widget build(BuildContext context) {
    var recentlyViewedProvider = Provider.of<RecentlyViewedProvider>(context);
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
      body: recentlyViewedProvider.items.isEmpty ? emptyWishlist() :
      filledWishlist(recentlyViewedProvider.items),
    );
  }
}
