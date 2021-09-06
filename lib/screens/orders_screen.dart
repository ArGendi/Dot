import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/recently_viewed_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool _isOpenedOrder = true;
  int _pageIndex = 0;
  final PageController controller = PageController(initialPage: 0);

  Widget emptyOrders(){
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
                'There is no orders for now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'All your orders will be saved here in order to view their status at anytime.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30,),
              CustomButton(text: 'Continue shopping', onclick: (){}),
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
                  'Recently Viewed',
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

  Widget filledOrders(OrdersProvider provider){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Orders',
            style: TextStyle(
                fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isOpenedOrder = !_isOpenedOrder;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Opened orders',
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: _isOpenedOrder ? FontWeight.bold : FontWeight.normal,
                              color: _isOpenedOrder ? Colors.black : Colors.grey
                          ),
                        ),
                        SizedBox(height: 5,),
                        if(_isOpenedOrder)
                          Container(
                            width: 50,
                            height: 1,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isOpenedOrder = !_isOpenedOrder;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Closed orders',
                          style: TextStyle(
                              fontSize: 16,
                              //fontWeight: !_isOpenedOrder ? FontWeight.bold : FontWeight.normal,
                              color: !_isOpenedOrder ? Colors.black : Colors.grey
                          ),
                        ),
                        SizedBox(height: 5,),
                        if(!_isOpenedOrder)
                          Container(
                              width: 50,
                              height: 1,
                              color: Colors.black
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              if(_isOpenedOrder)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.openedOrders.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        orderDetails(provider.openedOrders[index], index),
                        Divider(
                          height: 20,
                          color: Colors.grey[500],
                        ),
                      ],
                    );
                  },
                ),
              if(!_isOpenedOrder)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.closedOrders.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        orderDetails(provider.closedOrders[index], index),
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
        ],
      ),
    );
  }

  Widget orderDetails(Product product, int index){
    return Column(
      children: [
        if(index == 0)
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  '\$ ' + product.discountPrice.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
            Text(
              'Date of order',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Delivery date',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'status',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                        child: Center(
                          child: Text(product.quantityAddedInCart.toString()),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '\$ ' + product.discountPrice.toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '31/3/2012',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              '5/4/2012',
              style: TextStyle(
                fontSize: 12,
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
                  'Arrived',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OrdersProvider>(context);
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
      body: filledOrders(provider),
    );
  }
}
