import 'package:flutter/material.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/like_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLIkeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage(widget.snap['profileImage']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (cont) => Dialog(
                                child: ListView(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shrinkWrap: true,
                                  children: ['Delete']
                                      .map((e) => InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          )))
                                      .toList(),
                                ),
                              ));
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            // Image Selection And Like Animation
            GestureDetector(
              //Like Counter When double tap the image
              onDoubleTap: () async {
                await FirestoreMethods().likePosts(
                    widget.snap['postId'], userModel.uid, widget.snap['likes']);
                setState(() {
                  isLIkeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.network(
                          widget.snap['postUrl'],
                        ),
                      )),
                  AnimatedOpacity(
                    opacity: isLIkeAnimating ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: LikeAnimation(
                      child:
                          Icon(Icons.favorite, size: 100, color: Colors.white),
                      isAnimating: isLIkeAnimating,
                      duration: Duration(milliseconds: 400),
                      onEnd: () {
                        setState(() {
                          isLIkeAnimating = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Like Comment Section
            Row(
              children: [
                LikeAnimation(
                  isAnimating:  widget.snap['likes'].contains(userModel.uid),
                  
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePosts(widget.snap['postId'],
                          userModel.uid, widget.snap['likes']);
                    },
                    icon: widget.snap['likes'].contains(userModel.uid)?  Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ): Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.comment_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// Description
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontWeight: FontWeight.w800),
                      child: Text(
                        '${widget.snap['likes'].length} likes',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 9),
                      child: RichText(
                          text: TextSpan(
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                              text: widget.snap['username'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: ' ${widget.snap['description']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black))
                        ],
                      )),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'View all Comments',
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(fontSize: 15, color: secondaryColor),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
