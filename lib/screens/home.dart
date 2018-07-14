import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'package:tictacthrow/intents.dart';
import 'package:tictacthrow/localizations.dart';
import 'package:tictacthrow/routes.dart';
import 'package:tictacthrow/data/models.dart';
import 'package:tictacthrow/data/provider.dart';
import 'package:tictacthrow/widgets/circle.dart';
import 'package:tictacthrow/widgets/cross.dart';

List<T> flatten<T>(List<List<T>> deep) {
  var flattened = [];
  deep.forEach((i) {
    i.forEach((j) => flattened.add(j));
  });

  return flattened.toList();
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  // List<double> _accVals;
  double threshold = 1.0;
  StreamSubscription<dynamic> _subscription;

  void startListening(BuildContext context) {
    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() > threshold || event.y.abs() > threshold || event.z.abs() > threshold) {
        // print(event.toString());
        Intents.play(Provider.of(context), 1)
          .then((_) => Intents.checkStatus(Provider.of(context)));
      }
      // _accVals = <double>[event.x, event.y, event.z];
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateVal = Provider.of(context).value;
    final locales = TTTLocalizations.of(context);
    final theme = Theme.of(context);
    final board = flatten(stateVal.board);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.all(6.0),
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  shrinkWrap: true,
                  children: board.asMap().map((s, square) => MapEntry<int, Widget>(s, GestureDetector(
                    onTap: () {
                      Intents.focus(
                        Provider.of(context),
                        (s / stateVal.board.length).floor(),
                        s % stateVal.board[0].length,
                      ).then((_) {
                        startListening(context);
                      });
                    },
                    child: square == 0
                      ? Container(
                        color: Colors.grey,
                      )
                      : square == 1
                        ? Circle()
                        : Cross(),
                  ))).values.toList(),
                ),
              ),
              stateVal.status == 0 ? null :
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40.0),
                  padding: EdgeInsets.all(100.0),
                  child: Text(
                    stateVal.status == 1
                      ? "Player 1 WINS!"
                      : "Player 2 WINS!",
                    style: theme.textTheme.title,
                  ),
                  decoration: BoxDecoration(
                    color: theme.accentColor.withAlpha(140),
                  ),
                ),
              ),
            ].where((v) => v != null).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 50.0),
            child: RaisedButton(
              onPressed: () => Intents.restart(Provider.of(context)),
              child: Text(
                'RESET'
              ),
            ),
          ),
        ],
      ),
    );
  }

}