import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:tictacthrow/localizations.dart';
import 'package:tictacthrow/data/models.dart';
import 'package:tictacthrow/data/provider.dart';
import 'package:tictacthrow/widgets/login_button.dart';

class Login extends StatelessWidget {

  Future<Null> loginFB() async {
    
  }

  @override
  Widget build(BuildContext context) {
    final stateVal = Provider.of(context).value;
    final locales = TTTLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locales.appTitle,
          style: theme.textTheme.title,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(
              img: Image.asset('facebook.png'),
              text: locales.loginBtn + ' Facebook',
              color: Colors.blue,
              login: loginFB,
            ),
          ],
        ),
      ),
    );
  }

}

