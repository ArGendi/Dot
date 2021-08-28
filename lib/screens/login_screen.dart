import 'package:ecommerce/constants.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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

  _setEmail(String email) {
    _email = email;
  }
  _setPass(String password) {
    _password = password;
  }

  _onSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      print(_email);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: size.width * .7,
                    height: size.height * .45,
                    color: Colors.grey.shade200,
                  ),
                  SizedBox(height: 30,),
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
                  SizedBox(height: 20,),
                  CustomButton(
                    text: 'Sign in',
                    onclick: _onSubmit,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forget your password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child: Text(
                          'Tap to reset',
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
