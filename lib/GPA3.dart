import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginregistroy/services/usermanagement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GPA3 extends StatefulWidget {
  @override
  _GPA3State createState() => _GPA3State();
}

class _GPA3State extends State<GPA3> {
  var color1 = Colors.black;
  var color2 = Colors.black;
  var color3 = Colors.black;
  var color4 = Colors.black;
  var color5 = Colors.black;
  var color6 = Colors.black;
  UserManagement management = new UserManagement();
  String semester = 'sem3';
  String semname='SEMESTER 3';
  String gpa = '';
  String totCredit = '';
  String email = '';
  String dropdownValue = 'Select';
  String sub1 = 'Select';
  String sub2 = 'Select';
  String sub3 = 'Select';
  String sub4 = 'Select';
  String sub5 = 'Select';
  String sub6 = 'Select';

  String code1 = '';
  String code2 = '';
  String code3 = '';
  String code4 = '';
  String code5 = '';
  String code6 = '';
  Map<String, String> createDoc = new HashMap();

  void mapAdd() {
    createDoc['1'] = code1 + ':' + sub1;
    createDoc['2'] = code2 + ':' + sub2;
    createDoc['3'] = code3 + ':' + sub3;
    createDoc['4'] = code4 + ':' + sub4;
    createDoc['5'] = code5 + ':' + sub5;
    createDoc['6'] = code6 + ':' + sub6;
    createDoc['gpa'] = gpa;
    createDoc['totcrd'] = totCredit;
  }

  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
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
      var query = databaseReference
          .collection('users')
          .document(docID)
          .collection('GPA')
          .document(semester)
          .get()
          .then((DocumentSnapshot ds) async {
        await setState(() {
          String dt = ds['1'];
          var a = dt.split(':');
          code1 = a[0];
          sub1 = a[1];

          String dt2 = ds['2'];
          var b = dt2.split(':');
          code2 = b[0];
          sub2 = b[1];

          String dt3 = ds['3'];
          var c = dt3.split(':');
          code3 = c[0];
          sub3 = c[1];

          String dt4 = ds['4'];
          var d = dt4.split(':');
          code4 = d[0];
          sub4 = d[1];

          String dt5 = ds['5'];
          var e = dt5.split(':');
          code5 = e[0];
          sub5 = e[1];

          String dt6 = ds['6'];
          var f = dt6.split(':');
          code6 = f[0];
          sub6 = f[1];

          String gp = ds['gpa'];
          gpa = gp;

          String tot = ds['totcrd'];
          totCredit = tot;

          email = eml;
        });
      });
    });
  }

  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  /// check if the string contains only numbers
  bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }
  bool checkCourse=false;
  bool checkCourselength=false;
  int getCredit(String code) {
    if (code.isEmpty) {
      
            
        return 0;
        
    } else {
      if(code.length!=8){
        
        checkCourselength=true;
        return 0;
        
      }else{
        if (isNumeric(code.substring(code.length - 1, code.length))) {
        int c = int.parse(code.substring(code.length - 1, code.length));
        return c;
      } else {
        checkCourse=true;
       
            
        return 0;
      }
      }
     
    }
   
  }
 
  double getPoint(grade) {
    double point = 0;
    if (grade == "A+") {
      point = 4.00;
    } else if (grade == "A") {
      point = 4.00;
    } else if (grade == "A-") {
      point = 3.70;
    } else if (grade == "B+") {
      point = 3.30;
    } else if (grade == "B") {
      point = 3.00;
    } else if (grade == "B-") {
      point = 2.70;
    } else if (grade == "C+") {
      point = 2.30;
    } else if (grade == "C") {
      point = 2.00;
    } else if (grade == "C-") {
      point = 1.70;
    } else if (grade == "D+") {
      point = 1.30;
    } else if (grade == "D") {
      point = 1.00;
    } else if (grade == "E") {
      point = 0.00;
    } else {
      point = 0.00;
    }

    return point;
  }

  void Calculate() {
    
    
    double gpa1 = 0.0;
    double sumMarks = 0;

    sumMarks = sumMarks + (getPoint(sub1) * getCredit(code1));
    sumMarks = sumMarks + (getPoint(sub2) * getCredit(code2));
    sumMarks = sumMarks + (getPoint(sub3) * getCredit(code3));
    sumMarks = sumMarks + (getPoint(sub4) * getCredit(code4));
    sumMarks = sumMarks + (getPoint(sub5) * getCredit(code5));
    sumMarks = sumMarks + (getPoint(sub6) * getCredit(code6));
    String totcrd = (getCredit(code1) +
            getCredit(code2) +
            getCredit(code3) +
            getCredit(code4) +
            getCredit(code5) +
            getCredit(code6))
        .toString();
    gpa1 = (sumMarks /(getCredit(code1) +getCredit(code2) +getCredit(code3) +getCredit(code4) +getCredit(code5) +getCredit(code6)));
    String gpa2=gpa1.toStringAsFixed(2);
    if(checkCourse){
           Fluttertoast.showToast(
            msg: "Check Your Course Codes final letter",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
            
    }
    else if(checkCourselength){
      Fluttertoast.showToast(
            msg: "Check Your Course Codes length",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
            
    }
    else{
    mapAdd();
    setState(() {
      gpa = gpa2;
      totCredit = totcrd;
    });
    mapAdd();
    management.updateSubject(createDoc, semester);

    
    }
    checkCourse=false;
    checkCourselength=false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop:() async => false,
           child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: true,
        body: Container(
           decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/logo6.jpg"), fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            semname,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            'Your GPA : $gpa',
                            style:TextStyle(fontFamily: 'FredokaOne',fontSize: 30),

                          ),
                          Text(
                            'Credit : $totCredit',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(color: Colors.black,
                  thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(

                        
                        children: <Widget>[
                          Text(
                            "Course",
                            style: TextStyle(fontSize: 25, fontFamily: 'Monda', fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Grade",
                            style: TextStyle(fontSize: 25, fontFamily: 'Monda', fontWeight: FontWeight.bold)
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code1,
                                        selection: new TextSelection.collapsed(
                                            offset: code1.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code1 = value.toUpperCase();
                                    if (code1.length == 8) {
                                      color1 = Colors.blue;
                                    } else {
                                      color1 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color1, fontFamily: 'FredokaOne',),
                                decoration: const InputDecoration(
                                    
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code2,
                                        selection: new TextSelection.collapsed(
                                            offset: code2.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code2 = value.toUpperCase();
                                    if (code2.length == 8) {
                                      color2 = Colors.blue;
                                    } else {
                                      color2 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color2,fontFamily: 'FredokaOne'),
                                decoration: const InputDecoration(
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code3,
                                        selection: new TextSelection.collapsed(
                                            offset: code3.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code3 = value.toUpperCase();
                                    if (code3.length == 8) {
                                      color3 = Colors.blue;
                                    } else {
                                      color3 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color3,fontFamily: 'FredokaOne'),
                                decoration: const InputDecoration(
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code4,
                                        selection: new TextSelection.collapsed(
                                            offset: code4.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code4 = value.toUpperCase();
                                    if (code4.length == 8) {
                                      color4 = Colors.blue;
                                    } else {
                                      color4 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color4,fontFamily: 'FredokaOne'),
                                decoration: const InputDecoration(
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code5,
                                        selection: new TextSelection.collapsed(
                                            offset: code5.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code5 = value.toUpperCase();
                                    if (code5.length == 8) {
                                      color5 = Colors.blue;
                                    } else {
                                      color5 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color5,fontFamily: 'FredokaOne'),
                                decoration: const InputDecoration(
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 160,
                            child: TextFormField(
                                controller: new TextEditingController.fromValue(
                                    new TextEditingValue(
                                        text: code6,
                                        selection: new TextSelection.collapsed(
                                            offset: code6.length))),
                                onChanged: (value) {
                                  setState(() {
                                    code6 = value.toUpperCase();
                                    if (code6.length == 8) {
                                      color6 = Colors.blue;
                                    } else {
                                      color6 = Colors.red;
                                    }
                                  });
                                },
                                style: TextStyle(fontSize: 25, color: color6,fontFamily: 'FredokaOne'),
                                decoration: const InputDecoration(
                                    hintText: "Course",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 0))),
                          ),
                        ],
                      ),
                      Container(
                        width: 120,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub1,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub1 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub2,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub2 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub3,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub3 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub4,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub4 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub5,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub5 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 120,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: sub6,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.deepPurple,fontFamily: 'FredokaOne'),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      sub6 = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'A+',
                                    'A',
                                    'A-',
                                    'B+',
                                    'B',
                                    'B-',
                                    'C+',
                                    'C',
                                    'C-',
                                    'D+',
                                    'D',
                                    'E-'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     
                      Column(
                        children: <Widget>[
                          Container(
                              width: 100,
                              child: FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text('Calculate', style: TextStyle(fontFamily: 'Monda', fontSize: 15),),
                                onPressed: () {
                                  Calculate();
                                },
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              width: 100,
                              child: FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text('Reset', style: TextStyle(fontFamily: 'Monda', fontSize: 15),),
                                onPressed: () {
                                  setState(() {
                                    code1='';
                                    code2='';
                                    code3='';
                                    code4='';
                                    code5='';
                                    code6='';
                                    sub1='Select';
                                    sub2='Select';
                                    sub3='Select';
                                    sub4='Select';
                                    sub5='Select';
                                    sub6='Select';
                                    gpa='0';
                                    totCredit='0';

                                  });
                                },
                              )),
                              
                        ],
                      ),
                      SizedBox(
                        width: 7,
                      ),
                       Column(
                        children: <Widget>[
                          Container(
                              width: 100,
                              child: FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text('Back', style: TextStyle(fontFamily: 'Monda', fontSize: 15),),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/back');
                                },
                              )),
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
          ),
        ),
      )),
          
    );
  }

 









}
