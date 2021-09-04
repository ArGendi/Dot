import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/loading_screens/loading_screen.dart';
import 'package:ecommerce/screens/verify_email_screen.dart';
import 'package:ecommerce/services/auth_service.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/services/web_services.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/google_fb_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';
import '../app_localization.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  static String id = 'sign up';

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  WebServices _webServices = new WebServices();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _country = '';
  String _phoneNumber = '';
  String _dialCode = '+20';
  bool _isLoading = false;
  bool _isFBLoading = false;
  bool _isGoogleLoading = false;
  String _errorMsg = '';

  _setFirstName(String firstName) {
    _firstName = firstName;
  }
  _setLastName(String lastName) {
    _lastName = lastName;
  }
  _setEmail(String email) {
    _email = email;
  }
  _setPass(String password) {
    _password = password;
  }
  _setCountry(String country) {
    _country = country;
  }
  _setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  signUpWithFacebook() async{
    setState(() {_isFBLoading = true;});
    bool valid = await AuthServices.loginWithFacebook();
    if(valid){
      final profile = await AuthServices.fb.getUserProfile();
      final email = await AuthServices.fb.getUserEmail();
      //final image = await AuthServices.fb.getProfileImageUrl(width: 100);
      sendFacebookInfoToBackend(profile!.firstName, profile.lastName, email);
    }
  }

  sendFacebookInfoToBackend(String? firstName, String? lastName, String? email) async{
    var response = await _webServices.post('https://souk--server.herokuapp.com/api/users/facebooksignup', {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
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
      setState(() {_isFBLoading = false;});
      print('facebook sent to backend');
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
      var response = await _webServices.post('https://souk--server.herokuapp.com/api/users/verifyemail', {
        "name": _firstName,
        "email": _email.trim(),
      });
      if(response.statusCode >= 200 && response.statusCode < 300){
        print(response.body);
        AppUser user = new AppUser(
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          password: _password,
        );
        setState(() {_isLoading = false;});
        print('go to verify');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyEmail(
            verifyCode: response.body,
            user: user,
          )),
        );
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
                    localization!.translate('Sign up').toString(),
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
                    text: localization.translate('First name').toString(),
                    obscureText: false,
                    textInputType: TextInputType.text,
                    setValue: _setFirstName,
                    validation: (value) {
                      if (value.isEmpty) return localization.translate('Enter an first name').toString();
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: localization.translate('last name').toString(),
                    obscureText: false,
                    textInputType: TextInputType.text,
                    setValue: _setLastName,
                    validation: (value) {
                      if (value.isEmpty) return localization.translate('Enter an last name').toString();
                      return null;
                    },
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
                  // SizedBox(height: 10,),
                  // CustomTextField(
                  //   text: 'Country',
                  //   obscureText: false,
                  //   textInputType: TextInputType.text,
                  //   setValue: _setCountry,
                  //   validation: (value) {
                  //     if (value.isEmpty) return 'Enter a country';
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 10,),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: primaryColor,
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Center(
                  //         child: CountryCodePicker(
                  //           textStyle: TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //           initialSelection: 'EG',
                  //           showCountryOnly: true,
                  //           showFlagMain: false,
                  //           onChanged: (value){
                  //             setState(() {
                  //               _dialCode = value.dialCode!;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: CustomTextField(
                  //           text: 'Phone number',
                  //           obscureText: false,
                  //           textInputType: TextInputType.phone,
                  //           setValue: _setPhoneNumber,
                  //           validation: (value) {
                  //             if (value.isEmpty) return 'Enter a phone number';
                  //             return null;
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 25,),
                  Text(
                    localization.translate('By creating account you accept Terms and Conditions and privacy policy').toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    text: 'Sign up',
                    onclick: _onSubmit,
                    isLoading: _isLoading,
                  ),
                  SizedBox(height: 20,),
                  GoogleFbButton(
                    text: localization.translate('Create account with Google').toString(),
                    onClick: (){},
                    isFb: false,
                    isFBLoading: _isFBLoading,
                    isGoogleLoading: _isGoogleLoading,
                  ),
                  SizedBox(height: 10,),
                  GoogleFbButton(
                    text: localization.translate('Create account with Facebook').toString(),
                    onClick: signUpWithFacebook,
                    isFb: true,
                    isFBLoading: _isFBLoading,
                    isGoogleLoading: _isGoogleLoading,
                  ),
                  SizedBox(height: 20,),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.translate('Already have an account?').toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Login.id);
                        },
                        child: Text(
                          localization.translate('Sign in').toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
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
