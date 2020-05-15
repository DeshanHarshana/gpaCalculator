
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'groups.dart';
import 'chats.dart';
import 'dashboadr.dart';

import 'profileScreen.dart';

class HomePage2 extends StatefulWidget {
  

 
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with SingleTickerProviderStateMixin{
  TabController tabController;

  void initState(){
    super.initState();
    tabController=new TabController(length: 4, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.home),),
            new Tab(icon: Icon(Icons.home),),
            new Tab(icon: Icon(Icons.home),),
            new Tab(icon: Icon(Icons.home),),
           
          ],
        ),
      ),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          Chat(),
          Group(),
          Dash(),
          Profile(),
         
        ],
      ),
    );
    
    
     }
}