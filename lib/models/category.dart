import 'package:ecommerce/models/product.dart';

class Category {
  List<Product> products = [];
  String id = '';
  String name = '';
  String image = '';

  Category({this.id = '', this.name = '', this.image = ''});
}