import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:election_gh/model/AuthModel.dart';
import 'package:election_gh/model/CandidateVotingModel.dart';
import 'package:election_gh/model/CandidatesModel.dart';
import 'package:election_gh/services/api_constants.dart';
import 'package:election_gh/storage/PreferenceStorage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'Globals.dart' as global;

Future<List> verificationAsyncRequest(
    String requestHttpURL, AuthModel authModel) async {
  final response = await http.post(requestHttpURL, body: {
    "polling_station_code": authModel.getVoterPSCode,
    "password": authModel.getVoterIDNumber,
  });

  //--
  final data = jsonDecode(response.body);
  bool statusCode = data['success'];
  String statusMessage = data['message'];

  authModel.setSuccessStatus(statusCode);
  authModel.setStatusMessage(statusMessage);

  // -- return code

  authModel.setStatusCode(response.statusCode);
  authModel.setStatusMessage(statusMessage.toString());

  // --
  if (statusCode == true) {
    try {
      //String token = data['data']['token'];
      int userID = data['data']['id'];

      // --
      saveVoterIDPreference(userID ?? 0);

      return [statusCode];
    } catch (e) {
      return [statusCode];
    }
  }
  return [statusCode];
}

//-- fetch Candidate

Future<List<Candidate>> fetchRecentCandidateRequest() async {
  http.Response response =
      await http.get(APIConstant.baseURL + APIConstant.candidate);
  List<Candidate> list;
  try {
    var responseJson = json.decode(response.body);

    // -- Check for no data

    var rest = responseJson["data"] as List;
    list = rest.map<Candidate>((json) => Candidate.fromJson(json)).toList();

    // global.notFound = list.length;
    global.statusCode = response.statusCode;
    global.notFound = list.length;

    // -- success
    return (responseJson['data'] as List)
        .map((p) => Candidate.fromJson(p))
        .toList();
  } catch (e) {
    print("Error: Getting assign request Error" + e.toString());
  }

  return [];
}

Future<List<Candidate>> fetchRecentCandidateRequest2() async {
  http.Response response =
      await http.get(APIConstant.baseURL + APIConstant.candidate);

  List<CandidatesModel> list;
  try {
    var responseJson = json.decode(response.body);

    //final data = jsonDecode(response.body);
    //String statusCode = responseJson['success'];
    global.statusCode = response.statusCode;

    // -- Check for no data

    var payload = responseJson["data"] as List;
    list = payload
        .map<CandidatesModel>((json) => CandidatesModel.fromJson(json))
        .toList();

    global.notFound = list.length;

    // print("Candidate " + response.body);

    if (response.statusCode == 200) {
      return (responseJson['data'] as List)
          .map((p) => Candidate.fromJson(p))
          .toList();
    } else {
      return null;
    }
  } catch (e) {}

  return [];
}

//-- candidate

Future<List> candidateVotingAsyncRequest(
    String requestHttpURL, CandidateVotingModel candidateVotingModel) async {
  final response = await http.post(requestHttpURL, body: {
    "voter_id": candidateVotingModel.getVoterIDNumber,
    "candidate_id": candidateVotingModel.getCandidateID,
  });

  //--
  final data = jsonDecode(response.body);
  int statusCode = data['code'];
  String statusMessage = data['message'];

  candidateVotingModel.setStatusCode(statusCode);
  candidateVotingModel.setStatusMessage(statusMessage);

  // -- return code

  //candidateVotingModel.setStatusCode(response.statusCode);
  //candidateVotingModel.setStatusMessage(response.statusCode.toString());

  // --
  if (statusCode >= 200) {
    try {
      return [response.statusCode];
    } catch (e) {
      print("Error " + e);

      return [];
    }
  }
  return [];
}

//--  user registration
registrationAsyncRequest(String requestHttpURL, AuthModel authModel) async {
  var stream = new http.ByteStream(
      DelegatingStream.typed(authModel.getVoterCardImage.openRead()));
  var length = await authModel.getVoterCardImage.length();

  var uri = Uri.parse(requestHttpURL);

  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile(
      'voters_id_image_url', stream, length,
      filename: basename(authModel.getVoterCardImage.path));
  request.fields["polling_station_code"] = authModel.getVoterPSCode;
  request.fields["voters_id"] = authModel.getVoterIDNumber;
  request.fields["sex"] = authModel.voterSex;
  request.fields["date_of_birth"] = authModel.getVoterDOB;
  //create multipart using filepath, string or bytes
  //contentType: new MediaType('image', 'png'));

  request.files.add(multipartFile);
  var response = await request.send();

  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });

  return [response.statusCode];
}
