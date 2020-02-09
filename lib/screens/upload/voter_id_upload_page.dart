import 'dart:io';

import 'package:election_gh/model/AuthModel.dart';
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/services/api_services.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:election_gh/util/progresss_hud/progress_hud.dart';
import 'package:election_gh/util/toast_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VoterIDUpLoadPage extends StatefulWidget {
  final String psCode;
  final String voterID;
  final String voterDOB;
  final String voterSex;

  VoterIDUpLoadPage({
    Key key,
    @required this.psCode,
    @required this.voterID,
    @required this.voterDOB,
    @required this.voterSex,
  }) : super(key: key);

  @override
  _VoterIDUpLoadPageState createState() => new _VoterIDUpLoadPageState();
}

class _VoterIDUpLoadPageState extends State<VoterIDUpLoadPage> {
  File imageFile;
  ToastAlert toastAlert = new ToastAlert();

  //-- progress hud
  ProgressHud progressHud = ProgressHud();

  Future<void> _showVoteImageUploadDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(UIHelper.selectVoterID),
          content: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new InkWell(
                        onTap: () {
                          // -- camera
                          _openCamera(context);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Text(UIHelper.openCamera),
                        ),
                      ),
                      new InkWell(
                        onTap: () {
                          _openGallery(context);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Text(UIHelper.selectGallery),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UIHelper.uploadVoterID,
            style: TextStyle(
                color: UIHelper.colorGrey, fontWeight: FontWeight.bold)),
        leading: IconButton(
          tooltip: 'To Registration',
          color: UIHelper.colorGrey,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //loginNavRoute(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _imageView(),
            _buttonWidget(UIHelper.login),

            /*RaisedButton(
                onPressed: () {

                },
                child: new Column(
                  children: <Widget>[
                    new Text("Choose Voter id"),
                  ],
                )),*/
          ],
        ),
      ),
    );
  }

  // -- submit button

  Widget _buttonWidget(String requestURL) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
        child: new Column(
          children: <Widget>[
            MaterialButton(
              height: 56,
              minWidth: double.infinity,
              color: UIHelper.colorBlueSecondary,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0)),
              onPressed: () {
                _showVoteImageUploadDialog(context);
              },
              child: Text(
                UIHelper.chooseVoterID,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            imageFile != null
                ? Visibility(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
                        child: new Column(
                          children: <Widget>[
                            MaterialButton(
                              height: 56,
                              minWidth: double.infinity,
                              color: UIHelper.colorBlueSecondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                              onPressed: () {
                                if (imageFile != null) {
                                  executeRegistrationRequest(
                                      "Wait Registration ...",
                                      APIConstant.baseURL +
                                          APIConstant.registration,
                                      widget.psCode,
                                      widget.voterID,
                                      widget.voterDOB,
                                      widget.voterSex,
                                      imageFile);
                                } else {
                                  toastAlert
                                      .toastMessages(UIHelper.chooseImage);
                                }
                              },
                              child: Text(
                                UIHelper.submit,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                    visible: true,
                  )
                : new Container()
          ],
        ));
  }

  // --
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    this.setState(() {
      imageFile = picture;
    });

    Navigator.of(context).pop();
  }

  // --

  void _openCamera(BuildContext context) async {
    var camPicture = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    this.setState(() {
      imageFile = camPicture;
    });

    Navigator.of(context).pop();
  }

  //---

  Widget _imageView() {
    if (imageFile == null) {
      return Text("No voter ID Selected");
    } else {
      return Image.file(imageFile, width: 400, height: 400);
    }
  }

  //---

  void navigateToRegistrationScreen() {
    Navigator.of(context).pushReplacementNamed('/RegistrationPage');
  }

  // If the form is valid, redirect to home.

  void navigateToVotingScreen() {
    Navigator.of(context).pushReplacementNamed('/CandidateVotingPage');
  }

  // -- async request
  // --- registration  request

  Future<void> executeRegistrationRequest(
      String progressMessage,
      String requestURL,
      String psCode,
      String voterID,
      String voterDOB,
      String voterSex,
      File imageFile) async {
    // --  do verification request

    doRegistrationRequest(
        requestURL, psCode, voterID, voterDOB, voterSex, imageFile);
    ProgressHud.show(context, progressMessage);
  }

// -- registration request
  void doRegistrationRequest(
      String requestURL,
      String voterPsCode,
      String voterIDNumber,
      String voterDOB,
      String voterSex,
      File voterCardImage) {
    AuthModel authModel = new AuthModel();
    authModel.setVoterIDNumber(voterIDNumber);
    authModel.setVoterPSCode(voterPsCode);
    authModel.setVoterSex(voterSex);
    // authModel.setVoterAge(voterAge);
    authModel.setVoterDOB(voterDOB);
    authModel.setVoterCardImage(voterCardImage);

    /// authModel.setVoterAge(voterAge);
    /// authModel.setVoterDOB(voterDOB);
    ///

    registrationAsyncRequest(requestURL, authModel).then((value) {
      // hide progress bar

      if (value.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "200") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });
        // _validateInputs();
        //navigationVoterIDUploadPage();

        navigateToVotingScreen();
      } else {
        // Toast response
        toastAlert.toastMessages(authModel.getStatusMessage);
        progressHud.navigator.pop();
      }
    });
    Future.delayed(Duration(milliseconds: 2000)).then((val) {
      ProgressHud.hide();
    });
  }
}
