import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class OrdersProvider extends ChangeNotifier {
  List<Order> _openedOrders = [
    new Order(products: [
      new Product(name: 'product 1', price: 200, discountPrice: 180),
      new Product(name: 'product 1', price: 200, discountPrice: 180)
    ]),
    new Order(products: [
      new Product(name: 'product 1', price: 200, discountPrice: 180),
    ])
  ];
  List<Order> _closedOrders = [];
  //DBHelper _dbHelper = new DBHelper();

  List<Order> get openedOrders => _openedOrders;
  List<Order> get closedOrders => _closedOrders;

  addItemInOpenedOrders(Order order){
    _openedOrders.add(order);
    notifyListeners();
  }

  removeItemFromOpenedOrders(Order order){
    _openedOrders.remove(order);
    notifyListeners();
  }

  addItemInClosedOrders(Order order){
    _closedOrders.add(order);
    notifyListeners();
  }

  removeItemFromClosedOrders(Order order){
    _closedOrders.remove(order);
    notifyListeners();
  }

}