import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/post_card.dart';

class Feed_Screen extends StatefulWidget {
  const Feed_Screen({ Key? key }) : super(key: key);

  @override
  _Feed_ScreenState createState() => _Feed_ScreenState();
}

class _Feed_ScreenState extends State<Feed_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:mobileBackgroundColor,
        centerTitle:false,
        title: SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor,height:32,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.message_outlined))
        ],
      ),
      body: PostCard(),
    );
  }
}