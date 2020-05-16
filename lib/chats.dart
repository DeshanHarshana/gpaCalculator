import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: FlatButton(
        child: Text('GPA'),
        onPressed: (){
          Navigator.pushReplacementNamed(context, '/GPA1');
        },
      ),),
      
    );
  }
}