import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class UserManagement {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  storeNewUser(user, context) {
    String uid=user.uid;
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'totgpa':"0",
      'totcrd':'0',
      
    }).then((value){
      Firestore.instance.collection('/users').
      where('uid', isEqualTo: uid).getDocuments()
      .then((docs){
        final databaseReference = Firestore.instance;
        for(var i=1; i<=8; i++){
        databaseReference
        .document('/users/${docs.documents[0].documentID}').
        collection('GPA').document('sem$i').setData({
          '1':':Select',
          '2':':Select',
          '3':':Select',
           '4':':Select',
            '5':':Select',
             '6':':Select',
             'gpa':'0',
             'totcrd':'0'
        }
        );
        }


       
        

      });
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/back');
    }).catchError((e) {
      print(e);
    });
  }

Future<String>updateSubject(name,String semid) async {
FirebaseUser user2 = await _firebaseAuth.currentUser();



      FirebaseAuth.instance.currentUser().then((value) {
        Firestore.instance
            .collection('/users')
            .where('uid', isEqualTo: user2.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('/users/${docs.documents[0].documentID}').collection('GPA')
              .document(semid)
              .updateData(name).then((val) {
            print('updated');
            print(name);
          }).catchError((onError) {
            print(onError);
          });
        });
      }).catchError((onError) {
        print(onError);
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
