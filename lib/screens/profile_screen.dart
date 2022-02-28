import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('usernaem'),
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
                      backgroundColor: Colors.red,
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
                  child: Text('username',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5),
                  child: Text('description',style: TextStyle(fontWeight: FontWeight.w300),),
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
}
