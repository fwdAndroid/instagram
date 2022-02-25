import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text('Comments'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: EdgeInsets.only(left: 16,right: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('url'),
                ),
                Expanded(child: Padding(padding: EdgeInsets.only(left: 16,right: 8),child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a Comment'),
                  
                  
                ),),),
                InkWell(onTap: (){},child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                  child: Text("Post"),
                ),)
              ],
            ),
      )),
    );
  }
}
