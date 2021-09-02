import 'package:ecommerce/constants.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  getLang() async{
    String? lang = await HelpFunction.getUserLanguage();
    if(lang != null)
      Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
    Navigator.pushReplacementNamed(context, Home.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
              primaryColor),
        ),
      ),
    );
  }
}
