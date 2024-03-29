import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class RecentlyViewedProvider extends ChangeNotifier {
  List<Product> _items = [];
  DBHelper _dbHelper = new DBHelper();

  List<Product> get items => _items;

  addItem(Product product, bool insertInDB){
    if(!product.isViewed) {
      product.isViewed = true;
      _items.add(product);
      notifyListeners();
      if (insertInDB)
        _dbHelper.insert(recentlyViewedTable, {
          'id': product.id,
        });
    }
  }

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
    _dbHelper.deleteRow(recentlyViewedTable, product.id);
  }

}