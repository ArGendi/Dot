import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class No extends StatefulWidget {
  const No({Key? key}) : super(key: key);

  @override
  _NoState createState() => _NoState();
}

class _NoState extends State<No> {
  Stream<QuerySnapshot> bol = FirebaseFirestore.instance.collection('data').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bol,
        builder: (context, AsyncSnapshot<QuerySnapshot> lol){
          if(!lol.hasData) return Center(
            child: Text('Waiting..'),
          );
          else {
            final data = lol.requireData;
            print(data.docs);
            return Container();
            // return Center(child: Text(data.docs[0]['isWork'].toString()));
          }
        },
      ),
    );
  }
}
