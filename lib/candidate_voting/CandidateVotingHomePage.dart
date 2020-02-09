import 'package:election_gh/model/CandidateVotingModel.dart';
import 'package:election_gh/model/CandidatesModel.dart';
import 'package:election_gh/overlay/LoginOverLay.dart';
import 'package:election_gh/screens/auth/registration.dart';
import 'package:election_gh/services/Globals.dart' as global;
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/services/api_services.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:election_gh/util/connection_status.dart';
import 'package:election_gh/util/progresss_hud/progress_hud.dart';
import 'package:election_gh/util/toast_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidateVotingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votering 2020',
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

var color1 = Color(0xFFa572c0);
var color2 = Color(0xFF6559d4);
var profileImage = NetworkImage(
    'https://voting.wenotek.com/images/candidate_images/zuckerberg.jpg');
AssetImage ndcAssetsImage = new AssetImage('assets/images/ndc.jpg');
AssetImage nppAssetsImage = new AssetImage('assets/images/npp.jpg');

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: new Column(
                children: <Widget>[
                  TopSection(),
                  /* SizedBox(
              height: 8.0,
            ),*/
                  UpperSection(),
                  /*SizedBox(
              height: 32.0,
            ),*/
                  MiddleSection()

                  // Spacer(),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: BottomSection());
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: color1.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    // --
                    navigateRegistration(context);
                  },
                  child: Text('Register'),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text('Security & Data'),
                SizedBox(
                  width: 16.0,
                ),
                Text('Settings'),
                SizedBox(
                  width: 16.0,
                ),
                Text('Analysis'),
              ],
            ),
            Text('Help')
          ],
        ),
      ),
    );
  }

  //--
  void navigateRegistration(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }
}

//----
class TopSection extends StatefulWidget {
  const TopSection({
    Key key,
  }) : super(key: key);

  @override
  _TopSectionState createState() => new _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  String countList = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Container(
            height: 140,
            child: new ListView(
              scrollDirection: Axis.horizontal,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        new NetworkImage(APIConstant
                                                                .imagePath +
                                                            APIConstant
                                                                .partyImage +
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
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                    padding: EdgeInsets.only(
                                        top: 16.0, bottom: 16.0)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 16.0),
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
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "Candidate not available"),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 16.0)),
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
                                    Padding(
                                        padding: EdgeInsets.only(top: 16.0)),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.info_outline,
                                            color: UIHelper.colorGrey,
                                            size: 50),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 20.0)),
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "Something went wrong " +
                                                          global.statusCode
                                                              .toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 16.0)),
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
                              padding: const EdgeInsets.only(
                                  top: 16.0, bottom: 16.0),
                              child: Column(children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.info_outline,
                                        color: UIHelper.colorGrey, size: 50),
                                    Padding(
                                        padding: EdgeInsets.only(left: 20.0)),
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Voting not available"),
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

            /*ListView(
                  padding: EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[

                    _candidateListContainer(),
                    ItemCard(nppAssetsImage, Icons.fingerprint,
                        UIHelper.nanaAkufoAddo, UIHelper.vote),
                    new Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        height: 1,
                        width: double.maxFinite,
                        color: Colors.grey,
                      ),
                    ),
                    ItemCard(ndcAssetsImage, Icons.fingerprint,
                        UIHelper.johnDramaniMahama, UIHelper.vote),

                  ],
                )*/
          ),
        )
      ]),
    );
  }
}
//---

class MiddleSection extends StatefulWidget {
  const MiddleSection({
    Key key,
  }) : super(key: key);

