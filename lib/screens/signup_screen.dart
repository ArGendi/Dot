import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../app_localization.dart';
import 'login_screen.dart';

class SignUp extends StatefulWidget {
  static String id = 'sign up';

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _country = '';
  String _phoneNumber = '';
  String _dialCode = '+20';

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

  Widget googleOrFacebookLoginButton(String text, VoidCallback onclick){
    return InkWell(
      onTap: onclick,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: primaryColor)
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  _onSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      print(_firstName);
      print(_phoneNumber);
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
                  SizedBox(height: 20,),
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
                  ),
                  SizedBox(height: 20,),
                  googleOrFacebookLoginButton(localization.translate('Create account with Google').toString(), (){}),
                  SizedBox(height: 10,),
                  googleOrFacebookLoginButton(localization.translate('Create account with Facebook').toString(), (){}),
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
