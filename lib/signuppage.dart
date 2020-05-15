import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

//services
import 'services/usermanagement.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_strength/password_strength.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  String _nickName;
  String errormsg="";
 ProgressDialog pr;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
      pr = new ProgressDialog(context);
    pr.style(
  message: 'Loading....',
  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'NickName'),
                  onChanged: (value) {
                    setState(() {
                      _nickName = value;
                    });
                  }),
              TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  }),
              SizedBox(height: 15.0),
              TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  }),
              SizedBox(height: 20.0),
              
              RaisedButton(
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: () {
                  
                  if(_email.isEmpty && _password.isEmpty && _nickName.isEmpty){
                    setState(() {
                      errormsg="Fill details";
                    });
                  }
                  else{
                    double strength=estimatePasswordStrength(_password);
                  if (EmailValidator.validate(_email)) {
                    if (strength < 0.3) {
                      setState(() {
                        errormsg='This password is weak!';
                      });
                
                    } else {
                 signUp2(_email,_password);
                    }
                  }
                  else{
                    setState(() {
                      errormsg="Enter Valid Email";
                    });
                  }
                  }
                
                 
                },
              ),
              Container(child: Text(errormsg,style: TextStyle(color: Colors.red),))
            ],
          )),
    ));
  }
  Future<String>  signUp2(String email, String password) async {
    try{
      pr.show();
          AuthResult user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)) ;
                  
                  
          FirebaseUser user2 = await _firebaseAuth.currentUser();
         
          UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
          
          userUpdateInfo.displayName = _nickName;
          
          userUpdateInfo.photoUrl = 'https://cdn4.iconfinder.com/data/icons/e-commerce-181/512/477_profile__avatar__man_-512.png';
        pr.hide();
        pr.show();
           user2.updateProfile(userUpdateInfo).then((onValue) {
                      FirebaseAuth.instance.currentUser().then((user) =>
                          {UserManagement().storeNewUser(user, context)});
       
           });
           pr.hide();
           }catch (error) {
    setState(() {
      errormsg=error.toString();
    });
  }
        
  
  }

  
  
}

