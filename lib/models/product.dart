import 'package:ecommerce/models/review.dart';

class Product{
  String name = '';
  String description = '';
  double price = -1;
  int sale = 0;
  String imageUrl = '';
  int rate = 0;
  bool isFavourite = false;
  int availabilityInStock = 12;
  String color = 'red';
  int quantityAddedInCart = 0;
  String sku = '';
  String mainMaterial = '';
  String model = '';
  String productCountry = '';
  String productLine = '';
  String size = '';
  double weight = 0;
  String website = '';
  List<Review> reviews = [
    new Review(userName: 'Abdelrahman', fromDate: '12 hours ago', rate: 4, content: 'lkafnlkjaflkjalkjflkj aljflkjalkfjalkj afjlakjfljalkfjalk lafjlakjflkajflk'),
    new Review(userName: 'Abdelrahman', fromDate: '12 hours ago', rate: 4, content: 'lkafnlkjaflkjalkjflkj aljflkjalkfjalkj afjlakjfljalkfjalk lafjlakjflkajflk'),
  ];


  Product({required this.name, required this.price, required this.sale});
}