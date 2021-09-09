import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class OrdersProvider extends ChangeNotifier {
  List<Order> _items = [];
  //DBHelper _dbHelper = new DBHelper();

  List<Order> get items => _items;

  addItem(Order order){
    _items.add(order);
    notifyListeners();
  }

  removeItem(Order order){
    _items.remove(order);
    notifyListeners();
  }


}