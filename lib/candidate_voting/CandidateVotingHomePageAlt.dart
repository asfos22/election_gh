import 'package:election_gh/candidate_voting/CandidateVotingHomePage.dart';
import 'package:election_gh/model/CandidatesModel.dart';
import 'package:election_gh/model/tabIcon_data.dart';
import 'package:election_gh/services/Globals.dart' as global;
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/services/api_services.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';

class CandidateVotingHomePageAltScreen extends StatefulWidget {
  @override
  _CandidateVotingHomePageAltScreen createState() =>
      _CandidateVotingHomePageAltScreen();
}

class _CandidateVotingHomePageAltScreen
    extends State<CandidateVotingHomePageAltScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 16.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  //--

  List<Widget> _tabTabView() => [
        Tab(
          text: "Voting",
          icon: Icon(Icons.fingerprint),
        ),
        Tab(text: "Results", icon: Icon(Icons.trending_up)),
      ];

  TabBar _tabBarLabel() => TabBar(
        tabs: _tabTabView(),
        labelColor: UIHelper.colorGreen,
        labelPadding: EdgeInsets.symmetric(vertical: 10),
        labelStyle: TextStyle(fontSize: 20),
        unselectedLabelColor: UIHelper.colorGrey,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        onTap: (index) {
          var content = "";
          switch (index) {
            case 0:
              content = "Voting";
              break;
            case 1:
              content = "Results";
              break;
            default:
              content = "Settings";
              break;
          }
          print("You are clicking the $content");
        },
      );

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height;
    return Container(
      color: UIHelper.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 64.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("Presidential candidate voting"),
                          subtitle: Text('The candidates representing parties'),
                          trailing: ClipOval(
                            child: Container(
                                height: 40.0,
                                width: 40.0,
                                color: UIHelper.colorGreen.withOpacity(0.2),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.fingerprint),
                                  color: Colors.green,
                                )),
                          ),
                        ),
                        _tabBarLabel()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(children: [
                        Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: UIHelper.nearlyWhite,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: UIHelper.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 0.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SingleChildScrollView(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: infoHeight,
                                      maxHeight: tempHeight > infoHeight
                                          ? tempHeight
                                          : infoHeight),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text("2020 Voting"),
                                        subtitle: Text(
                                            'Please vote for your candidate by clicking "VOTE"'),
                                      ),

                                      /*AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: partyWidgetContainer(),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ListTile(
                                title: Text("2020 Voting"),
                                subtitle: Text(
                                    'Please vote for your candidate by clicking "VOTE"'),
                              ),
                            ),
                          ),*/

                                      Expanded(
                                        child: AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          opacity: opacity2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 0,
                                                bottom: 124),
                                            child: new Center(
                                              child: _candidateListContainer(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                margin: EdgeInsets.all(16.0),
                                //Radar Chart
                                child: Center(
                                  child: //Pie Chart
                                      PieChart(
                                    values: [15, 10, 30, 25, 20],
                                    labels: [
                                      "NPP",
                                      "CPP",
                                      "NDC",
                                      "PNDC",
                                      "NDP"
                                    ],
                                    sliceFillColors: [
                                      Colors.blueAccent,
                                      Colors.greenAccent,
                                      Colors.pink,
                                      Colors.orange,
                                      Colors.red,
                                    ],
                                    animationDuration:
                                        Duration(milliseconds: 1500),
                                    legendPosition: LegendPosition.Left,
                                  ),
                                ))
                          ]),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
            /*Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.8,
                  child: Image.asset('assets/images/gh_flag.png'),
                ),
              ],
            ),*/
          ],
        ),
        //  bottomSheet: BottomSection(),
      ),
    );
  }

  Widget getTimeBoxUI(String imagePath, String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: UIHelper.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: UIHelper.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: new NetworkImage(imagePath),
                radius: 16,
              ),
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: UIHelper.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: UIHelper.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //-- delivery option container

  Widget _candidateListContainer() {
    return new Container(
      height: MediaQuery.of(context).size.height / 1,
      decoration: BoxDecoration(
        color: UIHelper.nearlyWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: UIHelper.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        //scrollDirection: Axis.vertical,
        //padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new FutureBuilder<List<Candidate>>(
            future: fetchRecentCandidateRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Candidate> item = snapshot.data;

                // -- success
                if (global.statusCode == 200) {
                  // List<Assignment> list = [];
                  return new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: item.map((item) => ItemCard(item)).toList());

                  // no request found
                } else if (APIConstant().notFound == 0) {
                  // -- not request found
                  return new Card(
                    elevation: 0.0,
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.info_outline,
                                    color: UIHelper.colorGrey, size: 50),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, bottom: 16.0)),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(text: "Candidate not available"),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );

                  // --
                } else if (global.statusCode != 200) {
                  return new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // no  record found
                      new Card(
                        elevation: 0.0,
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 16.0)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.info_outline,
                                      color: UIHelper.colorGrey, size: 50),
                                  Padding(padding: EdgeInsets.only(left: 20.0)),
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Something went wrong " +
                                                global.statusCode.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return new Card(
                  elevation: 0.0,
                  margin: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Column(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.info_outline,
                                  color: UIHelper.colorGrey, size: 50),
                              Padding(padding: EdgeInsets.only(left: 20.0)),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: "Voting not available"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ],
                  ),
                );
              }
              //--
              return new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.all(50.0)),
                    new CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 110.0),
    );
  }

  // -- party widget

  Widget partyWidgetContainer() {
    return new Container(
      height: MediaQuery.of(context).size.height / 7,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new FutureBuilder<List<Candidate>>(
            future: fetchRecentCandidateRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Candidate> item = snapshot.data;

                // -- success
                if (global.statusCode == 200) {
                  // List<Assignment> list = [];

                  return new Row(
                      children: item
                          .map((item) => new Column(
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      getTimeBoxUI(
                                          APIConstant.imagePath +
                                              APIConstant.partyImage +
                                              item.partyImageUrl,
                                          '24',
                                          'NPP'),

                                      /* new Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: new NetworkImage(
                                                  APIConstant.imagePath +
                                                      APIConstant.partyImage +
                                                      item.partyImageUrl),
                                            ),
                                            SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              item.partyName,
                                              style: TextStyle(
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.0,
                                            ),
                                            Text(
                                              item.candidateName,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),*/

                                      new Padding(
                                        padding: EdgeInsets.all(8.0),
                                      )
                                    ],
                                  ),

                                  /* new Card(
                                      elevation: 0.0,
                                      margin: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(children: <Widget>[
                                            Padding(padding: EdgeInsets.only(top: 16.0)),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(Icons.info_outline,
                                                    color: UIHelper.colorGrey, size: 50),
                                                Padding(padding: EdgeInsets.only(left: 20.0)),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: item.candidateName),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                          Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                        ],
                                      ),
                                    ),*/
                                ],
                              ))
                          .toList());

                  // no request found
                } else if (APIConstant().notFound == 0) {
                  // -- not request found
                  return new Card(
                    elevation: 0.0,
                    margin: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 16.0, bottom: 16.0)),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.info_outline,
                                    color: UIHelper.colorGrey, size: 50),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, bottom: 16.0)),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(text: "Candidate not available"),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  );

                  // --
                } else if (global.statusCode != 200) {
                  return new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // no  record found
                      new Card(
                        elevation: 0.0,
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Padding(padding: EdgeInsets.only(top: 16.0)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.info_outline,
                                      color: UIHelper.colorGrey, size: 50),
                                  Padding(padding: EdgeInsets.only(left: 20.0)),
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "Something went wrong " +
                                                global.statusCode.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return new Card(
                  elevation: 0.0,
                  margin: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Column(children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.info_outline,
                                  color: UIHelper.colorGrey, size: 50),
                              Padding(padding: EdgeInsets.only(left: 20.0)),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: "Voting not available"),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ],
                  ),
                );
              }
              //--
              return new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.all(16.0)),
                    new CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
