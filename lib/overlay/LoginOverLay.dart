import 'package:election_gh/model/AuthModel.dart';
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/services/api_services.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:election_gh/ui/widgets/registrationButton.dart';
import 'package:election_gh/util/connection_status.dart';
import 'package:election_gh/util/progresss_hud/progress_hud.dart';
import 'package:election_gh/util/toast_alert.dart';
import 'package:election_gh/util/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginOverLay extends StatefulWidget {
  //--
  LoginOverLay({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CancelDeliveryRequestOverlayState();
}

class CancelDeliveryRequestOverlayState extends State<LoginOverLay>
    with SingleTickerProviderStateMixin {
  //--
  AnimationController controller;
  Animation<double> scaleAnimation;

  // toast
  ToastAlert toastAlert = new ToastAlert();

  // --
  //-- progress hud
  ProgressHud progressHud = ProgressHud();

  //--
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String votersID, passCode;

  TextEditingController voterIDTextEditingController = TextEditingController();
  TextEditingController psCodeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      children: <Widget>[
                        new Card(
                            //color: ColorConstant.colorWhite,
                            elevation: 0.0,
                            child: new Column(
                              children: <Widget>[
                                Text(
                                  UIHelper.signInLower,
                                  style: TextStyle(
                                      color: UIHelper.colorRed, fontSize: 40),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                _editVoterIDTextContainer(
                                    voterIDTextEditingController,
                                    UIHelper.enterVoterID),
                                _editPSCodeTextContainer(
                                    psCodeTextEditingController,
                                    UIHelper.enterPSCode),
                                _loginButton,
                                new RegistrationButton(
                                  color: UIHelper.colorBlue,
                                  rightPadding: 0.0,
                                ),
                              ],
                            )),
                        closeContainer()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //--

  Container closeContainer() {
    return new Container(
      child: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: ButtonTheme(
                    height: 62.0,
                    minWidth: 62.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: UIHelper.colorGrey,
                      ),
                      tooltip: "Close",
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                    )))),
      ]),
    );
  }

  Widget _editVoterIDTextContainer(
      TextEditingController editingController, String labelText) {
    return new Container(
        child: new Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
            child: new TextFormField(
              autofocus: false,
              validator: InputValidators.validateVoterID,
              onSaved: (value) => votersID = value,
              controller: editingController,
              decoration: new InputDecoration(
                  labelText: labelText,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: new Icon(Icons.input))),
              keyboardType: TextInputType.number,
            )),
        margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0));
  }

  Widget _editPSCodeTextContainer(
      TextEditingController editingController, String labelText) {
    return new Container(
        child: new Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
            child: new TextFormField(
              autofocus: false,
              validator: InputValidators.validatePassCode,
              onSaved: (value) => passCode = value,
              controller: editingController,
              decoration: new InputDecoration(
                  labelText: labelText,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 7.0),
                      child: new Icon(Icons.input))),
              keyboardType: TextInputType.text,
            )),
        margin: EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0));
  }

  Widget get _loginButton => Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
        child: MaterialButton(
          height: 56,
          minWidth: double.infinity,
          color: UIHelper.colorBlueSecondary,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          onPressed: () {
            //showHud();
            //showMessageHud();
            _validateInputs(voterIDTextEditingController.text.toString(),
                psCodeTextEditingController.text.toString());
          },
          child: Text(
            UIHelper.verify,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );

  //--
  Future<void> executeVerificationRequest(String progressMessage,
      String requestURL, String voterID, String psCode) async {
    // you can change some property， like  hud.progressColor = Colors.red;
    progressHud.progressColor = Colors.yellow;
    // --
    progressHud.loadingMessage = progressMessage;

    // --  do verification request

    doVerificationRequest(requestURL, voterID, psCode);

    ProgressHud.show(context, progressMessage);
  }

  //--- make request

// -- login request

  // -- login request
  void doVerificationRequest(
      String requestURL, String voterIDNumber, String psCode) {
    AuthModel authModel = new AuthModel();
    authModel.setVoterIDNumber(voterIDNumber);
    authModel.setVoterPSCode(psCode);

    verificationAsyncRequest(requestURL, authModel).then((value) {
      // hide progress bar

      if (value.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "true") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();

          // --
          Navigator.of(context).pop();
        });
      } else {
        // Toast response
        toastAlert.toastMessages(authModel.getStatusMessage.toString());
        progressHud.navigator.pop();
      }
    });
    toastAlert.toastMessages(authModel.getStatusCode.toString());

    Future.delayed(Duration(milliseconds: 2000)).then((val) {
      ProgressHud.hide();
    });
  }

  //-- validation

  void _validateInputs(String voterID, String psCode) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // If the form is valid, make API request

      ConnectionStatus().checkInternetStatus().then((internet) {
        if (internet != null && internet) {
          // Internet Present Case

          executeVerificationRequest("Wait Verifying ...",
              APIConstant.baseURL + APIConstant.login, voterID, psCode);
        } else {
          // No-Internet Case

          toastAlert.toastMessages(UIHelper.noInternet);
        }
      });
    } else {
      setState(() {
        //If the data is not valid, TextFormField autoValidate => true to help user
        _autoValidate = true;
      });
    }
  }
}
