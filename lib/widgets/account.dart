import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/loading_screens/orders_loading_screen.dart';
import 'package:ecommerce/loading_screens/recently_viewed_loading_screen.dart';
import 'package:ecommerce/loading_screens/wishlist_loading_screen.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/recently_viewed_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  Widget infoBelowAppBar(ActiveUserProvider activeUserProvider, AppLocalization localization){
    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(activeUserProvider.activeUser.email.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activeUserProvider.activeUser.firstName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22,
                    child: activeUserProvider.activeUser.imageUrl.isNotEmpty ?
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.network(
                            activeUserProvider.activeUser.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ) :
                        Center(
                          child: Icon(Icons.person, color: primaryColor,),
                        ),
                  )
                ],
              ),
            if(activeUserProvider.activeUser.email.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.translate('Account').toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22,
                    //child: Image.network(activeUserProvider.activeUser.imageUrl),
                  )
                ],
              ),
            SizedBox(height: 10,),
            Text(
              localization.translate('Hello !!').toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.translate('We are happy to be here :)').toString(),
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                if(activeUserProvider.activeUser.email.isEmpty)
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, SignUp.id);
                  },
                  child: Text(
                    localization.translate('Sign up now').toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsCard(AppLocalization localization, BuildContext context){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              itemInsideCard(localization.translate('My orders').toString(), Icons.assignment, (){
                Navigator.pushNamed(context, OrdersLoading.id);
              }),
              //itemInsideCard(localization.translate('Messages').toString(), Icons.email, (){}),
              //itemInsideCard('Notifications', Icons.notifications, (){}),
              itemInsideCard(localization.translate('Product wishlist').toString(), Icons.shopping_bag_rounded, (){
                Navigator.pushNamed(context, WishlistLoading.id);
              }),
              itemInsideCard(localization.translate('Recently viewed').toString(), Icons.visibility, (){
                Navigator.pushNamed(context, RecentlyViewedLoading.id);
              }),
              itemInsideCard(localization.translate('My cart').toString(), Icons.shopping_cart, (){
                Navigator.pushNamed(context, CartLoading.id);
              }),
            ],
          )
      ),
    );
  }

  Widget mySettingsCard(AppLocalization localization){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Text(localization.translate('Details').toString()),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Text(localization.translate('Address').toString()),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget itemInsideCard(String text, IconData icon, VoidCallback onClick){
    return  InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                SizedBox(width: 10,),
                Text(text),
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined, size: 15,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        infoBelowAppBar(activeUserProvider, localization!),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.translate('Details').toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              detailsCard(localization, context),
              SizedBox(height: 10,),
              Text(
                localization.translate('My settings').toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              mySettingsCard(localization),
            ],
          ),
        ),
      ],
    );
  }
}
