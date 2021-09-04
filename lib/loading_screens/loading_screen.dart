import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  static String id = 'loading';
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  WebServices _webServices = new WebServices();
  bool _loadingFailed = false;

  Future<bool> getData() async{
    setState(() {_loadingFailed = false;});
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
        return true;
      }
      else {
        print('error get all products');
        setState(() {_loadingFailed = true;});
        return false;
      }
    }
    return true;
  }

  getLang() async{
    String? lang = await HelpFunction.getUserLanguage();
    if(lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    String? id = await HelpFunction.getUserid();
    String? email = await HelpFunction.getUserEmail();
    String? name = await HelpFunction.getUserName();
    String? token = await HelpFunction.getUserToken();
    print(id);
    print(token);
    AppUser user = new AppUser(
      id: id != null ? id : '',
      email: email != null ? email : '',
      token: token != null ? token : '',
      firstName: name != null ? name : '',
    );
    Provider.of<ActiveUserProvider>(context, listen: false).setActiveUser(user);
    bool receivedData = await getData();
    if(receivedData)
      Navigator.pushReplacementNamed(context, Home.id);
  }

  dummy() async{
    var response = await _webServices.get(
        'https://souk--server.herokuapp.com/api/product/?slug=6130ad8a61c1854394055530');
    if (response.statusCode == 200) {
      print(response.body);
    }
    else {
      print('error dummy');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
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
                onclick: getLang,
              )
            ],
          ),
        ),
      ),
    );
  }
}
