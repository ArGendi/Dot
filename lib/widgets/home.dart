import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/providers/sales_products_provider.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/widgets/deal_panel.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<String> images = [
    'assets/images/home_banner_1.jpeg',
    'assets/images/home_banner_2.jpeg'
  ];
  var endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AllProductsProvider>(context);
    var recentlyViewedProvider = Provider.of<RecentlyViewedProvider>(context);
    var salesProvider = Provider.of<SalesProvider>(context);
    var categoryProvider = Provider.of<CategoriesProvider>(context);
    var localization = AppLocalization.of(context);
    // Locale locale = Localizations.localeOf(context);
    // print(locale.toString());
    // var format = NumberFormat.simpleCurrency(locale: 'ar');
    // print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    // print("CURRENCY NAME ${format.currencyName}");
    var size = MediaQuery.of(context).size;

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 150,
          child: CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                ),
              ),
            options: CarouselOptions(
              //aspectRatio: 16/9,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          // child: ListView.builder(
          //   controller: _scrollController,
          //   scrollDirection: Axis.horizontal,
          //   shrinkWrap: true,
          //   itemCount: images.length,
          //   itemBuilder: (context, index){
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 2),
          //       child: Container(
          //         width: size.width * 0.7,
          //         color: Colors.white,
          //         child: Image.asset(
          //           images[index],
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
        SizedBox(height: 10,),
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
                        itemCount: categoryProvider.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AllProducts(products: categoryProvider.items[index].products)),
                              );
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  radius: 30,
                                  child: categoryProvider.items[index].image.isNotEmpty?
                                        Image.network(categoryProvider.items[index].image) :
                                        Container(),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  categoryProvider.items[index].name,
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: DealPanel(
        //     seeAll: () {},
        //     dealText: 'Flash deal',
        //     endTime: endTime,
        //   ),
        // ),
        //
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   child: GridView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 5,
        //       mainAxisSpacing: 5,
        //     ),
        //     itemCount: products.length,
        //     itemBuilder: (BuildContext context, int index){
        //       return InkWell(
        //         onTap: (){
        //           Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(products[index], true);
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => ProductDetails(product: products[index])),
        //           );
        //         },
        //         child: ProductCard(
        //           product: products[index],
        //           onClick: (){},
        //         ),
        //       );
        //     },
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        //   child: DealPanel(
        //     dealText: 'Promo deal',
        //     endTime: endTime,
        //     seeAll: (){},
        //   ),
        // ),
        InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllProducts(products: salesProvider.items)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization!.translate('Sales').toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
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
            itemCount: salesProvider.items.length >= 4 ? 4 : salesProvider.items.length,
            itemBuilder: (BuildContext context, int index){
              return ProductCard(
                product: salesProvider.items[index],
                onClick: (){
                  Provider.of<RecentlyViewedProvider>(context, listen: false).addItem(salesProvider.items[index], true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetails(product: salesProvider.items[index],)),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: 20,),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        //   child: GridView.builder(
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 5,
        //       mainAxisSpacing: 5,
        //     ),
        //     itemCount: categoryProvider.items.length >= 4 ? 4 : categoryProvider.items.length,
        //     itemBuilder: (BuildContext context, int index){
        //       return InkWell(
        //         onTap: (){
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => AllProducts(products: categoryProvider.items[index].products)),
        //           );
        //         },
        //         child: Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(width: 3, color: primaryColor)
        //           ),
        //           child: Stack(
        //             children: [
        //               Image.asset(
        //                 'assets/images/1.PNG',
        //                 fit: BoxFit.cover,
        //               ),
        //               Center(
        //                 child: Text(
        //                   categoryProvider.items[index].name,
        //                   style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
