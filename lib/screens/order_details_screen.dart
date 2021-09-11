import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/screens/feedback_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Widget orderDetails(Order order, int index){
    return InkWell(
      onTap: (){
        //if(order.status == 'Arrived')
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedBack(product: order.products[index],)),
          );
      },
      child: Row(
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
                child: order.products[index].images.isNotEmpty ? Image.network(
                  order.products[index].images[0],
                  fit: BoxFit.cover,
                ) : Container(),
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
                        child: Text(order.products[index].quantityAddedInCart.toString()),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    '\$ ' + order.products[index].discountPrice.toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ],
          ),
          if(order.status != 'Arrived')
          Text(
            order.deliveryDate,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          if(order.status == 'Arrived')
            Text(
              'click to make review',
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.order.products.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                orderDetails(widget.order, index),
                Divider(
                  height: 30,
                  color: Colors.grey[400],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
