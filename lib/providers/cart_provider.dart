import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _items = [];
  DBHelper _dbHelper = new DBHelper();

  List<Product> get items => _items;

  addItem(Product product, bool insertInDB){
    if(!product.addedToCart) {
      product.addedToCart = true;
      _items.add(product);
      notifyListeners();
      if (insertInDB)
        _dbHelper.insert(cartTable, {
          'id': product.id,
        });
    }
  }

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
    _dbHelper.deleteRow(cartTable, product.id);
  }

  decreaseProductQuantity(int index){
    _items[index].quantityAddedInCart -= 1;
    notifyListeners();
  }
  increaseProductQuantity(int index){
    _items[index].quantityAddedInCart += 1;
    notifyListeners();
  }

  removeAllItems(){
    _items = [];
    notifyListeners();
    _dbHelper.deleteAllRows(cartTable);
  }

}