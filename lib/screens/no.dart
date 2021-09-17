import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class No extends StatefulWidget {
  const No({Key? key}) : super(key: key);

  @override
  _NoState createState() => _NoState();
}

class _NoState extends State<No> {
  var work = FirebaseFirestore.instance.collection('data').snapshots();
  final databaseRef = FirebaseDatabase.instance.reference();

  void addData(String data) async{
    print(1);
    await databaseRef.push().set({'name': data, 'comment': 'true'});
    print('lol');
  }

  void printFirebase(){
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  lol() async{
    var x = await work.first.then((value) => value);
    print('ooooooooooooooooooooooooooo');
    print(x.docs[0]['lol']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
