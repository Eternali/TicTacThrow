import 'package:flutter/material.dart';

import 'package:tictacthrow/localizations.dart';
import 'package:tictacthrow/routes.dart';
import 'package:tictacthrow/data/models.dart';
import 'package:tictacthrow/data/provider.dart';
import 'package:tictacthrow/data/reducers.dart';
import 'package:tictacthrow/screens/home.dart';
import 'package:tictacthrow/screens/login.dart';

void main() {
  runApp(TicTacThrow());
}

class TicTacThrow extends StatefulWidget {

  AppStateObservable state;

  TicTacThrow() {
    state = AppStateObservable(Reducers.loading());
  }

  @override
  State<TicTacThrow> createState() => _TicTacThrowState();

}

class _TicTacThrowState extends State<TicTacThrow> {

  @override
  Widget build(BuildContext context) {
    return Provider(
      state: widget.state,
      child: MaterialApp(
        title: 'TicTacThrow',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.purple,
          accentColor: Colors.pink,
        ),
        localizationsDelegates: [
          TTTLocalizationsDelegate()
        ],
        routes: {
          Routes.home: (context) => Home(),
          Routes.login: (context) => Login(),
        },
      ),
    );
  }

}
