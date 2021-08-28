import 'package:ecommerce/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

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

  Widget aboutUsCard(){
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
                      Text('About our Services'),
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

  Widget settingsCard(){
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
                      Text('Notifications'),
                      CupertinoSwitch(
                        activeColor: primaryColor,
                        value: _isNotificationOpen,
                        onChanged: (bool value) {
                          setState(() {
                            _isNotificationOpen = !_isNotificationOpen;
                          });
                        },
                      )
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

  Widget infoAboutAppCard(){
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
                  Text('App version'),
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text('Start direct message here'),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5,),
          aboutUsCard(),
          SizedBox(height: 10,),
          Text(
            'Settings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          settingsCard(),
          SizedBox(height: 10,),
          Text(
            'Info about the app',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          infoAboutAppCard(),
        ],
      ),
    );
  }
}
