import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/recently_viewed_loading_screen.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/providers/recently_viewed_provider.dart';
import 'package:ecommerce/providers/sales_products_provider.dart';
import 'package:ecommerce/providers/wishlist_provider.dart';
import 'package:ecommerce/loading_screens/all_products_loading_screen.dart';
import 'package:ecommerce/screens/all_products_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/choose_language_screen.dart';
import 'package:ecommerce/screens/feedback_screen.dart';
import 'package:ecommerce/screens/forget_password_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/loading_screens/loading_screen.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/screens/no.dart';
import 'package:ecommerce/screens/order_details_screen.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/product_details_screen.dart';
import 'package:ecommerce/screens/recently_viewed_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:ecommerce/screens/welcome_screen.dart';
import 'package:ecommerce/screens/wishlist_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/widgets/shop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localization.dart';
import 'loading_screens/cart_loading_screen.dart';
import 'loading_screens/orders_loading_screen.dart';
import 'loading_screens/wishlist_loading_screen.dart';
import 'models/product.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  var id = await HelpFunction.getUserid();
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
      ChangeNotifierProvider<AllProductsProvider>(
        create: (context) => AllProductsProvider(),
      ),
      ChangeNotifierProvider<OrdersProvider>(
        create: (context) => OrdersProvider(),
      ),
      ChangeNotifierProvider<CategoriesProvider>(
        create: (context) => CategoriesProvider(),
      ),
      ChangeNotifierProvider<SalesProvider>(
        create: (context) => SalesProvider(),
      ),
    ],
    child: MyApp(id: id,),
  ));
}

class MyApp extends StatefulWidget {
  final String? id;

  const MyApp({Key? key, this.id}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLanguageProvider>(context);
    //String local = widget.lang != null ? widget.lang.toString() : Provider.of<AppLanguageProvider>(context).lang;
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
      locale: Locale(provider.lang, ''),
      home: Splash(),//widget.id != null ? Loading() : Welcome(),
      routes: {
        Welcome.id: (context) => Welcome(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ChooseLanguage.id: (context) => ChooseLanguage(),
        Home.id: (context) => Home(),
        Cart.id: (context) => Cart(),
        Wishlist.id: (context) => Wishlist(),
        RecentlyViewed.id: (context) => RecentlyViewed(),
        Loading.id: (context) => Loading(),
        ForgetPassword.id: (context) => ForgetPassword(),
        WishlistLoading.id: (context) => WishlistLoading(),
        CartLoading.id: (context) => CartLoading(),
        RecentlyViewedLoading.id: (context) => RecentlyViewedLoading(),
        Orders.id: (context) => Orders(),
        OrdersLoading.id: (context) => OrdersLoading(),
      },
    );
  }
}

