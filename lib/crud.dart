import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDMethod{
  bool isLoggin(){
    if(FirebaseAuth.instance.currentUser()!=null){
      return true;
    }else{
      return false;
    }
  }
  Future<void> addData(carData) async{
    if(isLoggin()){
    //Firestore.instance.collection('testcrud').add(carData).catchError((e){
     // print(e);
    //});
    Firestore.instance.runTransaction((Transaction crudTransaction) async{
      CollectionReference reference=await Firestore.instance.collection('testcrud');
      reference.add(carData);
    });
    }
    else{
      print('You need to be loggin');
    }
  }
  getData () async{
    return await Firestore.instance.collection('testcrud').snapshots();

  }
  updateData(selectedDoc, newValue){
    
    Firestore.instance.collection('users').document(selectedDoc).updateData(newValue).catchError((e){
      print(e);
    });
  }
  deleteData(docId){
    Firestore.instance.collection('testcrud').document(docId).delete().catchError((e){
      print(e);
    });
  }
}