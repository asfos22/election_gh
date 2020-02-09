import 'package:election_gh/screens/auth/login.dart';
import 'package:flutter/material.dart';

import '../ui_helper.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final double rightPadding;

  const LoginButton({Key key, this.color, this.rightPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 5, rightPadding, 0),
          child: SizedBox(
            height: 60,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0)),
              onPressed: () {
                //---
                navigateToLoginScreen(context);
              },
              child: Text(UIHelper.verifyAccount,
                  style: TextStyle(fontSize: 15, color: color)),
            ),
          )),
    );
  }

  //--
  void navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
