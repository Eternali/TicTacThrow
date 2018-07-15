import 'package:flutter/material.dart';

class Circle extends StatefulWidget {

  @override
  State<Circle> createState() => _CircleState();

}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> innerAnim;
  Animation<double> outerAnim;
  
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    innerAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: Curves.bounceOut),
      ))
      ..addListener(() {
        setState(() {  });
      });
    outerAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.bounceOut),
      ))
      ..addListener(() {
        setState(() {  });
      });
      
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: outerAnim.value * 80,
            height: outerAnim.value * 80,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          Container(
            width: innerAnim.value * 54,
            height: innerAnim.value * 54,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(27.0),
            ),
          ),
        ],
      ),
    );
  }

}
