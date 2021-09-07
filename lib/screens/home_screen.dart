import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/services/search.dart';
import 'package:ecommerce/widgets/account.dart';
import 'package:ecommerce/widgets/deal_panel.dart';
import 'package:ecommerce/widgets/help.dart';
import 'package:ecommerce/widgets/home.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:ecommerce/widgets/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:package_info/package_info.dart';

import '../app_localization.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List top = [1,1,1,1,1];
  List shops = [1,1,1,1];
  List products = [
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
  ];
  List<Widget> body = [
    HomeWidget(),
    Container(),
    HelpWidget(),
    Shop(),
    AccountWidget()
  ];
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          onTap: (){
            showSearch(context: context, delegate: Search());
          },
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, Cart.id);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: body[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type : BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: localization!.translate('Home').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: localization.translate('Search').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: localization.translate('Help').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: localization.translate('Shop').toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: localization.translate('Account').toString(),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: (value){
            if(value == 1)
              showSearch(context: context, delegate: Search());
            else setState(() {
                _selectedIndex = value;
              });
          },
        ),
    );
  }
}
