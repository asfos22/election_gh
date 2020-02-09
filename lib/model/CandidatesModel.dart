import 'dart:convert';

class CandidatesModel {
  final bool success;
  final List<Candidate> data;
  final String message;

  CandidatesModel({
    this.success,
    this.data,
    this.message,
  });

  factory CandidatesModel.fromRawJson(String str) =>
      CandidatesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CandidatesModel.fromJson(Map<String, dynamic> json) =>
      CandidatesModel(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Candidate>.from(
                json["data"].map((x) => Candidate.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
      };
}

class Candidate {
  final int id;
  final String candidateName;
  final String candidateImageUrl;
  final String partyName;
  final String partyImageUrl;

  Candidate({
    this.id,
    this.candidateName,
    this.candidateImageUrl,
    this.partyName,
    this.partyImageUrl,
  });

  factory Candidate.fromRawJson(String str) =>
      Candidate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["id"] == null ? null : json["id"],
        candidateName:
            json["candidate_name"] == null ? null : json["candidate_name"],
        candidateImageUrl: json["candidate_image_url"] == null
            ? null
            : json["candidate_image_url"],
        partyName: json["party_name"] == null ? null : json["party_name"],
        partyImageUrl:
            json["party_image_url"] == null ? null : json["party_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "candidate_name": candidateName == null ? null : candidateName,
        "candidate_image_url":
            candidateImageUrl == null ? null : candidateImageUrl,
        "party_name": partyName == null ? null : partyName,
        "party_image_url": partyImageUrl == null ? null : partyImageUrl,
      };
}
