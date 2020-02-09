import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/material.dart';

const double IMAGE_SIZE = 200.0;

class AppIntroOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [
        UIHelper.colorWhite,
        UIHelper.colorWhite,
        UIHelper.colorWhite,
      ], begin: Alignment(0.5, -1.0), end: Alignment(0.5, 1.0))),
      child: Stack(
        children: <Widget>[
          new Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage(UIHelper.sliderAssetOne),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: IMAGE_SIZE,
                ),
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    UIHelper.sliderHeaderOne,
                    style: UIHelper.normalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                  child: Text(
                    UIHelper.sliderDesc,
                    style: UIHelper.normalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}
