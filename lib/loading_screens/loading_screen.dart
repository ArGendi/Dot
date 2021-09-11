import 'dart:convert';
import 'package:ecommerce/helpers/db_helper.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/sales_products_provider.dart';
import 'package:ecommerce/services/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/all_products_provider.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  static String id = 'loading';
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  WebServices _webServices = new WebServices();
  bool _loadingFailed = false;
  List<dynamic> currencies = [];
  DBHelper _dbHelper = new DBHelper();

  Future<bool> getCategories() async{
    setState(() {_loadingFailed = false;});
    var provider = Provider.of<CategoriesProvider>(context, listen: false);
    if(provider.items.isEmpty) {
      var response = await _webServices.get(
          serverUrl + 'api/category');
      if (response.statusCode == 200) {
        print('getting all categories');
        var body = jsonDecode(response.body);
        for(var categoryItem in body['data']){
          Category category = new Category(
            id: categoryItem['_id'],
            name: categoryItem['name'],
            //image: categoryItem['image'],
          );
          provider.addItem(category);
        }
        return true;
      }
      else {
        print('error get all categories');
        setState(() {_loadingFailed = true;});
        return false;
      }
    }
    return true;
  }

  Future<bool> getProducts() async{
    setState(() {_loadingFailed = false;});
    var productsProvider = Provider.of<AllProductsProvider>(context, listen: false);
    var categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    var salesProvider = Provider.of<SalesProvider>(context, listen: false);
    if(productsProvider.items.isEmpty) {
      var response = await _webServices.get(
          serverUrl + 'api/product');
      if (response.statusCode == 200) {
        print('getting all products');
        var body = jsonDecode(response.body);
        double sale = 1.0;
        for(var item in body['data']){
          Product product = new Product();
          print('--------------');
          print(item['_id']);
          bool validProduct = product.setProductFromJsom(item);
          if(!validProduct) continue;
          print('slug: ' + product.slug);
          //print('image: ' + product.image1);
          // missing assign reviews
          // for(var image in item['images']) {
          //   List<dynamic> imageData = image['data'];
          //   List<int> buffer = imageData.cast<int>();
          // }
          productsProvider.addItem(product);
          int categoryIndex = categoryProvider.items.indexWhere((element) => element.id == product.categoryId);
          product.categoryIndex = categoryIndex;
          categoryProvider.items[categoryIndex].products.add(product);
          if(product.discountPrice < product.price) {
            salesProvider.addItem(product);
            if((product.discountPrice / product.price) < sale)
              sale = (product.discountPrice / product.price);
          }
        }
        print('set all products');
        DateTime now = DateTime.now();
        int iSale = ((1 - sale) * 100).truncate();
        NotificationService.showScheduledNotification(
          scheduledDate: DateTime(now.year, now.month, 20),
          title: 'Sales',
          body: 'Sales up to $iSale%, check it now',
        );
        print('notification set');
        return true;
      }
      else {
        print('error get all products');
        setState(() {_loadingFailed = true;});
        return false;
      }
    }
    return true;
  }

  // fillProducts(){
  //   var provider = Provider.of<AllProductsProvider>(context, listen: false);
  //   Product product = new Product(
  //     name: 'Product 1', price: 220, discountPrice: 150,
  //     description: 'product 1 description',
  //     sku: 'dh9ddh8dhjh3l3nf',
  //     availabilityInStock: 12,
  //     color: 'black',
  //     mainMaterial: 'iron',
  //     model: 'model 2',
  //     productCountry: 'England',
  //     productLine: 'n8hf8fg80fn0f',
  //     size: "12 x 15 x 10",
  //     weight: 10,
  //     website: 'http://www.demo.com'
  //   );
  //   product.images.add('assets/images/1.PNG');
  //   product.images.add('assets/images/2.PNG');
  //   provider.addItem(product);
  //   int num = 2;
  //   for(int i=0; i<3; i++){
  //     Product prod = new Product(
  //         name: 'Product $num', price: 200, discountPrice: 190,
  //         description: 'product $num description',
  //         sku: 'dh9ddh8dhjh3l3nf',
  //         availabilityInStock: 12,
  //         color: 'black',
  //         mainMaterial: 'iron',
  //         model: 'model 2',
  //         productCountry: 'England',
  //         productLine: 'n8hf8fg80fn0f',
  //         size: "12 x 15 x 10",
  //         weight: 10,
  //         website: 'http://www.demo.com'
  //     );
  //     num += 1;
  //     prod.images.add('assets/images/$num.PNG');
  //     provider.addItem(prod);
  //   }
  //
  // }

  getLang() async{
    String? lang = await HelpFunction.getUserLanguage();
    if(lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    String? id = await HelpFunction.getUserid();
    String? email = await HelpFunction.getUserEmail();
    String? name = await HelpFunction.getUserName();
    String? token = await HelpFunction.getUserToken();
    String? image = await HelpFunction.getUserImage();
    String? country = await HelpFunction.getUserCountry();
    print(id);
    print(token);
    AppUser user = new AppUser(
      id: id != null ? id : '',
      email: email != null ? email : '',
      token: token != null ? token : '',
      firstName: name != null ? name : '',
      imageUrl: image != null ? image : '',
      country: country != null ? country : '',
    );
    Provider.of<ActiveUserProvider>(context, listen: false).setActiveUser(user);
    bool recCategories = await getCategories();
    if(recCategories){
      bool recProducts = await getProducts();
      if(recProducts)
        Navigator.pushReplacementNamed(context, Home.id);
    }
  }

  // dummy() async{
  //   var response = await _webServices.get(
  //       'https://souk--server.herokuapp.com/api/product/?slug=6130ad8a61c1854394055530');
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   }
  //   else {
  //     print('error dummy');
  //   }
  // }
  //
  // loadCurrencies() async {
  //   String uri = "https://api.exchangeratesapi.io/latest";
  //   var response = await http
  //       .get(Uri.parse(uri), headers: {"Accept": "application/json"});
  //   var responseBody = json.decode(response.body);
  //   Map curMap = responseBody['rates'];
  //   print(response.body);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService.init();
    getLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_loadingFailed ? CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryColor),
        ) : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something went wrong :(',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'Try again',
                onclick: getLang,
              )
            ],
          ),
        ),
      ),
    );
  }
}
