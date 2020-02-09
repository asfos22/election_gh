import 'dart:io';

import 'package:election_gh/model/AuthModel.dart';
import 'package:election_gh/model/GenderModel.dart';
import 'package:election_gh/screens/auth/background/background.dart';
import 'package:election_gh/screens/auth/login.dart';
import 'package:election_gh/screens/upload/voter_id_upload_page.dart';
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/services/api_services.dart';
import 'package:election_gh/ui/ui_helper.dart';
import 'package:election_gh/ui/widgets/loginButton.dart';
import 'package:election_gh/util/connection_status.dart';
import 'package:election_gh/util/datetime/flutter_cupertino_date_picker.dart';
import 'package:election_gh/util/progresss_hud/progress_hud.dart';
import 'package:election_gh/util/toast_alert.dart';
import 'package:election_gh/util/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String MIN_DATETIME = '1900-05-12';
const String MAX_DATETIME = '2021-11-25';
const String INIT_DATETIME = '2002-01-01';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController voterIDTextEditingController = TextEditingController();
  TextEditingController psCodeTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  FocusNode _focus = new FocusNode();

  //--
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  // -- toast
  ToastAlert toastAlert = new ToastAlert();

  //--file
  File imageFile;

  //-- progress hud
  ProgressHud progressHud = ProgressHud();

  // Default Radio Button Item
  String genderRadioItem = '0', dateVoterDOB;
  DateTime pickedDateTime;

  // Group Value for Radio Button.
  int genderId = 0;

  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;

  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;

  List<GenderModel> genderList = [
    GenderModel(
      index: 0,
      name: UIHelper.genderMale,
    ),
    GenderModel(
      index: 1,
      name: UIHelper.genderFemale,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);

    _formatCtrl.text = _format;
    _dateTime = DateTime.parse(INIT_DATETIME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(UIHelper.signUp,
              style: TextStyle(
                  color: UIHelper.colorGrey, fontWeight: FontWeight.bold)),
          leading: IconButton(
            tooltip: 'To Login',
            color: UIHelper.colorGrey,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              loginNavRoute(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: UIHelper.colorWhite,
        body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Stack(
              children: <Widget>[
                Background(),
                Container(
                  /*decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.yellow, Colors.green])
               ),*/
                  child: new Center(
                      child: new SingleChildScrollView(
                          child: Stack(children: <Widget>[
                    Card(
                        margin: EdgeInsets.all(12),
                        color: UIHelper.colorWhite,
                        elevation: 0.0,
                        child: new Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                UIHelper.signUpLower,
                                style: TextStyle(
                                    color: UIHelper.colorRed, fontSize: 40),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(32.0),
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
                              _textField(
                                  voterIDTextEditingController,
                                  Icon(
                                    Icons.credit_card,
                                    color: UIHelper.colorWhite,
                                  ),
                                  UIHelper.voterID),
                              _textField(
                                  psCodeTextEditingController,
                                  Icon(
                                    Icons.credit_card,
                                    color: UIHelper.colorWhite,
                                  ),
                                  UIHelper.psCode),
                              _dobField,
                              genderWidget,
                              _votersIDImageWidget(),
                              _submitButton,
                              new LoginButton(
                                color: UIHelper.colorBlue,
                                rightPadding: 0.0,
                              ),
                            ],
                          ),
                        )),
                  ]))),
                )
                //Login(),
              ],
            )));
  }

  Widget _textField(TextEditingController editingController, Icon icons,
          String _hintText) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: new TextFormField(
          controller: editingController,
          autofocus: false,
          onTap: () {
            // _selectDate(context);
            if (dobTextEditingController == editingController) {
              _selectDate(context);
            }
          },
          validator: voterIDTextEditingController == editingController
              ? InputValidators.validateVoterID
              : InputValidators.validatePassCode,
          //onSaved: (value) => votersID = value,
          keyboardType: voterIDTextEditingController == editingController
              ? TextInputType.number
              : TextInputType.text,
          style: TextStyle(color: UIHelper.colorGrey),

          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: EdgeInsets.only(right: 7.0),
                child: new Icon(Icons.input)),
            suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0), child: icons),
            hintText: dobTextEditingController == editingController
                ? pickedDateTime != null && pickedDateTime == selectedDate
                    ? selectedDate.day.toString() +
                        "/" +
                        selectedDate.month.toString() +
                        "/" +
                        selectedDate.year.toString()
                    : UIHelper.dob
                : _hintText,
          ),
        ),
      );

  // gender

  Widget get genderWidget => (new Container(
        margin: EdgeInsets.all(16.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: UIHelper.colorLightGrey,
        ),
        child: new Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 16, 10),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 16, 10),
                child: new Text(UIHelper.selectGender,
                    style: TextStyle(
                        color: UIHelper.colorGrey,
                        fontWeight: FontWeight.bold)),
              ),
              Column(
                children: genderList
                    .map((data) => RadioListTile(
                          title: Text("${data.name}",
                              style: TextStyle(
                                  color: UIHelper.colorGrey,
                                  fontWeight: FontWeight.bold)),
                          groupValue: genderId,
                          value: data.index,
                          onChanged: (val) {
                            setState(() {
                              genderRadioItem = data.name;
                              genderId = data.index;

                              print("Selcted " +
                                  genderId.toString() +
                                  " " +
                                  genderRadioItem);
                            });
                          },
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ));

  //--

  Widget get _dobField => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          style: TextStyle(color: UIHelper.colorGrey),
          onTap: () {
            // _selectDate(context);
            _showDatePicker();
          },
          textAlign: TextAlign.left,
          cursorColor: UIHelper.colorGrey,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: EdgeInsets.only(right: 7.0),
                child: new Icon(Icons.input)),
            hintText:
                '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}' ??
                    UIHelper.dob,
          ),
        ),
      );

  Widget get _submitButton => Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
        child: MaterialButton(
          height: 56,
          minWidth: double.infinity,
          color: UIHelper.colorBlueSecondary,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          onPressed: () {
            // -- upload the  voters id navigation
            _validateInputs();
          },
          child: Text(
            UIHelper.submit,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );

  void _onFocusChange() {
    _selectDate(context);
  }

  // -- Date time
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    pickedDateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1910, 1),
        lastDate: DateTime(2101));
    if (pickedDateTime != null && pickedDateTime != selectedDate)
      setState(() {
        selectedDate = pickedDateTime;
      });
  }

  void loginNavRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // -- voter id upload
  void navigationVoterIDUploadPage() {
    Navigator.of(context).pushReplacementNamed('/VoterIDUpLoadPage');
  }

