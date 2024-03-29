import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/screens/order_details_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/recently_viewed_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import 'home_screen.dart';

class Orders extends StatefulWidget {
  static String id = 'orders';
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _isOpenedOrder = true;
  int _pageIndex = 0;
  final PageController controller = PageController(initialPage: 0);

  Widget emptyOrders(AppLocalization localization){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localization.translate('There is no orders for now').toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                localization.translate('All your orders will be saved here in order to view their status at anytime.').toString(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30,),
              CustomButton(text: localization.translate('Continue shopping').toString(), onclick: (){
                Navigator.popUntil(context, ModalRoute.withName(Home.id));
              }),
            ],
          ),
        ),
        SizedBox(height: 30,),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.translate('Recently viewed').toString(),
                  style: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  height: 30,
                  color: Colors.grey[300],
                ),
                RecentlyViewedBanner(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget filledOrders(OrdersProvider provider, AppLocalization localization){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            localization.translate('Orders').toString(),
            style: TextStyle(
                fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: provider.items.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  orderCard(provider.items[index], index, localization),
                  Divider(
                    height: 20,
                    color: Colors.grey[500],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget orderCard(Order order, int index, AppLocalization localization){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDetails(order: order)),
        );
      },
      child: Column(
        children: [
          //dummy row
          if(index == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Text(
                  localization.translate('Date of order').toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  localization.translate('Delivery date').toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  localization.translate('status').toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.products.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order.products.length > 1 ? localization.translate('Items').toString() :
                        localization.translate('Item').toString(),
                        style: TextStyle(
                          //fontSize: 12,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                order.orderDate,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              Text(
                order.deliveryDate,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrdersProvider>(context);
    var localization = AppLocalization.of(context);
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
                    color: Colors.grey[600],
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, CartLoading.id);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: provider.items.isEmpty ?
             emptyOrders(localization!) : filledOrders(provider, localization!),
    );
  }
}
