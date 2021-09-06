import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate{
  List<Product> mostChecked = [
    Product(name: 'name', price: 200, sale: 10),
    Product(name: 'name', price: 200, sale: 0),
  ];

  List<Product> general = [
    Product(name: 'name', price: 200, sale: 10),
    Product(name: 'name', price: 200, sale: 0),
  ];

  List<Product> mostViewed = [
    Product(name: 'name', price: 200, sale: 10),
    Product(name: 'name', price: 200, sale: 0),
  ];

  Widget panel(String text, VoidCallback onClick){
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: onClick,
              child: Text(
                'See all',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: primaryColor,
        ),
        onPressed: (){
          query = '';
        },
      )
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        color: primaryColor,
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    var provider = Provider.of<AllProductsProvider>(context);
    List<Product> filteredList = provider.items.where((element) => element.name.contains(query)).toList();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index){
          return ProductCard(
            product: filteredList[index],
            onClick: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetails(product: filteredList[index])),
              );
            },
          );
        },
      ),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          panel('Most checked', () {}),
          SizedBox(height: 10,),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: mostChecked.length,
            itemBuilder: (BuildContext context, int index){
              return ProductCard(
                product: mostChecked[index],
                onClick: (){},
              );
            },
          ),
          SizedBox(height: 10,),
          panel('General product', () {}),
          SizedBox(height: 10,),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: general.length,
            itemBuilder: (BuildContext context, int index){
              return ProductCard(
                product: general[index],
                onClick: (){},
              );
            },
          ),
          SizedBox(height: 10,),
          //ad banner
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.white,
            child: Text(' Advert banner'),
          ),
          SizedBox(height: 10,),
          panel('Most viewed', () {}),
          SizedBox(height: 10,),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: mostViewed.length,
            itemBuilder: (BuildContext context, int index){
              return ProductCard(
                product: mostViewed[index],
                onClick: (){},
              );
            },
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }

}