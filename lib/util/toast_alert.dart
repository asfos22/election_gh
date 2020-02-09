import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastAlert {
  void toastMessages(String statusMessage) {
    Fluttertoast.showToast(
      msg: statusMessage,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 1,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: UIHelper.colorBlueSecondary,
    );
  }
}
