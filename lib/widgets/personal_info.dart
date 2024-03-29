import 'package:ecommerce/models/info.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/payment_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../constants.dart';
import 'checkout.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _personalFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _name= '';
  String _state = '';
  String _address = '';
  String _country = '';
  String _city = '';
  String _phoneNumber = '';
  String _postalCode = '';
  WebServices _webServices = new WebServices();
  List<Map<String, dynamic>> _orderItems = [];

  _setName(String name) {
    _name = name;
  }
  _setAddress(String address) {
    _address = address;
  }

  _setCountry(String country) {
    _country = country;
  }

  _setCity(String city) {
    _city = city;
  }
  _setState(String state) {
    _state = state;
  }
  _setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }
  _setPostalCode(String postalCode) {
    _postalCode = postalCode;
  }

  _onPersonalInfoSubmit(AppLocalization localization) async{
    FocusScope.of(context).unfocus();
    bool valid = _personalFormKey.currentState!.validate();
    if(valid){
      _personalFormKey.currentState!.save();
      print(_name);
      print(_postalCode);
      var cartProvider = Provider.of<CartProvider>(context, listen: false);
      //int delivery = 0;
      int tax = 0;
      int sum = 0;
      for(var item in cartProvider.items) {
        _orderItems.add({
          'name': item.name,
          'qty': item.quantityAddedInCart,
          'price': item.discountPrice,
          'product': item.id,
          'image': "image",
        });
        sum += item.discountPrice * item.quantityAddedInCart;
        tax += item.tax;
      }
      setState(() {_isLoading = true;});
      await HelpFunction.saveUserCountry(_country);
      Provider.of<ActiveUserProvider>(context, listen: false).setCountry(_country);
      String token = Provider.of<ActiveUserProvider>(context, listen: false).activeUser.token;
      var response = await _webServices.postWithBearerToken(serverUrl + 'api/orders', token, {
        'orderItems': _orderItems,
        'shippingAddress': {
          'address': _address,
          'city': _city,
          'postalCode': _postalCode,
          'country': _country
        },
        'paymentMethod': 'Cash on delivery',
        'totalPrice': (sum + tax),
        'phoneNumber': _phoneNumber,
      });
      print(response.statusCode);
      print(response.reasonPhrase);
      if(response.statusCode >= 200 && response.statusCode < 300) {
        Order order = new Order(products: []);
        order.products = [...Provider
            .of<CartProvider>(context, listen: false)
            .items
        ];
        Provider.of<OrdersProvider>(context, listen: false)
            .addItem(order);
        Navigator.pop(context);
        Provider.of<CartProvider>(context, listen: false).removeAllItems();
        for(var item in cartProvider.items)
          item.addedToCart = false;
        setState(() {_isLoading = false;});
        showMsgDialog(localization.translate("Order submitted successfully :)").toString(), localization);
      }
      else {
        setState(() {_isLoading = false;});
        showMsgDialog(localization.translate("Something went wrong try again !!").toString(), localization);
      }
    }
  }

  showMsgDialog(String text, AppLocalization localization){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    localization.translate('Get it').toString(),
                    style: TextStyle(
                        color: primaryColor
                    ),
                  )
              ),
            )
          ],
        );
      },
    );
  }

  Widget paymentInfoPart(BuildContext context, CartProvider cartProvider){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PaymentInfo(),
      ),
    );
  }

  // _checkoutBottomSheet(Info info) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.grey[200],
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (context){
  //         return Checkout(info: info,);
  //       });
  // }

  Widget addPersonalInfo(AppLocalization localization){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _personalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              text: localization.translate('Name').toString(),
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setName,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your name').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('Address').toString(),
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setAddress,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your address').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('Country').toString(),
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setCountry,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your country').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('City').toString(),
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setCity,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your city').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('State').toString(),
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setState,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your state').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('Phone number').toString(),
              obscureText: false,
              textInputType: TextInputType.phone,
              setValue: _setPhoneNumber,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your Phone number').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: localization.translate('Postal code').toString(),
              obscureText: false,
              textInputType: TextInputType.number,
              setValue: _setPostalCode,
              validation: (value){
                if (value.isEmpty) return localization.translate('Enter your postal code').toString();
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.monetization_on, color: primaryColor,),
                SizedBox(width: 5,),
                Text(
                  localization.translate('Cash on delivery').toString(),
                  style: TextStyle(),
                ),
              ],
            ),
            SizedBox(height: 5,),
            CustomButton(
              text: localization.translate('Validate order').toString(),
              onclick: (){
                _onPersonalInfoSubmit(localization);
              },
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            paymentInfoPart(context, cartProvider),
            addPersonalInfo(localization!),
          ],
        ),
      ),
    );
  }
}
