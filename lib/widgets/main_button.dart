import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final Function onPressed;
  final String text;

  MainButton({ this.onPressed, this.text });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 48.0),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
        color: theme.primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          text,
          style: theme.textTheme.title,
        ),
      ),
    );
  }

}
