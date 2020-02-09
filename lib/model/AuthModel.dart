import 'dart:io';

class AuthModel {
  // --
  AuthModel({this.voterIDNumber, this.voterPSCode});

  String voterIDNumber;
  String voterPSCode;
  String voterAge;
  String voterDOB;
  String voterSex;
  int statusCode;
  String statusMessage;
  File voterCardImage;
  bool successStatus;

  //--

  void setVoterIDNumber(String voterID) {
    voterIDNumber = voterID;
  }

  //--
  void setVoterPSCode(String psCode) {
    voterPSCode = psCode;
  }

  //--
  void setVoterSex(String sex) {
    voterSex = sex;
  }

  //--

  void setVoterAge(String age) {
    voterAge = age;
  }

//--
  void setVoterDOB(String dob) {
    voterDOB = dob;
  }

  //--
  void setStatusCode(int code) {
    statusCode = code;
  }

  //--
  void setStatusMessage(String message) {
    statusMessage = message;
  }

  //--

  //--
  void setSuccessStatus(bool code) {
    successStatus = code;
  }

  //---

  void setVoterCardImage(File voterCard) {
    voterCardImage = voterCard;
  }

  // --
  String get getVoterIDNumber => voterIDNumber;

  String get getVoterPSCode => voterPSCode;

  String get getVoterSex => voterSex;

  String get getVoterAge => voterAge;

  String get getVoterDOB => voterDOB;

  //--

  int get getStatusCode => statusCode;

  String get getStatusMessage => statusMessage;

  bool get getSuccessStatus => successStatus;

  //--
  File get getVoterCardImage => voterCardImage;
}
