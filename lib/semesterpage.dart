import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SemesterPage extends StatefulWidget {
  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage> {

String gpa="";
int credit=0;
String name="";
double gpaxcredit=0.0;




void initState() {
    super.initState();
    _getData();


     FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        
        name = user.displayName;
        
      });
    }).catchError((onError) {
      print(onError);
    });
  }








_getData() async {
  var sems = ['sem1','sem2','sem3','sem4','sem5', 'sem6', 'sem7', 'sem8']; 
    var docID = 'sfsdf';
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    String eml = firebaseUser.email;
    final databaseReference = Firestore.instance;
    databaseReference
        .collection("users")
        .where('uid', isEqualTo: firebaseUser.uid)
        .getDocuments()
        .then((docs) {
      docID = docID = docs.documents[0].reference.documentID;
    }).then((value) {
      print(docID);
      for(var i=0; i<8; i++){
        var query = databaseReference
          .collection('users')
          .document(docID)
          .collection('GPA')
          .document(sems[i])
          .get()
          .then((DocumentSnapshot ds) async {
        await setState(() {
          
          gpaxcredit=gpaxcredit+(double.parse(ds['gpa'])*int.parse(ds['totcrd']));
          credit=credit+(int.parse(ds['totcrd']));
          
          gpa=(gpaxcredit/credit).toStringAsFixed(2);
        });
      });
      }  
      
      
    });
    setState(() {
       
      
    });
  }






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async => false,
           child: SafeArea(
          child: Scaffold(
           
backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/logo2.jpg"), fit: BoxFit.cover)),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Column(children: <Widget>[
                    Text(
                            'Hi $name',
                            style: TextStyle(fontSize: 20.0,fontFamily: 'Pangolin'),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Total GPA : $gpa',
                            style:TextStyle(fontFamily: 'FredokaOne',fontSize: 30),

                          ),
                           SizedBox(height: 10,),
                          Text(
                            'Total Credit : $credit',
                            style: TextStyle(fontSize: 25.0),
                          )
                  ],)
                ],),
                Divider(color: Colors.black,thickness: 2,),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: <Widget>[
                     _buildLoginBtn('SEMESTER 1', '/GPA1'),
                      SizedBox(height: 35,),
                      _buildLoginBtn('SEMESTER 3', '/GPA3'),
                      SizedBox(height: 35,),
                      _buildLoginBtn('SEMESTER 5', '/GPA5'),
                      SizedBox(height:35,),
                     _buildLoginBtn('SEMESTER 7', '/GPA7'),
                    ],),
                    Column(children: <Widget>[
                     _buildLoginBtn('SEMESTER 2', '/GPA2'),
                     SizedBox(height: 35,),
                      _buildLoginBtn('SEMESTER 4', '/GPA4'),
                      SizedBox(height: 35,),
                      _buildLoginBtn('SEMESTER 6', '/GPA6'),
                      SizedBox(height: 35,),
                      _buildLoginBtn('SEMESTER 8', '/GPA8')
                      
                    ],)
                ],),

                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
      
      width: 120,
      child: RaisedButton(
        elevation: 5.0,
         onPressed: () {
                 Navigator.of(context).pushNamed('/login');
                  },
        padding: EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.red,
        child: Text(
          "LOGOUT",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    )
  
                ],)
              ],),
            ),
        
      ),
    ));
  }

  Widget _buildLoginBtn(String name, String root) {
    return Container(
      
      width: 120,
      child: RaisedButton(
        elevation: 5.0,
         onPressed: () {
                 Navigator.of(context).pushNamed(root);
                  },
        padding: EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          name,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }



  Widget semButton(String name, String root,){
return FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text(name, style: TextStyle(fontFamily: 'Monda', fontSize: 15),),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, root);
                                },
                              );
  }
}