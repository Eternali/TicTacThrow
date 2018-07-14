import 'dart:async';

import 'package:flutter/material.dart';

typedef Future Login();

class LoginButton extends StatefulWidget {

  final Login login;
  final IconData icon;
  final Image img;
  final String text;
  final Color color;

  LoginButton({
    this.login,
    this.icon,
    this.img,
    this.text,
    this.color,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();

}

class _LoginButtonState extends State<LoginButton> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: widget.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(widget.icon) ?? widget.img,
          Text(
            widget.text,
          ),
        ],
      ),
      onPressed: widget.login,
    );
  }

}