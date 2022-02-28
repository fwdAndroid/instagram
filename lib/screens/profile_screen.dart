import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
 final String uid;
  const  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   var userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['username']),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData['photoURL']),
                      radius: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStateColumn(12, "Posts"),
                              buildStateColumn(120, "Followers"),
                              buildStateColumn(102, "Following"),
                            ],
                          ),
                           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FollowButon(
                          function: (){},
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          text: 'Edit Profile',
                          backgroundColor: Colors.black,
                        )
                      ],
                    )
                        ],
                      ),
                      
                    ),
                   
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15),
                  child: Text(userData['username'],style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5),
                  child: Text(userData['bio'],style: TextStyle(fontWeight: FontWeight.w300),),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
      
    );
  }
  Column buildStateColumn(int num,String label){
    return Column(
      children: [
           Text(
             num.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
           ),
           Container(
             padding: EdgeInsets.only(top: 6,left: 6,right: 6),
             child: Text(
               label,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
             ),
           ),
        ],
    );
  }

  void getData() async{
    try{
    var snap =  await FirebaseFirestore.instance.collection("users").doc(widget.uid).get();
    userData = snap.data()!;
    setState(() {
      
    });
    }catch(e){
      showSnakBar(e.toString(), context);
    }
  }
}
