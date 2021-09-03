import 'dart:convert';

import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class VerifyEmail extends StatefulWidget {
  final String verifyCode;
  final AppUser user;
  const VerifyEmail({Key? key, required this.verifyCode, required this.user}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();
  String _verifyCode = '';
  String _errorMsg = '';
  WebServices _webServices = new WebServices();
  bool _isLoading = false;

  _setVerifyCode(String verifyCode) {
    _verifyCode = verifyCode;
  }

  _onSubmit() async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      if(_verifyCode == widget.verifyCode){
        print(widget.user.email);
        print(widget.user.firstName);
        print(widget.user.password);
        setState(() {_isLoading = true;});
        var response = await _webServices.post('https://souk--server.herokuapp.com/api/users', {
          "firstName": widget.user.firstName,
          "lastName": widget.user.lastName,
          "email": widget.user.email.trim(),
          "password": widget.user.password,
        });
        if(response.statusCode >= 200 && response.statusCode < 300){
          var body = jsonDecode(response.body);
          AppUser user = new AppUser();
          user.setFromJson(body);
          await HelpFunction.saveUserId(body['_id']);
          await HelpFunction.saveUserToken(body['token']);
          await HelpFunction.saveUserEmail(body['email']);
          await HelpFunction.saveUserName(body['firstName']);
          Provider.of<ActiveUserProvider>(context, listen: false).setActiveUser(user);
          setState(() {_isLoading = false;});
          print('sign up done');
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Loading.id, (Route<dynamic> route) => false);
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
  }

  @override
  Widget build(BuildContext context) {
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
                    'Enter Verify Code',
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
                    text: 'Verify Code',
                    obscureText: false,
                    textInputType: TextInputType.number,
                    setValue: _setVerifyCode,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter verify code';
                      if(value != widget.verifyCode) return 'Invalid code';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    text: 'Verify',
                    onclick: _onSubmit,
                    isLoading: _isLoading,
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
