import 'package:election_gh/candidate_voting/CandidateVotingHomePage.dart';
import 'package:election_gh/candidate_voting/CandidateVotingHomePageAlt.dart';
import 'package:election_gh/intro/AppIntroDefaultScreen.dart';
import 'package:election_gh/screens/auth/login.dart';
import 'package:election_gh/screens/auth/registration.dart';
import 'package:election_gh/splash/splash_screen.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: UIHelper.colorWhite,
      // navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarColor: UIHelper.colorWhite, // status bar color
    ));
    return MaterialApp(
      title: 'Election GH',
      theme: ThemeData(
        primaryColor: UIHelper.THEME_PRIMARY,
        primaryColorLight: UIHelper.THEME_LIGHT,
        primaryColorDark: UIHelper.THEME_DARK,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        //  '/Welcome': (BuildContext context) => Welcome(),
        '/LoginPage': (BuildContext context) => LoginScreen(),
        '/RegistrationPage': (BuildContext context) => RegistrationScreen(),
      //  '/VoterIDUpLoadPage': (BuildContext context) => VoterIDUpLoadPage(),
        '/CandidateVotingPage': (BuildContext context) =>
            CandidateVotingHomePage(),
        '/CandidateVotingHomePageAltScreen': (BuildContext context) =>
            CandidateVotingHomePageAltScreen(),
        '/AppIntroDefaultScreen': (BuildContext context) =>
            AppIntroDefaultScreen()
      },
      home: SplashScreen()
    );
  }
}
