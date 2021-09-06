import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class OrdersProvider extends ChangeNotifier {
  List<Product> _openedOrders = [
    new Product(name: 'product 1', price: 200, discountPrice: 180),
    new Product(name: 'product 1', price: 200, discountPrice: 180),
    new Product(name: 'product 1', price: 200, discountPrice: 180)
  ];
  List<Product> _closedOrders = [];
  //DBHelper _dbHelper = new DBHelper();

  List<Product> get openedOrders => _openedOrders;
  List<Product> get closedOrders => _closedOrders;

  addItemInOpenedOrders(Product product){
    _openedOrders.add(product);
    notifyListeners();
  }

  removeItemFromOpenedOrders(Product product){
    _openedOrders.remove(product);
    notifyListeners();
  }

  addItemInClosedOrders(Product product){
    _closedOrders.add(product);
    notifyListeners();
  }

  removeItemFromClosedOrders(Product product){
    _closedOrders.remove(product);
    notifyListeners();
  }

}