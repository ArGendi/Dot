import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/widgets/payment_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String _name= '';
  String _state = '';
  String _address = '';
  String _city = '';
  String _phoneNumber = '';
  String _postalCode = '';

  _setName(String name) {
    _name = name;
  }
  _setAddress(String address) {
    _address = address;
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

  _onPersonalInfoSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _personalFormKey.currentState!.validate();
    if(valid){
      _personalFormKey.currentState!.save();
      print(_name);
      print(_postalCode);
      _checkoutBottomSheet();
    }
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

  _checkoutBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Checkout();
        });
  }

  Widget addPersonalInfo(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _personalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              text: 'Name',
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setName,
              validation: (value){
                if (value.isEmpty) return 'Enter your name';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: 'Address',
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setAddress,
              validation: (value){
                if (value.isEmpty) return 'Enter your address';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: 'City',
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setCity,
              validation: (value){
                if (value.isEmpty) return 'Enter your city';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: 'State',
              obscureText: false,
              textInputType: TextInputType.text,
              setValue: _setState,
              validation: (value){
                if (value.isEmpty) return 'Enter your state';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: 'Phone number',
              obscureText: false,
              textInputType: TextInputType.phone,
              setValue: _setPhoneNumber,
              validation: (value){
                if (value.isEmpty) return 'Enter your Phone number';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 5,),
            CustomTextField(
              text: 'Postal code',
              obscureText: false,
              textInputType: TextInputType.number,
              setValue: _setPostalCode,
              validation: (value){
                if (value.isEmpty) return 'Enter your postal code';
                return null;
              },
              whiteColor: true,
            ),
            SizedBox(height: 20,),
            CustomButton(
              text: 'Next',
              onclick: _onPersonalInfoSubmit,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            paymentInfoPart(context, cartProvider),
            addPersonalInfo(),
          ],
        ),
      ),
    );
  }
}
