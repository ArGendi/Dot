import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/screens/forget_password_screen.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/google_fb_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../loading_screens/loading_screen.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorMsg = '';
  WebServices _webServices = new WebServices();
  bool _isLoading = false;
  bool _isFBLoading = false;
  bool _isGoogleLoading = false;

  _setEmail(String email) {
    _email = email;
  }
  _setPass(String password) {
    _password = password;
  }

  loginWithFacebook() async{
    setState(() {_isFBLoading = true;});
    bool valid = await AuthServices.loginWithFacebook();
    if(valid){
      final email = await AuthServices.fb.getUserEmail();
      sendFacebookInfoToBackend(email);
    }
  }

  sendFacebookInfoToBackend(String? email) async{
    var response = await _webServices.post('https://souk--server.herokuapp.com/api/users/facebooklogin', {
      "email": email,
    });
    if(response.statusCode >= 200 && response.statusCode < 300){
      var body = jsonDecode(response.body);
      AppUser user = new AppUser(
        id: body['_id'],
        email: body['email'],
        firstName: body['firstName'],
        lastName: body['lastName'],
        token: body['token'],
      );
      await HelpFunction.saveUserId(body['_id']);
      await HelpFunction.saveUserToken(body['token']);
      await HelpFunction.saveUserEmail(body['email']);
      await HelpFunction.saveUserName(body['firstName']);
      Provider.of<ActiveUserProvider>(context, listen: false).setActiveUser(user);
      setState(() {_isFBLoading = false;});
      print('facebook login sent to backend');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Loading.id, (Route<dynamic> route) => false);
    }
    else{
      setState(() {
        var body = jsonDecode(response.body);
        _errorMsg = body['message'];
        _isFBLoading = false;
      });
    }
  }

  _onSubmit() async{
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      setState(() {_isLoading = true;});
      var response = await _webServices.post('https://souk--server.herokuapp.com/api/users/login', {
        "email": _email.trim(),
        "password": _password,
      });
      if(response.statusCode >= 200 && response.statusCode < 300){
        var body = jsonDecode(response.body);
        AppUser user = new AppUser(
          id: body['_id'],
          firstName: body['firstName'],
          lastName: body['lastName'],
          email: body['email'],
          token: body['token']
        );
        await HelpFunction.saveUserId(body['_id']);
        await HelpFunction.saveUserToken(body['token']);
        await HelpFunction.saveUserEmail(body['email']);
        await HelpFunction.saveUserName(body['firstName']);
        Provider.of<ActiveUserProvider>(context, listen: false).setActiveUser(user);
        setState(() {_isLoading = false;});
        print('login done');
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

  dummy() async{
    String? x = await HelpFunction.getUserToken();
    print(x);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dummy();
  }

  //localization!.translate('Welcome to').toString()
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Text(
                    localization!.translate('Sign in').toString(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: size.width * .7,
                    height: size.height * .3,
                    color: Colors.grey.shade200,
                  ),
                  SizedBox(height: 20,),
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
                    text: localization.translate('Email Address').toString(),
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
                  CustomTextField(
                    text: localization.translate('Password').toString(),
                    obscureText: true,
                    textInputType: TextInputType.text,
                    setValue: _setPass,
                    validation: (value) {
                      if (value.isEmpty) return localization.translate('Enter a password').toString();
                      if (value.length < 6) return localization.translate('Short password').toString();
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomButton(
                    text: localization.translate('Sign in').toString(),
                    onclick: _onSubmit,
                    isLoading: _isLoading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.translate('Forget your password?').toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, ForgetPassword.id);
                        },
                        child: Text(
                          localization.translate('Tap to reset').toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  GoogleFbButton(
                    text: 'Login with Google',
                    onClick: (){},
                    isFb: false,
                    isFBLoading: _isFBLoading,
                    isGoogleLoading: _isGoogleLoading,
                  ),
                  SizedBox(height: 10,),
                  GoogleFbButton(
                    text: 'Login with Facebook',
                    onClick: loginWithFacebook,
                    isFb: true,
                    isFBLoading: _isFBLoading,
                    isGoogleLoading: _isGoogleLoading,
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
