import 'package:flutter/material.dart';

class FollowButon extends StatefulWidget {
  final Function() ? function;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  const FollowButon({ Key? key, this.function,required this.backgroundColor,required this.borderColor,required this.text,required this.textColor }) : super(key: key);

  @override
  _FollowButonState createState() => _FollowButonState();
}

class _FollowButonState extends State<FollowButon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextButton(onPressed: widget.function, child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: widget.borderColor),
          borderRadius: BorderRadius.circular(5)
        ),
        height: 35,
        width: 220,
        alignment: Alignment.center,
        child: Text(widget.text,style: TextStyle(color: widget.textColor),),
      )),
    );
  }
}