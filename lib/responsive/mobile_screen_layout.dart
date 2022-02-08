import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({ Key? key }) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
 
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(userModel.email)),
    );
  }

  
}