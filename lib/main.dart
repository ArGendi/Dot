import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/choose_language_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/welcome_screen.dart';
import 'package:ecommerce/services/helperFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localization.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Home(),
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ChooseLanguage.id: (context) => ChooseLanguage(),
        Home.id: (context) => Home(),
      },
    );
  }
}

