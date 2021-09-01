import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _items = [
    new Product(name: 'name', price: 220, sale: 10),
    new Product(name: 'name', price: 400, sale: 20),
  ];

  List<Product> get items => _items;

  addItem(Product product){
    _items.add(product);
    notifyListeners();
  }

  removeItem(Product product){
    _items.remove(product);
    notifyListeners();
  }

  decreaseProductQuantity(int index){
    _items[index].quantityAddedInCart -= 1;
    notifyListeners();
  }
  increaseProductQuantity(int index){
    _items[index].quantityAddedInCart += 1;
    notifyListeners();
  }

}