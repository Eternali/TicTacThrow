import 'dart:async';

import 'package:flutter/material.dart';

class TTTLocalizations {

  static TTTLocalizations of(BuildContext context) {
    return Localizations.of<TTTLocalizations>(context, TTTLocalizations);
  }

  String get appTitle => 'Tic Tac Throw';
  String get loginBtn => 'Login with';
  String get reset => 'RESET';
  String get start => 'START';
  String get settings => 'Settings';
  String get changeSensitivity => 'Adjust Sensitivity';

}

class TTTLocalizationsDelegate extends LocalizationsDelegate<TTTLocalizations> {

  @override
  Future<TTTLocalizations> load(Locale locale) {
    return Future(() => TTTLocalizations());
  }

  @override
  bool shouldReload(TTTLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains('en');

}
