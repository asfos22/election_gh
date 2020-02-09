import 'package:election_gh/intro/AppIntroOneScreen.dart';
import 'package:election_gh/intro/AppIntroThreeScreen.dart';
import 'package:election_gh/intro/AppIntroTwoScreen.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:election_gh/util/intro/DotsIndicator.dart';
import 'package:flutter/material.dart';

class AppIntroDefaultScreen extends StatefulWidget {
  @override
  AppIntroDefaultScreenState createState() => AppIntroDefaultScreenState();
}

class AppIntroDefaultScreenState extends State<AppIntroDefaultScreen> {
  final pageController = new PageController();
  final List<Widget> pages = [
    AppIntroOneScreen(),
    AppIntroTwoScreen(),
    AppIntroThreeScreen(),
  ];
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = page == pages.length - 1;
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Stack(
          children: <Widget>[
            new Positioned.fill(
              child: new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: pageController,
                itemCount: pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return pages[index % pages.length];
                },
                onPageChanged: (int p) {
                  setState(() {
                    page = p;
                  });
                },
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  primary: false,
                  title: Text(UIHelper.appName),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        isDone ? UIHelper.done : UIHelper.next,
                        style: TextStyle(color: UIHelper.colorWhite),
                      ),
                      onPressed: isDone
                          ? () {
                              // --
                              navigateLoginPage();
                            }
                          : () {
                              pageController.animateToPage(page + 1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                    )
                  ],
                ),
              ),
            ),
            new Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new DotsIndicator(
                        controller: pageController,
                        itemCount: pages.length,
                        onPageSelected: (int page) {
                          pageController.animateToPage(
                            page,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          width: 150.0,
                          height: 50.0,
                          // margin: EdgeInsets.only(top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [
                                  UIHelper.colorWhite,
                                  UIHelper.colorWhite,
                                ],
                                begin: Alignment(0.5, -1.0),
                                end: Alignment(0.5, 1.0)),
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: new Material(
                            child: MaterialButton(
                              child: Text(
                                'REGISTER',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: UIHelper.colorBlue),
                              ),
                              onPressed: () {
                                // --
                                navigateRegistrationPage();
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            color: Colors.transparent,
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        new Container(
                          width: 150.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.white, width: 1.0),
                            color: UIHelper.colorGreen,
                          ),
                          child: new Material(
                            child: MaterialButton(
                              child: Text(
                                'VERIFICATION',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.white),
                              ),
                              onPressed: () {
                                // --
                                navigateLoginPage();
                              },
                              highlightColor: Colors.white30,
                              splashColor: Colors.white30,
                            ),
                            color: Colors.transparent,
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  // -- login
  void navigateLoginPage() {
    Navigator.of(context).pushReplacementNamed("/LoginPage");
  }

  // -- registration

  void navigateRegistrationPage() {
    Navigator.of(context).pushReplacementNamed("/RegistrationPage");
  }
}
