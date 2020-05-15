import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class UserManagement {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  storeNewUser(user, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
  Future<String>updateDisplayName(name) async {
FirebaseUser user2 = await _firebaseAuth.currentUser();
var userinfo = new UserUpdateInfo();
userinfo.displayName=name;
user2.updateProfile(userinfo).then((value) {
      FirebaseAuth.instance.currentUser().then((value) {
        Firestore.instance
            .collection('/users')
            .where('uid', isEqualTo: user2.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/users/${docs.documents[0].documentID}')
              .updateData({'displayName': name}).then((val) {
            print('updated');
            print(name);
          }).catchError((onError) {
            print(onError);
          });
        });
      }).catchError((onError) {
        print(onError);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<String>updateProfilePic(picUrl) async {
    
    FirebaseUser user2 = await _firebaseAuth.currentUser();
    var userinfo = new UserUpdateInfo();
    userinfo.photoUrl = picUrl;
    user2.updateProfile(userinfo).then((value) {
      FirebaseAuth.instance.currentUser().then((value) {
        Firestore.instance
            .collection('/users')
            .where('uid', isEqualTo: user2.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/users/${docs.documents[0].documentID}')
              .updateData({'photoUrl': picUrl}).then((val) {
            print('updated');
            print(picUrl);
          }).catchError((onError) {
            print(onError);
          });
        });
      }).catchError((onError) {
        print(onError);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
