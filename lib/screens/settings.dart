import 'package:flutter/material.dart';

import 'package:tictacthrow/intents.dart';
import 'package:tictacthrow/localizations.dart';
import 'package:tictacthrow/data/provider.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();

}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final locales = TTTLocalizations.of(context);
    final theme = Theme.of(context);
    final stateVal = Provider.of(context).value;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locales.settings,
        ),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            Card(
              color: theme.primaryColorDark,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                      child: Text(
                        locales.changeSensitivity,
                        style: theme.textTheme.subhead,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: theme.accentColor,
                        inactiveColor: theme.primaryColor,
                        min: 0.1,
                        max: 100.0,
                        value: stateVal.sensitivity,
                        onChanged: (newSens) => Intents.changeSensitivity(Provider.of(context), newSens),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
