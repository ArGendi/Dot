import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentlyViewedBanner extends StatefulWidget {
  const RecentlyViewedBanner({Key? key}) : super(key: key);

  @override
  _RecentlyViewedBannerState createState() => _RecentlyViewedBannerState();
}

class _RecentlyViewedBannerState extends State<RecentlyViewedBanner> {
  @override
  Widget build(BuildContext context) {
    var recentlyViewedProvider = Provider.of<RecentlyViewedProvider>(context);
    return InkWell(
      onTap: (){},
      child: Container(
        height: 140,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: recentlyViewedProvider.items.length,
          itemBuilder: (BuildContext context, int index) {
            //double priceAfterSale = (recentlyViewedProvider.items[index].price / 100) * (100 - recentlyViewedProvider.items[index].sale);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: Image.asset(recentlyViewedProvider.items[index].images[0]),
                  ),
                  SizedBox(height: 5,),
                  Text('\$ ' + recentlyViewedProvider.items[index].discountPrice.toStringAsFixed(2)),
                  SizedBox(width: 5,),
                  Text(
                    '\$ ' + recentlyViewedProvider.items[index].price.toStringAsFixed(2),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
