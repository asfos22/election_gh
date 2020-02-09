import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // --
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curvedAnimation;
  int isInstall, isRegistered;

  // --

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 20),
      vsync: this,
    );
    //--
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();

    curvedAnimation = new CurvedAnimation(
      parent: animation,
      curve: Curves.linear,
    )..addStatusListener((AnimationStatus status) {
        // --
        if (status == AnimationStatus.completed) {
          checkAuthStatus();
        }
      });
  }

  // --
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  // --
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final logo = ScaleTransition(
        scale: animation,
        child: new Image.asset(
          UIHelper.sliderAssetTwo,
          width: animation.value * 100,
          height: animation.value * 100,
        ));

    // --

    final descriptionText = FadeTransition(
      child: SlideTransition(
          position: Tween<Offset>(begin: Offset(0.0, -0.8), end: Offset.zero)
              .animate(animationController),
          child: Text(
            UIHelper.appName,
            style: textStyle.copyWith(fontSize: 30.0),
          )),
      opacity: animation,
    );

    // --
    return new Scaffold(
      body: new Center(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // --
            Opacity(
              opacity: 1,
              child: Container(
                color: UIHelper.colorWhite,
              ),
            ),

            // --
            SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: logo,
                        ),
                        descriptionText,
                        SizedBox(
                          height: 35.0,
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  // -- Navigation home
  void navigateHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed('/CandidateVotingHomePageAltScreen');
  }

  // -- App intro
  void navigateAppIntroPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/AppIntroDefaultScreen');
  }

  // -- Auth  status
  checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isInstall = prefs.getInt(UIHelper.isInstall) ?? 0;
      isRegistered = prefs.getInt(UIHelper.isRegistered) ?? 0;

      // -- check for install

      if (isInstall == 0 && isRegistered == 0) {
        //--
        navigateAppIntroPage(context);

        print(" not REGISTRED : " +
            isInstall.toString() +
            " " +
            isRegistered.toString());
      } else {
        //--
        navigateHomePage(context);
        print("REGISTRED : " +
            isInstall.toString() +
            " " +
            isRegistered.toString());
      }
    });
  }
}

// --
const TextStyle textStyle = TextStyle(
  fontFamily: 'ModernAntiqua',
  color: UIHelper.colorGrey,
);
