import 'package:ecommerce/constants.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/screens/choose_language_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/welcome_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'app_localization.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActiveUserProvider>(
          create: (context) => ActiveUserProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (context) => WishlistProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        theme: ThemeData(
          fontFamily: 'openSans',
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
        ),
        supportedLocales: [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales){
          for(var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
        home: Wishlist(),
        routes: {
          Welcome.id: (context) => Welcome(),
          Login.id: (context) => Login(),
          SignUp.id: (context) => SignUp(),
          ChooseLanguage.id: (context) => ChooseLanguage(),
          Home.id: (context) => Home(),
        },
      ),
    );
  }
}

