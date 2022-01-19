import 'package:flutter/material.dart';
import 'package:instagram/screens/login_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({ Key? key }) : super(key: key);

  @override
  _WebScreenLayoutState createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen()
    );
  }
}