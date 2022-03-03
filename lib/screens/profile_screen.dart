import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';

import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
 final String uid;

    ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   var userData = {}; 
   int postLength = 0;
   int followers = 0;
   int following = 0;
   bool isFollowing = false;
     bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                              buildStateColumn(postLength, "Posts"),
                              buildStateColumn(followers, "Followers"),
                              buildStateColumn(following, "Following"),
                            ],
                          ),
                           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       FirebaseAuth.instance.currentUser!.uid == widget.uid ?  FollowButon(
                          function: (){},
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          text: 'Edit Profile',
                          backgroundColor: Colors.black,
                        ): isFollowing ? FollowButon(
                          function: ()async{
                            await FirestoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                            setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                          },
                          borderColor: Colors.grey,
                          textColor: Colors.white,
                          text: 'Unfollow',
                          backgroundColor: Colors.black,
                        ): FollowButon(

                          
                          function: () async{
                            await FirestoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                            setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                            
                          },
                          borderColor: Colors.grey,
                          textColor: Colors.white,
                          text: 'Follow',
                          backgroundColor: Colors.blue,
                          
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
          Divider(),
           FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
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
     setState(() {
      isLoading = true;
    });
    try{
    var snap =  await FirebaseFirestore.instance.collection("users").doc(widget.uid).get();
    //Get Post Lenght
        var snapPost =  await FirebaseFirestore.instance.collection("posts").where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

        postLength = snapPost.docs.length;

    userData = snap.data()!;
    followers = snap.data()!['followers'].length;
    following =snap.data()!['following'].length;
    isFollowing = snap.data()!['followers'].length.contain(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      
    });
    }catch(e){
      showSnakBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }
}
