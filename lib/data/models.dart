import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AppState {

  final bool isLoggedIn;
  final Auth auth;
  final List<int> focused;
  // 0 is unplayed, 1 is circle, 2 is cross
  final List<List<int>> board;
  final bool readingInput;
  // 0 is in progress, 1 is circles win, 2 is crosses win
  final int status;
  // acceleration sensitivity
  final double sensitivity;

  AppState({
    this.isLoggedIn = false,
    this.auth,
    this.focused,
    this.board,
    this.readingInput,
    this.status = 0,
    this.sensitivity = 2.0,
  });

  factory AppState.from(AppState prev) {
    return AppState(
      isLoggedIn: prev.isLoggedIn,
      auth: prev.auth,
      focused: prev.focused,
      board: prev.board,
      readingInput: prev.readingInput,
      status: prev.status,
      sensitivity: prev.sensitivity,
    );
  }

  AppState copyWith({
    bool isLoggedIn,
    Auth auth,
    List<int> focused,
    List<List<int>> board,
    bool readingInput,
    int status,
    double sensitivity,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      auth: auth ?? this.auth,
      focused: focused ?? this.focused,
      readingInput: readingInput ?? this.readingInput,
      board: board ?? this.board,
      status: status ?? this.status,
      sensitivity: sensitivity ?? this.sensitivity,
    );
  }

  int checkWin() {
    int winner = 0;

    // check diagonals
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) winner = board[0][0];
    if (board[2][0] == board[1][1] && board[1][1] == board[0][2]) winner = board[0][0];

    for (var row in board) {
      if (row[0] == row[1] && row[1] == row[2]) {
        winner = row[0];
        break;
      }
    }
    for (int j = 0; j < board[0].length; j++) {
      if (board[0][j] == board[1][j] && board[1][j] == board[2][j]) {
        winner = board[0][j];
        break;
      }
    }

    return winner;
  }

  @override
  int get hashCode =>
    isLoggedIn.hashCode ^
    auth.hashCode ^
    focused.hashCode ^
    readingInput.hashCode ^
    board.hashCode ^
    status.hashCode ^
    sensitivity.hashCode;

}

class AppStateObservable extends ValueNotifier {
  AppStateObservable(AppState value) : super(value);
}

class Auth {

  final google;
  final facebook;

  Auth({
    this.google,
    this.facebook,
  });

}
