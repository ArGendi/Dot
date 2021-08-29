import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;
}