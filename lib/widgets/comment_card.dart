import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(''),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: '    some Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '23/12/2022',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.favorite,
                size: 16,
              ),),
        ],
      ),
    );
  }
}
