import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 Future <String> signUpUser({
    required String email,
    required String pass,
    required String bio,
    required String username,
//    required Uint8List file
  }) async{
     String res = 'Some error occured';
     try{
        if (email.isNotEmpty || pass.isNotEmpty || bio.isNotEmpty || username.isNotEmpty  ) {
        UserCredential cred =  await _auth.createUserWithEmailAndPassword(email: email, password: pass);
          //Add User to the database
          await firebaseFirestore.collection('users').doc(cred.user!.uid).set({
            'username':username,
             'uid':cred.user!.uid,
             'email':email,
             'bio':bio,
             'followers':[],
             'following':[],
          });
          res = 'sucess';
        }
     }catch(e){
       res = e.toString();
     }
     return res;
  }
}