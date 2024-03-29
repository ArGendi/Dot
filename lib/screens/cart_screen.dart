import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/services/currency.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/checkout.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/personal_info.dart';
import 'package:ecommerce/widgets/recently_viewed_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class Cart extends StatefulWidget {
  static String id = 'cart';
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isRecentlyViewedAppears = true;

  // Color? getColor(String colorName){
  //   Map<String, Color> map = {
  //     'red': Colors.red,
  //     'blue': Colors.blue,
  //     'white': Colors.white,
  //     'black': Colors.black,
  //   };
  //   if(map[colorName] == null) return Colors.grey[200];
  //   return map[colorName];
  // }

  removeProduct(BuildContext ctx, Product product){
    Provider.of<CartProvider>(ctx, listen: false).removeItem(product);
  }

  Widget emptyCart(BuildContext context){
    var localization = AppLocalization.of(context);
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
            localization!.translate('Your cart is empty').toString(),
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget filledCart(CartProvider cartProvider, RecentlyViewedProvider recentlyViewedProvider, BuildContext context){
    var localization = AppLocalization.of(context);
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
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 140,
                          color: Colors.white,
                          child: cartProvider.items[index].images.isNotEmpty?
                          Image.network(
                            cartProvider.items[index].images[0],
                            fit: BoxFit.cover,
                          ) : Container(),
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
                              if(cartProvider.items[index].color.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    localization!.translate('color').toString() + ': ' + cartProvider.items[index].color,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
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
                                    '\$ ' + (cartProvider.items[index].discountPrice * cartProvider.items[index].quantityAddedInCart).toStringAsFixed(2),
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
                          localization!.translate('Recently viewed').toString(),
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
                      RecentlyViewedBanner(),
                  ],
                ),
                CustomButton(
                  text: localization!.translate('Validate order').toString(),
                  onclick: (){
                    _checkoutBottomSheet(context);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _checkoutBottomSheet(BuildContext context) {
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
      body: cartProvider.items.isNotEmpty ? filledCart(cartProvider, recentlyViewedProvider, context) :
          emptyCart(context),
    );
  }
}
