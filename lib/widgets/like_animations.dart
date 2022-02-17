import 'package:flutter/material.dart';

class LikeAnimations extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEmd;
  final bool smallLike;


  const LikeAnimations({ Key? key, required this.child,required this.isAnimating, this.duration = const Duration(milliseconds: 150),this.onEmd,this.smallLike = false });

  @override
  _LikeAnimationsState createState() => _LikeAnimationsState();
}

class _LikeAnimationsState extends State<LikeAnimations> with SingleTickerProviderStateMixin{
 late AnimationController animationController;
 late Animation<double> scale; 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds  ~/ 2));
    scale = Tween<double>(begin: 1,end: 1.2).animate(animationController);

  }
  @override
  void didUpdateWidget(covariant LikeAnimations oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating != oldWidget.isAnimating){
      startAnimation();
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }

//Animation Starting Function
  void startAnimation() async{
    if(widget.isAnimating || widget.smallLike){
      await animationController.forward();
      await animationController.reverse();
      await Future.delayed(const Duration(milliseconds: 200));

      if(widget.onEmd != null){
        widget.onEmd!();
      }
    }
  }
}