import 'package:ecommerce/constants.dart';
import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> _items = [];

  List<Category> get items => _items;

  addItem(Category category){
    _items.add(category);
    notifyListeners();
  }

  removeItem(Category category){
    _items.remove(category);
    notifyListeners();
  }

}