  @override
  _MiddleSectionState createState() => new _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection> {
  String countList = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
              child: Stack(children: <Widget>[
            Divider(
              height: 8.0,
            ),
            ListTile(
              title: Text("Presidential candidate voting"),
              subtitle: Text(
                  countList.toString() + 'The candidates representing parties'),
              trailing: ClipOval(
                child: Container(
                    height: 40.0,
                    width: 40.0,
                    color: Colors.green.withOpacity(0.2),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.fingerprint),
                      color: Colors.green,
                    )),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                child: _candidateListContainer(),

                /*ListView(
                  padding: EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[

                    _candidateListContainer(),
                    ItemCard(nppAssetsImage, Icons.fingerprint,
                        UIHelper.nanaAkufoAddo, UIHelper.vote),
                    new Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        height: 1,
                        width: double.maxFinite,
                        color: Colors.grey,
                      ),
                    ),
                    ItemCard(ndcAssetsImage, Icons.fingerprint,
                        UIHelper.johnDramaniMahama, UIHelper.vote),

                  ],
                )*/
              ),
            )
          ])),
        ],
      ),
    );
  }

  //--

  //-- List view
  Widget _candidateListContainer() {
    return new Container(
      padding: EdgeInsets.all(0),
      child: new ListView(
        scrollDirection: Axis.vertical,
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
                      children: item
                          .map((item) => new Column(
                                children: <Widget>[
                                  ItemCard(item),
                                  /*new Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: Container(
                                      height: 1,
                                      width: double.maxFinite,
                                      color: Colors.grey,
                                    ),
                                  )*,*/
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
                    new Padding(padding: new EdgeInsets.all(50.0)),
                    new CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 64.0, left: 4.0, right: 4.0, bottom: 32.0),
    );
  }
}

class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => new _ItemCardState();

  final Candidate candidate;

  ItemCard(this.candidate);
}

class _ItemCardState extends State<ItemCard> {
  Color _iconColor = Colors.grey;
  int voterID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // -- get preference ID
    getVoterAccountIDPreference();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        margin: EdgeInsets.all(1),
        elevation: 0.0,
        //color: Color.fromRGBO(64, 75, 96, .9),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //---
            new Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: IntrinsicHeight(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: new NetworkImage(
                                          APIConstant.imagePath +
                                              APIConstant.candidateImage +
                                              widget
                                                  .candidate.candidateImageUrl),
                                      radius: 50,
                                    ),
                                  ),

                                  new Text(
                                    widget.candidate.candidateName,
                                    textAlign: TextAlign.left,
                                  ),

                                  /* Row( children: [
                                    Expanded(
                                      child: Column(children: [
                                        CircleAvatar(
                                          backgroundImage: new NetworkImage(
                                              APIConstant
                                                  .imagePath +
                                                  APIConstant
                                                      .partyImage +
                                                  widget.candidate.partyImageUrl),
                                          radius: 16,
                                        ),
                                      ]),
                                    ),
                                    Expanded(child: new Text(
                                      widget.candidate.partyName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    )),
                                  ])*/

                                  //Container(height: 120.0, color: Colors.yellow),
                                  // Container(height: 100.0, color: Colors.cyan),
                                ]),
                          ),
                          Expanded(
                              child: new Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: new Center(
                                    child: InkWell(
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(
                                            Icons.fingerprint,
                                            size: 80,
                                            color: _iconColor,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            UIHelper.vote,
                                            style: TextStyle(
                                                color: _iconColor
                                                    .withOpacity(0.6)),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        // -- show dialog

                                        print("IMG URL " +
                                            APIConstant.baseURL +
                                            APIConstant.imagePath +
                                            APIConstant.candidateImage +
                                            widget.candidate.candidateImageUrl);
                                        // --

                                        _showVoteCandidateVotingDialog(
                                            context,
                                            widget.candidate.candidateImageUrl,
                                            widget.candidate.candidateName,
                                            UIHelper.vote);
                                        setState(() {
                                          _iconColor = Colors.green;
                                        });
                                      },
                                    ),
                                  ))),
                        ]),
                  )),
            ),

            new Center(
              child: new Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
                child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(children: [
                      new Padding(
                        padding: EdgeInsets.all(4),
                        child: CircleAvatar(
                          backgroundImage: new NetworkImage(
                              APIConstant.imagePath +
                                  APIConstant.partyImage +
                                  widget.candidate.partyImageUrl),
                          radius: 16,
                        ),
                      ),
                      Expanded(
                          child: new Text(
                        widget.candidate.partyName,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
                      )),
                    ])),
              ),
            ),

            Divider()
          ],
        ));
  }

  Future<void> _showVoteCandidateVotingDialog(BuildContext context,
      String assetImage, String candidateName, String candidateID) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: new Column(
            children: <Widget>[
              Text("Do you want to vote for \n"),
              new Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: new NetworkImage(APIConstant.imagePath +
                        APIConstant.candidateImage +
                        widget.candidate.candidateImageUrl),
                    radius: 24,
                  ),
                  Expanded(
                    child: new Text(" " + candidateName + " ?"),
                  ),
                ],
              )
            ],
          ),
          content: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new InkWell(
                        onTap: () {
                          // -- dismiss
                          Navigator.of(context).pop();
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Text("Cancel"),
                        ),
                      ),
                      new InkWell(
                        onTap: () {
                          // -- execute voting
                          _executeCandidateVoting(
                              widget.candidate.id.toString());

                          //-- dismiss dialog
                          Navigator.pop(context);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Text("Vote"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //---

  void _executeCandidateVoting(String candidateID) {
    ToastAlert toastAlert = new ToastAlert();
    ConnectionStatus().checkInternetStatus().then((internet) {
      if (internet != null && internet) {
        // Internet Present Case

        if (voterID == 0) {
          // show account verification  dialog
          showLoginOverlay(context);
        } else {
          executeCandidateVotingRequest(
              "Voting In Progress ...",
              APIConstant.baseURL + APIConstant.votes,
              voterID.toString(),
              candidateID);
        }
      } else {
        // No-Internet Case

        toastAlert.toastMessages(UIHelper.noInternet);
      }
    });
  }

  //--
  void showLoginOverlay(BuildContext context) {
    showDialog(context: context, builder: (_) => LoginOverLay());
  }

  //---
  Future<void> executeCandidateVotingRequest(String progressMessage,
      String requestURL, String voterID, String candidateID) async {
    // --  do voting request
    doCandidateVotingRequest(requestURL, voterID, candidateID);
    ProgressHud.show(context, progressMessage);
  }

  //---
  getVoterAccountIDPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    voterID = prefs.getInt(UIHelper.isRegistered) ?? 0;
  }

// -- candidate voting request
  void doCandidateVotingRequest(
      String requestURL, String voterIDNumber, String candidateID) {
    ToastAlert toastAlert = new ToastAlert();
    //-- progress hud
    ProgressHud progressHud = ProgressHud();

    CandidateVotingModel candidateVotingModel = new CandidateVotingModel();
    candidateVotingModel.setVoterIDNumber(voterIDNumber);
    candidateVotingModel.setCandidateID(candidateID);

    candidateVotingAsyncRequest(requestURL, candidateVotingModel).then((value) {
      // hide progress bar

      if (value.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "200") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });
        // _validateInputs();
        //navigationVoterIDUploadPage();
      } else {
        // Toast response
        toastAlert.toastMessages(candidateVotingModel.getStatusMessage);
        progressHud.navigator.pop();
      }
    });
    Future.delayed(Duration(milliseconds: 2000)).then((val) {
      ProgressHud.hide();
    });
    // _validateInputs();
    //  navigationVoterIDUploadPage();
  }
}

class UpperSection extends StatelessWidget {
  const UpperSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 0.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  UIHelper.colorRed,
                  UIHelper.colorYellow,
                  UIHelper.colorGreen
                ])),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: ListTile(
            title: Text("2020 Voting"),
            subtitle: Text('Please vote for your candidate by clicking "VOTE"'),
          ),
        )
      ],
    );
  }

// -- call to preference storage
/*getVoterAccountIDPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt('voter-shared-preference');
  }*/

//-- navigate registration

}
