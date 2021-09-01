import 'package:ecommerce/constants.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/choose_language_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/screens/recently_viewed_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/welcome_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localization.dart';
import 'models/product.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var lang = await HelpFunction.getUserLanguage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ActiveUserProvider>(
        create: (context) => ActiveUserProvider(),
      ),
      ChangeNotifierProvider<WishlistProvider>(
        create: (context) => WishlistProvider(),
      ),
      ChangeNotifierProvider<RecentlyViewedProvider>(
        create: (context) => RecentlyViewedProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(
        create: (context) => CartProvider(),
      ),
      ChangeNotifierProvider<AppLanguageProvider>(
        create: (context) => AppLanguageProvider(),
      ),
    ],
    child: MyApp(lang: lang,),
  ));
}

class MyApp extends StatefulWidget {
  final String? lang;

  const MyApp({Key? key, this.lang}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    String local = widget.lang != null ? widget.lang.toString() : Provider.of<AppLanguageProvider>(context).lang;
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
      locale: Locale(local, ''),
      home: ProductDetails(product: new Product(name: 'name', price: 220, sale: 10),),//widget.lang != null ? Home() : Welcome(),
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ChooseLanguage.id: (context) => ChooseLanguage(),
        Home.id: (context) => Home(),
        Cart.id: (context) => Cart(),
        Wishlist.id: (context) => Wishlist(),
      },
    );
  }
}

