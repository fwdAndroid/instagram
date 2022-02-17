import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
   PostCard({ Key? key, required this.snap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage:
                     NetworkImage(
                       snap['profileImage']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snap['username'],
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
            // Image Selection
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    
                     snap['postUrl'],),
                )),
            //Like Comment Section
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
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
                        child: Text('${snap['likes'].length} likes',style: TextStyle(color:Colors.black,),),),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 9),
                      child: RichText(
                          text: TextSpan(
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                              text: snap['username'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              )),
                               TextSpan(
                              text:   snap['description'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                              )                            )
                        ],
                      )),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Text('View all Comments',style: TextStyle(
                        fontSize: 15,
                        color: secondaryColor
                      ),),
                    ),
                       Container(
                         padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text('22/21/21',style: TextStyle(
                        fontSize: 15,
                        color: secondaryColor
                      ),),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}