import 'package:ecommerce/models/review.dart';
import 'package:flutter/cupertino.dart';

class Product{
  String id = '';
  String name = '';
  String description = '';
  String subCategory = '';
  String brand = '';
  int price = 0;
  int sale = 0;
  int discountPrice = 0;
  List<List<int>> images = [];
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
  int weight = 0;
  String website = '';
  int shippingDays = 0;
  String unitPrice = '';
  int tax = 0;
  String seller = '';
  List<Review> reviews = [];
  String orderDate = '';
  String deliveryDate = '';
  String status = '';

  Product({this.name = 'product', this.price = 0, this.sale = 0, this.rate =0,this.isFavourite=false, this.availabilityInStock=0,
          this.quantityAddedInCart = 0, this.website = '', this.weight = 0, this.size = '', this.productLine = '', this.productCountry = '',
          this.model = '', this.mainMaterial = '', this.color = '', this.sku = '', this.description = '', this.discountPrice = 0});

  setProductFromJsom(Map<String, dynamic> json){
    rate = json['rating'];
    id = json['_id'];
    name = json['name'];
    subCategory = json['subcategory'];
    price = json['originalPrice'];
    discountPrice = json['discountPrice'];
    //sale = json['discountPrice'];
    description = json['details'];
    brand = json['brand'];
    color = json['color'];
    availabilityInStock = json['quantity'];
    sku = json['sku'];
    mainMaterial = json['mainMaterial'];
    model = json['model'];
    productCountry = json['productionCountry'];
    productLine = json['productLine'];
    size = json['size'];
    website = json['website'];
    tax = json['tax'];
    unitPrice = json['unitPrice'];
    shippingDays = json['shippingDays'];
    seller = json['seller'];
  }
}