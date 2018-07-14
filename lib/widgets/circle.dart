import 'package:flutter/material.dart';

class Circle extends StatefulWidget {

  @override
  State<Circle> createState() => _CircleState();

}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          Container(
            width: 54.0,
            height: 54.0,
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
