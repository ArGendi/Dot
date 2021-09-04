import 'dart:convert';

import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../loading_screens/loading_screen.dart';

class ForgetPassword extends StatefulWidget {
  static String id = 'forget password';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _errorMsg = '';
  bool _appearText = false;
  WebServices _webServices = new WebServices();
  bool _isLoading = false;

  _setEmail(String email) {
    _email = email;
  }

  _onSubmit() async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      setState(() {_isLoading = true;});
      var response = await _webServices.post('https://souk--server.herokuapp.com/api/users/forgotpassword', {
        "email": _email.trim(),
      });
      if(response.statusCode >= 200 && response.statusCode < 300){
        setState(() {
          _isLoading = false;
          _appearText = true;
        });
        print('email sent');
      }
      else{
        setState(() {
          var body = jsonDecode(response.body);
          _errorMsg = body['message'];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30,),
                  if(_errorMsg.isNotEmpty)
                    Text(
                      _errorMsg,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: localization!.translate('Email Address').toString(),
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    setValue: _setEmail,
                    validation: (value) {
                      if (value.isEmpty) return localization.translate('Enter an email address').toString();
                      if (!value.contains('@') || !value.contains('.'))
                        return localization.translate('Invalid email format').toString();
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    text: 'Next',
                    onclick: _onSubmit,
                    isLoading: _isLoading,
                  ),
                  SizedBox(height: 30,),
                  if(_appearText)
                    Text(
                      'Check your email to reset your password',
                      style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
