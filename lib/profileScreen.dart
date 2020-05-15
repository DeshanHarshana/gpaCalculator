import 'dart:io';
import 'dart:math';

import 'services/usermanagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'crud.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profileurl =
      "https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg";

  initState() {
    super.initState();
    _getData();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        profileurl = user.photoUrl;
        nick = user.displayName;
        print(profileurl.toString());
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  String nick = "";
  String name="";
  String email="";
  UserManagement userManagement = new UserManagement();
  CRUDMethod crudObj = new CRUDMethod();
  String cars;
  File sampleImage;
  Future addImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        addImage();
                      },
                      child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(profileurl),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ])),
                    ),
                    SizedBox(height: 90.0),
                    Text(
                      nick,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      email,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 75.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            height: 30.0,
                            width: 100.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () {
                                      _showDialog();
                                    },
                                    child: Text(
                                      'Edit Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            height: 30.0,
                            width: 100.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.blue,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/upload');
                                    },
                                    child: Text(
                                      'Edit photo',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 25.0),
                        Container(
                            height: 30.0,
                            width: 95.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.redAccent,
                              color: Colors.red,
                              elevation: 7.0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                '/landingpage');
                                      }).catchError((e) {
                                        print(e);
                                      });
                                    },
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }

  _getData() async {
    {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      Firestore.instance
          .collection("users")
          .where('uid', isEqualTo: firebaseUser.uid)
          .getDocuments()
          .then((querySnapshot) {
        var data = querySnapshot.documents[0];
        print(data['email']);
        setState(() {
          email = data['email'];
        });
      });
    }
  }

  _showDialog() async {
    String name = '';
    TextEditingController textEditingController = new TextEditingController();
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(5.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                    nick = value;
                  });
                },
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Change'),
              onPressed: () async {
                await userManagement.updateDisplayName(name);
                Navigator.of(context).pushReplacementNamed('/homepage');
              })
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
