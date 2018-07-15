import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import 'package:tictacthrow/data/models.dart';
import 'package:tictacthrow/data/reducers.dart';

class Intents {
  
  static Future logIn(AppStateObservable state) async {

  }

  static Future restart(AppStateObservable state) async {
    state.value = Reducers.restart(state.value);
  }

  static Future focus(AppStateObservable state, int row, int col) async {
    state.value = Reducers.setFocused(state.value, row, col);
  }

  static Future play(AppStateObservable state, int player) async {
    state.value = Reducers.play(state.value, player);
  }

  static Future checkStatus(AppStateObservable state) async {
    state.value = Reducers.checkStatus(state.value);
  }

  static Future changeSensitivity(AppStateObservable state, double newSens) async {
    state.value = Reducers.changeSensitivity(state.value, newSens);
  }

}
