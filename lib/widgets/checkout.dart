import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/orders_provider.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/payment_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'custom_button.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool _isCreditCard = true;
  bool _saveCreditCard = false;
  bool _savePayPal = false;
  bool _validate = false;
  final _creditFormKey = GlobalKey<FormState>();
  final _paypalFormKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _nameOnCard = '';
  String _validTill = '';
  String _cvc = '';
  String _paypalEmail = '';
  String _password = '';
  String _amount = '';


  _setCardNumber(String cardNumber) {
    _cardNumber = cardNumber;
  }
  _setNameOnCard(String nameOnCard) {
    _nameOnCard = nameOnCard;
  }

  _setValidTill(String validTill) {
    _validTill = validTill;
  }
  _setCVC(String cvc) {
    _cvc = cvc;
  }
  _setPaypalEmail(String paypalEmail) {
    _paypalEmail = paypalEmail;
  }

  _setPassword (String password ) {
    _password  = password ;
  }
  _setAmount(String amount) {
    _amount = amount;
  }

  Widget paymentInfoPart(BuildContext context, CartProvider cartProvider){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: primaryColor,),
                  SizedBox(width: 5,),
                  Text(
                    'Personal info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5,),
            PaymentInfo(),
          ],
        ),
      ),
    );
  }

  Widget addCreditInfoPart(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    _isCreditCard = !_isCreditCard;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'Credit card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: _isCreditCard ? FontWeight.bold : FontWeight.normal,
                        color: _isCreditCard ? Colors.black : Colors.grey
                      ),
                    ),
                    SizedBox(height: 5,),
                    if(_isCreditCard)
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  setState(() {
                    _isCreditCard = !_isCreditCard;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'PayPal',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: !_isCreditCard ? FontWeight.bold : FontWeight.normal,
                          color: !_isCreditCard ? Colors.black : Colors.grey
                      ),
                    ),
                    SizedBox(height: 5,),
                    if(!_isCreditCard)
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.black
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          if(_isCreditCard)
            creditCard(),
          if(!_isCreditCard)
            paypal(),
        ],
      ),
    );
  }

  Widget creditCard(){
    return Form(
      key: _creditFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            text: 'Card number',
            obscureText: false,
            textInputType: TextInputType.number,
            setValue: _setCardNumber,
            validation: (value){
              if (value.isEmpty) return 'Enter card number';
              return null;
            },
            whiteColor: true,
          ),
          SizedBox(height: 5,),
          CustomTextField(
            text: 'Name on card',
            obscureText: false,
            textInputType: TextInputType.text,
            setValue: _setNameOnCard,
            validation: (value){
              if (value.isEmpty) return 'Enter name on card';
              return null;
            },
            whiteColor: true,
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  text: 'Valid till',
                  obscureText: false,
                  textInputType: TextInputType.datetime,
                  setValue: _setValidTill,
                  validation: (value){
                    if (value.isEmpty) return 'Enter name on card';
                    return null;
                  },
                  whiteColor: true,
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: CustomTextField(
                  text: 'CVC / CVV',
                  obscureText: false,
                  textInputType: TextInputType.number,
                  setValue: _setCVC,
                  validation: (value){
                    if (value.isEmpty) return 'Enter name on card';
                    return null;
                  },
                  whiteColor: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'I want to save credit card info to pay for future purchases',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              CupertinoSwitch(
                activeColor: primaryColor,
                value: _saveCreditCard,
                onChanged: (bool value) {
                  setState(() {
                    _saveCreditCard = !_saveCreditCard;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          CustomButton(
            text: !_validate ? 'Validate orders' : "Done",
            onclick: _onCreditCardSubmit,
          ),
        ],
      ),
    );
  }

  Widget paypal(){
    return Form(
      key: _paypalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            text: 'PayPal email address',
            obscureText: false,
            textInputType: TextInputType.emailAddress,
            setValue: _setPaypalEmail,
            validation: (value){
              if (value.isEmpty) return 'Enter PayPal email address';
              if (!value.contains('@') || !value.contains('.'))
                return 'Invalid email format';
              return null;
            },
            whiteColor: true,
          ),
          SizedBox(height: 5,),
          CustomTextField(
            text: 'Password',
            obscureText: true,
            textInputType: TextInputType.text,
            setValue: _setPassword,
            validation: (value){
              if (value.isEmpty) return 'Enter Password';
              return null;
            },
            whiteColor: true,
          ),
          SizedBox(height: 5,),
          CustomTextField(
            text: 'Amount',
            obscureText: false,
            textInputType: TextInputType.text,
            setValue: _setAmount,
            validation: (value){
              if (value.isEmpty) return 'Enter amount';
              return null;
            },
            whiteColor: true,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'I want to save PayPal info to pay for future purchases',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              CupertinoSwitch(
                activeColor: primaryColor,
                value: _savePayPal,
                onChanged: (bool value) {
                  setState(() {
                    _savePayPal = !_savePayPal;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20,),
          CustomButton(
            text: !_validate ? 'Validate orders' : "Done",
            onclick: _onPayPalSubmit,
          ),
        ],
      ),
    );
  }

  _onCreditCardSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _creditFormKey.currentState!.validate();
    if(valid){
      _creditFormKey.currentState!.save();
      print(_nameOnCard);
      print(_cvc);
      Order order = new Order(products: []);
      order.products = [...Provider.of<CartProvider>(context, listen: false).items];
      Provider.of<OrdersProvider>(context, listen: false).addItemInOpenedOrders(order);
      setState(() {
        _validate = true;
      });
    }
  }

  _onPayPalSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _paypalFormKey.currentState!.validate();
    if(valid){
      _paypalFormKey.currentState!.save();
      print(_paypalEmail);
      print(_password);
      Order order = new Order(products: []);
      order.products = [...Provider.of<CartProvider>(context, listen: false).items];
      Provider.of<OrdersProvider>(context, listen: false).addItemInOpenedOrders(order);
      setState(() {
        _validate = true;
      });
    }
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
            addCreditInfoPart(),
          ],
        ),
      ),
    );
  }
}
