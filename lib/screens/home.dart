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
import 'package:tictacthrow/widgets/main_button.dart';

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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> completeAnim;

  List<double> lastAcc = [0.0, 9.81, 0.0];
  List<double> accDelta = [0.0, 0.0, 0.0];
  StreamSubscription<dynamic> _subscription;

  void startListening(BuildContext context) {
    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      accDelta = [event.x - lastAcc[0], event.y - lastAcc[1], event.z - lastAcc[2]];
      lastAcc = [event.x, event.y, event.z];
      if (accDelta[0].abs() > Provider.of(context).value.sensitivity) {
        Intents.play(Provider.of(context), 1)
          .then((_) => Intents.checkStatus(Provider.of(context)));
      } else if (accDelta[1].abs() > Provider.of(context).value.sensitivity) {
        Intents.play(Provider.of(context), 2)
          .then((_) => Intents.checkStatus(Provider.of(context)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    completeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
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

    if (stateVal.status != 0 && _controller.status != AnimationStatus.completed) {
      _controller.forward().orCancel;
    } else if (_controller.status != AnimationStatus.dismissed) {
      _controller.reverse().orCancel;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locales.appTitle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, Routes.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              ScaleTransition(
                scale: completeAnim,
                child: stateVal.status == 0 ? null : Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 94.0),
                    padding: EdgeInsets.all(100.0),
                    child: Text(
                      stateVal.status == 1
                        ? '"O"s WIN!'
                        : '"X"s WIN!',
                      style: theme.textTheme.title,
                    ),
                    decoration: BoxDecoration(
                      color: theme.accentColor.withAlpha(140),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                  ),
                ),
              ),
            ].where((v) => v != null).toList(),
          ),
          MainButton(
            onPressed: () => Intents.restart(Provider.of(context)),
            text: board.where((square) => square != 0).length > 0 ? locales.reset : locales.start,
          ),
        ],
      ),
    );
  }

}