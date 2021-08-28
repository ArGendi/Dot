import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/widgets/deal_panel.dart';
import 'package:ecommerce/widgets/help.dart';
import 'package:ecommerce/widgets/home.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:package_info/package_info.dart';

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
    Container(),
    Container(),
  ];
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Help',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: (value){
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
    );
  }
}
