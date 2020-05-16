import 'dart:ui';

import 'package:flutter/material.dart';

class GPA1 extends StatefulWidget {
  @override
  _GPA1State createState() => _GPA1State();
}

class _GPA1State extends State<GPA1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   Column(children: <Widget>[
            Flexible(
                  child: Container(
             width: 100,
             child: TextFormField(
  decoration: const InputDecoration(
    
  ))
        ,
           ),
         )
          ],),
          Column(children: <Widget>[
            Flexible(
                  child: Container(
             width: 100,
             child: TextFormField(
  decoration: const InputDecoration(
    
  ))
        ,
           ),
         )
          ],),
           Column(children: <Widget>[
            Flexible(
                  child: Container(
             width: 100,
             child: TextFormField(
  decoration: const InputDecoration(
    
  )),
        
           ),
         )
          ],)
         ],),
      )
    );
  }
}