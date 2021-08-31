import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:ecommerce/widgets/subscribe_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class ChooseLanguage extends StatefulWidget {
  static String id = 'choose language';

  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains))
        return primaryColor;
      return Colors.grey.shade600;
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Your Language',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: isEnglish,
                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                      checkColor: Colors.white,
                                      activeColor: Colors.white,
                                      onChanged: (value){
                                        setState(() {
                                          isEnglish = !isEnglish;
                                        });
                                      },
                                    ),
                                    Text(
                                      'English',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/uk.png',
                                width: 40,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: !isEnglish,
                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                      checkColor: Colors.white,
                                      activeColor: Colors.white,
                                      onChanged: (value){
                                        setState(() {
                                          isEnglish = !isEnglish;
                                        });
                                      },
                                    ),
                                    Text(
                                      'عربي',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/images/egypt.png',
                                width: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SubscribePanel(
            onclick: () async{
              String lang = isEnglish ? 'en' : 'ar';
              Provider.of<AppLanguageProvider>(context, listen: false).changeLang(lang);
              await HelpFunction.saveUserLanguage(lang);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Home.id, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
