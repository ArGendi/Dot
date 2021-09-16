import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class No extends StatefulWidget {
  const No({Key? key}) : super(key: key);

  @override
  _NoState createState() => _NoState();
}

class _NoState extends State<No> {
  var work = FirebaseFirestore.instance.collection('data').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: work,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasError)
            return Center(child: Text('error'));
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: Text('Loading..'));

          final data = snapshot.requireData;
          return Center(child: Text(data.docs[0]['work'].toString()));
        },
      ),
    );
  }
}
