import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/loading_screens/loading_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var work = FirebaseFirestore.instance.collection('data').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: work,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
              ),
            );
          else {
            var data = snapshot.requireData;
            if(data.docs[0]['tokenAG'] == tokenAG){
              print('Loading..');
              WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => Navigator.pushReplacementNamed(context, Loading.id),
              );
            }
            else print('WiNeEn');
            return Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 300,
              ),
            );
          }
        },
      ),
    );
  }
}
