import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/cart_loading_screen.dart';
import 'package:ecommerce/loading_screens/recently_viewed_loading_screen.dart';
import 'package:ecommerce/loading_screens/wishlist_loading_screen.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/recently_viewed_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  Widget infoBelowAppBar(ActiveUserProvider activeUserProvider){
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
                        Image.network(activeUserProvider.activeUser.imageUrl) :
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
                    'Account',
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
              'Hello !!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thanks for patronizing us',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                if(activeUserProvider.activeUser.email.isEmpty)
                InkWell(
                  onTap: (){},
                  child: Text(
                    'Sign in now',
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

  Widget detailsCard(){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              itemInsideCard('My orders', Icons.assignment, (){}),
              itemInsideCard('Messages', Icons.email, (){}),
              itemInsideCard('Notifications', Icons.notifications, (){}),
              itemInsideCard('Product wishlist', Icons.shopping_bag_rounded, (){
                Navigator.pushNamed(context, WishlistLoading.id);
              }),
              itemInsideCard('Recently viewed', Icons.visibility, (){
                Navigator.pushNamed(context, RecentlyViewedLoading.id);
              }),
              itemInsideCard('My cart', Icons.shopping_cart, (){
                Navigator.pushNamed(context, CartLoading.id);
              }),
            ],
          )
      ),
    );
  }

  Widget mySettingsCard(){
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
                      Text('Details'),
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
                      Text('Address'),
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
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        infoBelowAppBar(activeUserProvider),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              detailsCard(),
              SizedBox(height: 10,),
              Text(
                'My settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              mySettingsCard(),
            ],
          ),
        ),
      ],
    );
  }
}
