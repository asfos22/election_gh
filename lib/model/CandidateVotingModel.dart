class CandidateVotingModel {
  // --
  CandidateVotingModel({this.voterIDNumber, this.candidateID});

  String voterIDNumber;
  String candidateID;
  int statusCode;
  String statusMessage;

  //--

  void setVoterIDNumber(String voterID) {
    voterIDNumber = voterID;
  }

  //--
  void setCandidateID(String partyCandidateID) {
    candidateID = partyCandidateID;
  }

  //--
  void setStatusCode(int code) {
    statusCode = code;
  }

  //--
  void setStatusMessage(String message) {
    statusMessage = message;
  }

  // --
  String get getVoterIDNumber => voterIDNumber;

  String get getCandidateID => candidateID;

  //--

  int get getStatusCode => statusCode;

  String get getStatusMessage => statusMessage;
}
