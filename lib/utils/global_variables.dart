import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenSize = [
  Feed_Screen(),
  SearchScreen(),
  AddPostScreen(),
  Text('Noti'),
  Text("Profile")
];
