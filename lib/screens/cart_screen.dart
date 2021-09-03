import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/checkout.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/personal_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static String id = 'cart';
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isRecentlyViewedAppears = true;

  Color? getColor(String colorName){
    Map<String, Color> map = {
      'red': Colors.red,
      'blue': Colors.blue,
      'white': Colors.white,
      'black': Colors.black,
    };
    if(map[colorName] == null) return Colors.grey[200];
    return map[colorName];
  }

  removeProduct(BuildContext ctx, Product product){
    Provider.of<CartProvider>(ctx, listen: false).removeItem(product);
  }

  Widget emptyCart(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.remove_shopping_cart,
            color: Colors.grey,
            size: 70,
          ),
          SizedBox(height: 10,),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget filledCart(CartProvider cartProvider, RecentlyViewedProvider recentlyViewedProvider){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 5,
            ),
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index){
                double priceAfterSale = (cartProvider.items[index].price / 100) * (100 - cartProvider.items[index].sale);
                Color? color = getColor(cartProvider.items[index].color);
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 140,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      cartProvider.items[index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      removeProduct(context, cartProvider.items[index]);
                                    },
                                    icon: Icon(
                                        Icons.clear_rounded
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  if(color != Colors.grey[200])
                                    CircleAvatar(
                                      backgroundColor: color,
                                      radius: 7,
                                    ),
                                  SizedBox(width: 5,),
                                  if(color != Colors.grey[200])
                                    Text(
                                      cartProvider.items[index].color,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  if(color == Colors.grey[200])
                                    Text('Product has no colors',),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(cartProvider.items[index].quantityAddedInCart > 1)
                                              Provider.of<CartProvider>(context, listen: false).decreaseProductQuantity(index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          cartProvider.items[index].quantityAddedInCart.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            if(cartProvider.items[index].quantityAddedInCart <
                                                cartProvider.items[index].availabilityInStock)
                                              Provider.of<CartProvider>(context, listen: false).increaseProductQuantity(index);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '\$ ' + priceAfterSale.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(recentlyViewedProvider.items.length > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                            //fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            setState(() {
                              _isRecentlyViewedAppears = !_isRecentlyViewedAppears;
                            });
                          },
                          icon: Icon(
                              _isRecentlyViewedAppears? Icons.clear_rounded : Icons.arrow_drop_up_outlined
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    if(_isRecentlyViewedAppears)
                      recentlyViewedBanner(recentlyViewedProvider),
                  ],
                ),
                CustomButton(
                  text: 'Validate orders',
                  onclick: _checkoutBottomSheet,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget recentlyViewedBanner(RecentlyViewedProvider recentlyViewedProvider){
    return InkWell(
      onTap: (){},
      child: Container(
        height: 140,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: recentlyViewedProvider.items.length,
          itemBuilder: (BuildContext context, int index) {
            double priceAfterSale = (recentlyViewedProvider.items[index].price / 100) * (100 - recentlyViewedProvider.items[index].sale);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                  ),
                  SizedBox(height: 5,),
                  Text('\$ ' + priceAfterSale.toStringAsFixed(2)),
                  SizedBox(width: 5,),
                  Text(
                    '\$ ' + recentlyViewedProvider.items[index].price.toStringAsFixed(2),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _checkoutBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[200],
        isScrollControlled: true,
        context: context,
        builder: (context){
          return PersonalInfo();
        });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var recentlyViewedProvider = Provider.of<RecentlyViewedProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      ),
      body: cartProvider.items.isNotEmpty ? filledCart(cartProvider, recentlyViewedProvider) : emptyCart(),
    );
  }
}