//-- track dialog
  showNavigationVoterIDUploadPage(
      String psCode, String voterID, String voterDOB, String voterSex) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new VoterIDUpLoadPage(
              psCode: psCode,
              voterID: voterID,
              voterDOB: voterDOB,
              voterSex: voterSex);
        },
        fullscreenDialog: true));
  }

  // --- registration  request
  //---

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
  void doSetRegistrationModel(String requestURL, String voterPsCode,
      String voterIDNumber, String voterDOB, String voterSex) {
    AuthModel authModel = new AuthModel();
    authModel.setVoterIDNumber(voterIDNumber);
    authModel.setVoterPSCode(voterPsCode);
    authModel.setVoterSex(voterSex);
    // authModel.setVoterAge(voterAge);
    authModel.setVoterDOB(voterDOB);

    /*showNavigationVoterIDUploadPage(
        voterIDNumber, voterPsCode, voterDOB, voterSex);*/

    print("REG2 " +
        authModel.getVoterSex +
        " " +
        authModel.getVoterDOB +
        "" +
        authModel.getVoterIDNumber +
        " " +
        authModel.getVoterPSCode);

    //showNavigationVoterIDUploadPage()

    /// authModel.setVoterAge(voterAge);
    /// authModel.setVoterDOB(voterDOB);

    registrationAsyncRequest(requestURL, authModel).then((value) {
      // hide progress bar

      if (value.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "200") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });
        // _validateInputs();
        navigationVoterIDUploadPage();
      } else {
        // Toast response
        toastAlert.toastMessages(authModel.getStatusMessage);
        progressHud.navigator.pop();
      }
    });
    Future.delayed(Duration(milliseconds: 2000)).then((val) {
      ProgressHud.hide();
    });
    // _validateInputs();
    // navigationVoterIDUploadPage();
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // If the form is valid, make API request

      ConnectionStatus().checkInternetStatus().then((internet) {
        if (internet != null && internet) {
          // Internet Present Case
          if (imageFile != null) {
            executeRegistrationRequest(
                "Wait Registration ...",
                APIConstant.baseURL + APIConstant.registration,
                psCodeTextEditingController.text.toString(),
                voterIDTextEditingController.text.toString(),
                dateVoterDOB.toString(),
                genderId.toString(),
                imageFile);
          } else {
            toastAlert.toastMessages(UIHelper.chooseImage);
          }
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


  //---
  Widget _votersIDImageWidget() {
    return Card(
      margin: EdgeInsets.all(12),
      color: UIHelper.colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          imageFile != null
              ?
              //_imageView(),
              Image.file(
                  imageFile,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                )
              : new Container(),
          new Center(
            child: Card(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // _onAddImageClick(index);
                  print("kkk");
                  _showVoteImageUploadDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Display date picker.
  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('Confirm', style: TextStyle(color: Colors.red)),
        cancel: Text('Cancel', style: TextStyle(color: Colors.cyan)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );

    setState(() {
      dateVoterDOB =
          '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}';
    });
  }

//-- dialog
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

  //-- gallery
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    this.setState(() {
      imageFile = picture;
    });

    Navigator.of(context).pop();
  }

  // -- camera

  void _openCamera(BuildContext context) async {
    var camPicture = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    this.setState(() {
      imageFile = camPicture;
    });

    Navigator.of(context).pop();
  }

//---  async request

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

    registrationAsyncRequest(requestURL, authModel).then((result) async {
      if (result.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "200") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });
        // _validateInputs();
        //navigationVoterIDUploadPage();

        navigateToVerificationScreen();
      } else {
        // Toast response
        //toastAlert.toastMessages(authModel.getStatusMessage);
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });

      }
    });
  }

  /*then((value) {
      // hide progress bar

      if (value.toString().replaceAll(new RegExp(r'[^\w\s]+'), '') == "true") {
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();
        });
        // _validateInputs();
        //navigationVoterIDUploadPage();

        navigateToVotingScreen();
      } else {
        // Toast response
        //toastAlert.toastMessages(authModel.getStatusMessage);
        Future.delayed(Duration(milliseconds: 2000)).then((val) {
          ProgressHud.hide();


        });
      }
    });*/

  // --navigation route

  void navigateToVerificationScreen() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }
}
