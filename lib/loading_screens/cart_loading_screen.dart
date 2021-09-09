import 'dart:convert';

import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/services/currency.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CartLoading extends StatefulWidget {
  static String id = 'cart loading';
  const CartLoading({Key? key}) : super(key: key);

  @override
  _CartLoadingState createState() => _CartLoadingState();
}

class _CartLoadingState extends State<CartLoading> {
  WebServices _webServices = new WebServices();
  DBHelper _dbHelper = new DBHelper();

  Future<void> getData() async{
    var provider = Provider.of<CartProvider>(context, listen: false);
    var allProductsProvider = Provider.of<AllProductsProvider>(context, listen: false);
    var recentlyViewedProvider = Provider.of<RecentlyViewedProvider>(context, listen: false);
    if(provider.items.isEmpty) {
      var data = await _dbHelper.getData(cartTable);
      var recentlyViewedData = await _dbHelper.getData(recentlyViewedTable);
      print(data);
      if(data.isEmpty) WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Cart.id);
      });
      for(var product in allProductsProvider.items){
        for(int i=0; i<data.length; i+=1){
          if(product.id == data[i]['id'])
            provider.addItem(product, false);
        }
        for(int i=0; i<recentlyViewedData.length; i+=1){
          if(product.id == recentlyViewedData[i]['id'])
            recentlyViewedProvider.addItem(product, false);
        }
      }
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Cart.id);
      });
      // for(var product in data){
      //   print(product['id']);
      //   var response = await _webServices.get(
      //       serverUrl + 'api/product/?slug=${product['id']}');
      //   if (response.statusCode == 200) {
      //     var body = jsonDecode(response.body);
      //     Product product = new Product();
      //     product.quantityAddedInCart = 1;
      //     product.setProductFromJsom(body['data'][0]);
      //     // for(var image in body['data'][0]['images']) {
      //     //   List<dynamic> imageData = image['data'];
      //     //   List<int> buffer = imageData.cast<int>();
      //     //  // product.images.add(buffer);
      //     // }
      //     provider.addItem(product, false);
      //     Navigator.pushReplacementNamed(context, Cart.id);
      //   }
      //   else {
      //     print('error get all products');
      //     setState(() {_loadingFailed = true;});
      //   }
      // }
    }
    else WidgetsBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, Cart.id);
    });
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
          )
      ),
    );
  }
}
