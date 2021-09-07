import 'package:ecommerce/models/product.dart';

class Order{
  List<Product> products = [];
  String status = '';
  String orderDate = '';
  String deliveryDate = '';

  Order({required this.products, this.status = '', this.deliveryDate = '', this.orderDate = ''});
}