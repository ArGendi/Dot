import 'package:ecommerce/app_localization.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/subscribe_panel.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  static String id = 'welcome';

  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localization!.translate('Welcome to').toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Mobile App Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SubscribePanel(
            onclick: (){

            },
          ),
        ],
      ),
    );
  }
}
