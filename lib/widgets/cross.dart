import 'dart:math';

import 'package:flutter/material.dart';

class Cross extends StatefulWidget {

  @override
  State<Cross> createState() => _CrossState();

}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> opAnim;
  Animation<double> rotAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    opAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ))
      ..addListener(() {
        setState(() {  });
      });
    rotAnim = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.easeInOut),
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
    final Widget shaft = Container(
      width: 96.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha((opAnim.value * 255).floor()),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
    return Container(
      color: Colors.red,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: rotAnim.value * (pi / 4),
            child: shaft,
          ),
          Transform.rotate(
            angle: rotAnim.value * (-pi / 4),
            child: shaft,
          ),
        ],
      ),
    );
  }

}
