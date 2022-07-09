// To parse this JSON data, do
//
//     final getActiveCases = getActiveCasesFromJson(jsonString);

import 'dart:convert';

List<GetActiveCases> getActiveCasesFromJson(String str) => List<GetActiveCases>.from(json.decode(str).map((x) => GetActiveCases.fromJson(x)));

String getActiveCasesToJson(List<GetActiveCases> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetActiveCases {
    GetActiveCases({
     required this.caseId,
    required    this.caseKind,
      required  this.caseLocationLat,
      required  this.caseLocationLon,
    required    this.caseStartedAt,
     required   this.caseEndedAt,
    required    this.caseTextNote,
   required     this.caseUserReportedId,
     required   this.caseAssignedGroupId,
      required  this.caseStatus,
      required  this.caseOperatorId,
      required  this.caseAssignedAt,
    });

    final int caseId;
    final String caseKind;
    final String caseLocationLat;
    final String caseLocationLon;
    final DateTime caseStartedAt;
    final DateTime caseEndedAt;
    final String caseTextNote;
    final int caseUserReportedId;
    final int caseAssignedGroupId;
    final String caseStatus;
    final int caseOperatorId;
    final DateTime caseAssignedAt;

    factory GetActiveCases.fromJson(Map<String, dynamic> json) => GetActiveCases(
        caseId: json["Case_Id"],
        caseKind: json["Case_Kind"],
        caseLocationLat: json["Case_Location_lat"],
        caseLocationLon: json["Case_Location_lon"],

        caseStartedAt: DateTime.parse(json["Case_Started_at"]),
        caseEndedAt: DateTime.parse(json["Case_Ended_at"]),
        caseTextNote: json["Case_TextNote"],
        caseUserReportedId: json["Case_UserReportedId"],
        caseAssignedGroupId: json["Case_AssignedGroupId"],
        caseStatus: json["Case_Status"],
        caseOperatorId: json["Case_OperatorId"],
        caseAssignedAt: DateTime.parse(json["Case_Assigned_at"]),
    );

    Map<String, dynamic> toJson() => {
        "Case_Id": caseId,
        "Case_Kind": caseKind,
        "Case_Location_lat": caseLocationLat,
        "Case_Location_lon": caseLocationLon,
        "Case_Started_at": caseStartedAt.toIso8601String(),
        "Case_Ended_at": caseEndedAt.toIso8601String(),
        "Case_TextNote": caseTextNote,
        "Case_UserReportedId": caseUserReportedId,
        "Case_AssignedGroupId": caseAssignedGroupId,
        "Case_Status": caseStatus,
        "Case_OperatorId": caseOperatorId,
        "Case_Assigned_at": caseAssignedAt.toIso8601String(),
    };
}
