import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllProductsLoading extends StatefulWidget {
  const AllProductsLoading({Key? key}) : super(key: key);

  @override
  _AllProductsLoadingState createState() => _AllProductsLoadingState();
}

class _AllProductsLoadingState extends State<AllProductsLoading> {
  WebServices _webServices = new WebServices();

  Future<void> getData() async{
    var provider = Provider.of<AllProductsProvider>(context, listen: false);
    if(provider.items.isEmpty) {
      var response = await _webServices.get(
          'https://souk--server.herokuapp.com/api/product');
      if (response.statusCode == 200) {
        print('getting all products');
        var body = jsonDecode(response.body);
        for(var item in body['data']){
          Product product = new Product();
          product.setProductFromJsom(item);
          // missing assign reviews
          for(var image in item['images']) {
            List<dynamic> imageData = image['data'];
            List<int> buffer = imageData.cast<int>();
            product.images.add(buffer);
          }
          provider.addItem(product);
        }
        print('set all products');
      }
      else {
        print('error get all products');
      }
    }
    Navigator.pushReplacementNamed(context, AllProducts.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryColor),
        ),
      ),
    );
  }
}
