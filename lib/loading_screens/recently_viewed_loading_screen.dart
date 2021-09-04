import 'dart:convert';

import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/screens/recently_viewed_screen.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RecentlyViewedLoading extends StatefulWidget {
  static String id = 'recently viewed loading';
  const RecentlyViewedLoading({Key? key}) : super(key: key);

  @override
  _RecentlyViewedLoadingState createState() => _RecentlyViewedLoadingState();
}

class _RecentlyViewedLoadingState extends State<RecentlyViewedLoading> {
  WebServices _webServices = new WebServices();
  DBHelper _dbHelper = new DBHelper();
  bool _loadingFailed = false;

  Future<void> getData() async{
    setState(() {_loadingFailed = false;});
    var provider = Provider.of<RecentlyViewedProvider>(context, listen: false);
    if(provider.items.isEmpty) {
      var data = await _dbHelper.getData(recentlyViewedTable);
      print(data);
      if(data.isEmpty) Navigator.pushReplacementNamed(context, RecentlyViewed.id);
      for(var product in data){
        var response = await _webServices.get(
            'https://souk--server.herokuapp.com/api/product/?slug=${product['id']}');
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          Product product = new Product();
          product.setProductFromJsom(body['data'][0]);
          for(var image in body['data'][0]['images']) {
            List<dynamic> imageData = image['data'];
            List<int> buffer = imageData.cast<int>();
            product.images.add(buffer);
          }
          provider.addItem(product, false);
          Navigator.pushReplacementNamed(context, RecentlyViewed.id);
        }
        else {
          print('error get all products');
          setState(() {_loadingFailed = true;});
        }
      }
    }
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
        child: !_loadingFailed ? CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryColor),
        ) : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something went wrong :(',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'Try again',
                onclick: getData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
