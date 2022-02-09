import 'dart:developer';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/phone/phoneauth.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
     await Firebase.initializeApp(
    options: const  FirebaseOptions(apiKey: 'AIzaSyDbWfaveZUSCsE1EhWZycoQ_udjpdwspiU', 
    appId: '1:181934639510:web:7e744309d172d2f195f5b7',
     messagingSenderId: '181934639510',
      projectId: 'instagramclone-d0003',
      storageBucket: 'instagramclone-d0003.appspot.com')
  );
  }else{
    await Firebase.initializeApp();
  }
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return  ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout());

              }else if(snapshot.hasError){
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
              if(snapshot.connectionState == ConnectionState.waiting){
                 return Center(
                   child: CircularProgressIndicator(),
                 );
              }
              return const LoginScreen();
          },
        )       

        //PhoneAuth()


      ),
    );
  }
}

