
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class Addpage extends StatefulWidget {
  @override
  _AddpageState createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  dynamic data;

  String name = "noData";
  DocumentSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                Firestore.instance
                    .collection('/users')
                    .where('uid', isEqualTo: 'smz6BeJEcBdRgFA6Ebds4x1rt9B3')
                    .getDocuments()
                    .then((docs) {
                  Firestore.instance
                      .document('/users/${docs.documents[0].documentID}')
                      .updateData({
                    "fullxvsdname": 'sdfsd',
                    "PhonesdfsdfNumber": 'sdzcccccccccccfsd',
                    "adrdsfsdfsesse": 'sdfsd'
                  }).then((value) {
                    print('update');
                  });
                });
              },
            ),
            SizedBox(
              width: 20.0,
              height: 5.0,
              child: const Card(child: Text('Hello World!')),
            ),
            Text(
              name,
              style: TextStyle(color: Colors.red, fontSize: 30.0),
            ),
            SizedBox(
              width: 20.0,
              height: 5.0,
              child: const Card(child: Text('Hello World!')),
            ),
            FlatButton(
              child: Text('get'),
              onPressed: () async {
                Firestore.instance.collection("users").where('uid', isEqualTo: 'smz6BeJEcBdRgFA6Ebds4x1rt9B3').getDocuments().then((querySnapshot) {
                  var data=querySnapshot.documents[0];
                  print(data['email']);
                  setState(() {
                    name=data['email'];
                  });
  });
              
              },
            )
          ],
        ),
      ),
    );
  }
  void initState() {
    
    super.initState();
  }
  
}
