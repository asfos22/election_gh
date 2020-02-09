import 'package:election_gh/screens/auth/registration.dart';
import 'package:flutter/material.dart';

import '../ui_helper.dart';

class RegistrationButton extends StatelessWidget {
  final Color color;
  final double rightPadding;

  const RegistrationButton({Key key, this.color, this.rightPadding})
      : super(key: key);

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
                // --
                registrationNavRoute(context);
              },
              child: Text(UIHelper.dontHaveAnAccount + " " + UIHelper.signUp,
                  style: TextStyle(fontSize: 15, color: color)),
            ),
          )),
    );
  }

  //---

  void registrationNavRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }
}
