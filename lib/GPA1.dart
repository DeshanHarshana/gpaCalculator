import 'package:flutter/material.dart';

class GPA1 extends StatefulWidget {
  @override
  _GPA1State createState() => _GPA1State();
}

class _GPA1State extends State<GPA1> {

  String gpa='';
  String dropdownValue = 'Select';
  String sub1='Select';
  String sub2='Select';
  String sub3='Select';
  String sub4='Select';
  String sub5='Select';
  String sub6='Select';

  String code1='';
  String code2='';
  String code3='';
  String code4='';
  String code5='';
  String code6='';
  
  int getCredit(code){
    int c=int.parse(code.substring(code.length-1,code.length));
    return c;
  }
  double getPoint(grade){
    double point=0;
    if(grade=="A+"){
      point=4.00;
    }
    else if(grade=="A"){
      point=4.00;
    }
    else if(grade=="A-"){
      point=3.70;
    }
    else if(grade=="B+"){
      point=3.30;
    }
    else if(grade=="B"){
      point=3.00;
    }
    else if(grade=="B-"){
      point=2.70;
    }
    else if(grade=="C+"){
      point=2.30;
    }
    else if(grade=="C"){
      point=2.00;
    }
    else if(grade=="C-"){
      point=1.70;
    }
    else if(grade=="D+"){
      point=1.30;
    }
    else if(grade=="D"){
      point=1.00;
    }
    else if(grade=="E"){
      point=0.00;
    }

    return point;
  }
  void Calculate(){
    double gpa1=0.0;
    double sumMarks=0;
    
      sumMarks=sumMarks+(getPoint(sub1)*getCredit(code1));
      sumMarks=sumMarks+(getPoint(sub2)*getCredit(code2));
      sumMarks=sumMarks+(getPoint(sub3)*getCredit(code3));
      sumMarks=sumMarks+(getPoint(sub4)*getCredit(code4));
      sumMarks=sumMarks+(getPoint(sub5)*getCredit(code5));
      sumMarks=sumMarks+(getPoint(sub6)*getCredit(code6));

      gpa1=sumMarks/(getCredit(code1)+getCredit(code2)+getCredit(code3)+getCredit(code4)+getCredit(code5)+getCredit(code6));
    
    setState(() {
      gpa=gpa1.toString();
    });

   

  }
  
 
  @override
  Widget build(BuildContext context) {
     
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Your Email : ',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    Text(
                      'Your GPA : $gpa',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    Text(
                      'Number Of Credit',
                      style: TextStyle(fontSize: 10.0),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Course Code",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code1=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          maxLines: 1,
                          decoration: const InputDecoration()),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code2=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          decoration: const InputDecoration()),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code3=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          decoration: const InputDecoration()),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code4=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          decoration: const InputDecoration()),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code5=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          decoration: const InputDecoration()),
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            code6=value;
                          });
                        },
                          style: TextStyle(fontSize: 30),
                          decoration: const InputDecoration()),
                    ),
                    Container(
                        width: 150,
                        child: FlatButton(
                          child: Text('Calculate'),
                          onPressed: () {
                           Calculate();
                          },
                        )),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                    ),
                    Text(
                      "Grade",
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: sub1,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub1 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:  sub2,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub2 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:  sub3,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub3 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:  sub4,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub4 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:  sub5,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub5 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value:  sub6,
                          style:
                              TextStyle(fontSize: 10, color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              sub6 = newValue;
                            });
                          },
                          items: <String>['Select', 'A+', 'A', 'A-','B+', 'B', 'B-','C+', 'C', 'C-','D+', 'D', 'E-']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    Container(
                        width: 80,
                        child: FlatButton(
                          child: Text('Reset'),
                          onPressed: () {},
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  
}
