import 'dart:math';

import 'package:flutter/material.dart';

class Cross extends StatefulWidget {

  @override
  State<Cross> createState() => _CrossState();

}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final Widget shaft = Container(
      width: 96.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
    return Container(
      color: Colors.red,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: pi / 4,
            child: shaft,
          ),
          Transform.rotate(
            angle: -pi / 4,
            child: shaft,
          ),
        ],
      ),
    );
  }

}
