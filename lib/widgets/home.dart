import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/deal_panel.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List top = [1,1,1,1,1];
  List shops = [1,1,1,1];
  List products = [
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
    Product(name: 'name', price: 200, sale: 0),
  ];
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: top.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: size.width * 0.7,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: shops.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 30,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  'Shop',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DealPanel(
            seeAll: () {},
            dealText: 'Flash deal',
            endTime: endTime,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: (){
                  Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(products[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetails(product: products[index])),
                  );
                },
                child: ProductCard(product: products[index],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: DealPanel(
            dealText: 'Promo deal',
            endTime: endTime,
            seeAll: (){},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: (){
                  Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(products[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetails(product: products[index])),
                  );
                },
                child: ProductCard(product: products[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
