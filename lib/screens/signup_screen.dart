import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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
                    'Sign up',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  CustomTextField(
                    text: 'First name',
                    obscureText: false,
                    textInputType: TextInputType.text,
                    setValue: _setFirstName,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter an first name';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: 'last name',
                    obscureText: false,
                    textInputType: TextInputType.text,
                    setValue: _setLastName,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter an last name';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: 'Email Address',
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    setValue: _setEmail,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter an email address';
                      if (!value.contains('@') || !value.contains('.'))
                        return 'Invalid email format';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: 'Password',
                    obscureText: true,
                    textInputType: TextInputType.text,
                    setValue: _setPass,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter a password';
                      if (value.length < 6) return 'Short password';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    text: 'Country',
                    obscureText: false,
                    textInputType: TextInputType.text,
                    setValue: _setCountry,
                    validation: (value) {
                      if (value.isEmpty) return 'Enter a country';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Center(
                          child: CountryCodePicker(
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            initialSelection: 'EG',
                            showCountryOnly: true,
                            showFlagMain: false,
                            onChanged: (value){
                              setState(() {
                                _dialCode = value.dialCode!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            text: 'Phone number',
                            obscureText: false,
                            textInputType: TextInputType.phone,
                            setValue: _setPhoneNumber,
                            validation: (value) {
                              if (value.isEmpty) return 'Enter a phone number';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text(
                    'By creating account you accept Terms and Conditions and privacy policy',
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
                  googleOrFacebookLoginButton('Create account with Google', (){}),
                  SizedBox(height: 10,),
                  googleOrFacebookLoginButton('Create account with Facebook', (){}),
                  SizedBox(height: 20,),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: Text(
                          'Login',
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
