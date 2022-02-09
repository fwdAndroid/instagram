import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
   late PageController pageController;


  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _pages = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   widget.pageController = PageController();
  }
 @override
 void dispose(){
   super.dispose();
   widget.pageController.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          CupertinoTabBar(backgroundColor: mobileBackgroundColor, 
          onTap: navigateTapped,
          
          items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _pages == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _pages == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _pages == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _pages == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _pages == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor),
      ]),
      body: PageView(
        children:homeScreenSize,
        controller: widget.pageController,
        onPageChanged: onPageChanged,
      )
    );
  }

  void navigateTapped(int value) {
    widget.pageController.jumpToPage(value);

  }

  void onPageChanged(int value) {
    setState(() {
      _pages = value;
   });
  }
}
