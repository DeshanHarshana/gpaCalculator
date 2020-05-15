import 'dart:io';
import 'dart:math';

import 'services/usermanagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'crud.dart';

class UploadData extends StatefulWidget {
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  File sampleImage;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserManagement userManagement=new UserManagement();
  Future addImage() async{
    var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage=tempImage;
    });
   
  }
  Future<void> upload() async {
    FirebaseUser user2 = await _firebaseAuth.currentUser();
    String x=user2.uid;
    var randomno=Random(25);
    final StorageReference ref=FirebaseStorage.instance.ref().child('profilepic/${randomno.nextInt(5000).toString()+x}.jpg');
    final StorageUploadTask task=ref.putFile(sampleImage);
     StorageTaskSnapshot snapshottask =  await task.onComplete;
    String downloadUrl = await snapshottask.ref.getDownloadURL();
     if (downloadUrl !=null){
     userManagement.updateProfilePic(downloadUrl.toString()).then((val){
       Navigator.of(context).pushReplacementNamed('/homepage');
     
    
  });
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add file'),
  
      ),
      body: new Center(
        
        child: sampleImage ==null?Text('select image'):enableUpload(),
        
        ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addImage,
      ),
  
      
      
    );
  }
  Widget enableUpload(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0,width: 300.0,),
          RaisedButton(
            elevation: 7.0,
            child:Text('upload'),
            onPressed: (){
              upload();
            },
          )
        ],
      ),
    );
  }
}
