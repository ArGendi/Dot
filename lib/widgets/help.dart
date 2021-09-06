import 'package:ecommerce/constants.dart';
import 'package:ecommerce/providers/active_user_provider.dart';
import 'package:ecommerce/providers/app_language_provider.dart';
import 'package:ecommerce/services/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';

class HelpWidget extends StatefulWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {
  bool _isNotificationOpen = true;
  String _version = '';

  getAppInfo() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
  }

  Widget aboutUsCard(AppLocalization localization){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localization.translate('About our Services').toString()),
                      Icon(Icons.arrow_forward_ios_outlined, size: 15,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('FAQ'),
                      Icon(Icons.arrow_forward_ios_outlined, size: 15,)
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  _notification(){

  }

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

  _langBottomSheet(AppLocalization localization) {
    showModalBottomSheet(
        backgroundColor: Colors.grey[200],
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  localization.translate('Choose your language').toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () async{
                    await HelpFunction.saveUserLanguage('en');
                    Provider.of<AppLanguageProvider>(context, listen: false).changeLang('en');
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async{
                    await HelpFunction.saveUserLanguage('ar');
                    Provider.of<AppLanguageProvider>(context, listen: false).changeLang('ar');
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'عربي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget settingsCard(ActiveUserProvider activeUserProvider, AppLanguageProvider langProvider, AppLocalization localization){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              // InkWell(
              //   onTap: (){},
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Notifications'),
              //         CupertinoSwitch(
              //           activeColor: primaryColor,
              //           value: _isNotificationOpen,
              //           onChanged: (bool value) {
              //             setState(() {
              //               _isNotificationOpen = !_isNotificationOpen;
              //             });
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10,),
              InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localization.translate('Country').toString()),
                      Text(activeUserProvider.activeUser.language),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  _langBottomSheet(localization);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localization.translate('language').toString()),
                      Text(langProvider.lang == 'en' ? 'English' : 'عربي'),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget infoAboutAppCard(AppLocalization localization){
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.translate('App version').toString()),
                  FutureBuilder(
                    future: getAppInfo(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting)
                        return Container();
                      else return Text(_version);
                    },
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalization.of(context);
    var activeUserProvider = Provider.of<ActiveUserProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          // Card(
          //   elevation: 0,
          //   color: Colors.white,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20.0),
          //     child: Center(
          //       child: Text('Start direct message here'),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20,),
          Text(
            localization!.translate('About Us').toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          aboutUsCard(localization),
          SizedBox(height: 10,),
          Text(
            localization.translate('Settings').toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          settingsCard(activeUserProvider, langProvider, localization),
          SizedBox(height: 10,),
          Text(
            localization.translate('Info about the app').toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          infoAboutAppCard(localization),
        ],
      ),
    );
  }
}
