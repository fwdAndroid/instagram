import 'package:flutter/material.dart';
import 'package:instagram/screens/login_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({ Key? key }) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}