import 'package:flutter/material.dart';

import 'package:tictacthrow/data/models.dart';

class Reducers {

  static AppState loading() => AppState(
    focused: [0, 0],
    board: [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
    status: 0,
  );
  
  static AppState restart(AppState old) => old.copyWith(
    focused: [0, 0],
    board: [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
    status: 0,
  );

  static AppState setFocused(AppState old, int row, int col) {
    return old.copyWith(
      focused: [row, col],
      readingInput: true,
    );
  }

  static AppState play(AppState old, int player) {
    return old.copyWith(
      board: old.board..[old.focused[0]][old.focused[1]] = player,
      readingInput: false,
    );
  }

  static AppState checkStatus(AppState old) {
    return old.copyWith(
      status: old.checkWin()
    );
  }

  static AppState changeSensitivity(AppState old, double newSens) {
    return old.copyWith(
      sensitivity: newSens,
    );
  }

}
