import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/resources/auth_merhods.dart';

class UserProvider with ChangeNotifier{
   late UserModel _users;
     AuthMethods _auth = AuthMethods();
    //Getting User Data
    UserModel get getUser => _users;

    //Refresh User
    Future<void> refreshUser() async{
      UserModel userModel = await _auth.getUserDetails();
      _users = userModel;
      notifyListeners();
    } 
}