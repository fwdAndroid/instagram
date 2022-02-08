import 'package:flutter/material.dart';
import 'package:instagram/screens/login_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({ Key? key }) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }

  void getUserName() async{
    
  }
}