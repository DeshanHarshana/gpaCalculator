

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
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Column(children: <Widget>[
                 Text('Your Email : ',style: TextStyle(fontSize: 20.0),),
               Text('Your GPA',style: TextStyle(fontSize: 20.0),),
               Text('Number Of Credit',style: TextStyle(fontSize: 20.0),)
               ],)
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                  Text("Course Code",style: TextStyle(fontSize: 16),),
                     Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                    
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Grade",style: TextStyle(fontSize: 16),),
                   Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                    
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Credit",style: TextStyle(fontSize: 16),),
                   Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                       Container(
                        width: 100,
                        child:
                            TextFormField(decoration: const InputDecoration()),
                      ),
                    
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
