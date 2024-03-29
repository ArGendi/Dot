import 'package:ecommerce/constants.dart';
import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> _items = [];
  DBHelper _dbHelper = new DBHelper();

  List<Product> get items => _items;

  addItem(Product product, bool insertInDB){
    _items.add(product);
    notifyListeners();
    if(insertInDB)
      _dbHelper.insert(wishlistTable, {
        'id': product.id,
      });
  }

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
    _dbHelper.deleteRow(wishlistTable, product.id);
  }

}