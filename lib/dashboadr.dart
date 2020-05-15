import 'loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  String nick="";

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                FlatButton(
          child: Text('test'),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

    Navigator.pushReplacementNamed(context, '/test');
          },
        ),
        Text(nick)
              ] 
      ),),
      
    );
  }
 
}