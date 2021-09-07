import 'dart:convert';

import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class OrdersLoading extends StatefulWidget {
  static String id = 'orders loading';
  const OrdersLoading({Key? key}) : super(key: key);

  @override
  _OrdersLoadingState createState() => _OrdersLoadingState();
}

class _OrdersLoadingState extends State<OrdersLoading> {
  WebServices _webServices = new WebServices();
  DBHelper _dbHelper = new DBHelper();
  bool _loadingFailed = false;

  Future<void> getData() async{
    setState(() {_loadingFailed = false;});
    var provider = Provider.of<OrdersProvider>(context, listen: false);
    if(provider.openedOrders.isEmpty && provider.closedOrders.isEmpty) {
      String? token = await HelpFunction.getUserToken();
      var response = await _webServices.getWithBearerToken(
          'https://souk--server.herokuapp.com/api/orders/myorders', token.toString());
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        for(var item in body){
          Order order = new Order(products: []);
          for(var productItem in item['orderItems']){
            Product product = new Product();
            product.id = productItem['_id'];
            product.name = productItem['name'];
            //------------------ image --------------------
            product.discountPrice = productItem['name'];
            product.quantityAddedInCart = productItem['qty'];
            order.products.add(product);
          }
          order.orderDate = item['createdAt'].split('T')[0];
          order.orderDate = item['updateAt'].split('T')[0];
          order.status = item['deliverStatus'];
          //-------------- filter orders to opened and closed ----------------
        }
        Navigator.pushReplacementNamed(context, Orders.id);
      }
      else {
        print('error get all products');
        setState(() {_loadingFailed = true;});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_loadingFailed ? CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryColor),
        ) : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something went wrong :(',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'Try again',
                onclick: getData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
