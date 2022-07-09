// To parse this JSON data, do
//
//     final getProfileData = getProfileDataFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<GetProfileData> getProfileDataFromJson(String str) => List<GetProfileData>.from(json.decode(str).map((x) => GetProfileData.fromJson(x)));

String getProfileDataToJson(List<GetProfileData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProfileData {
    GetProfileData({
      required  this.agentId,
      required  this.agentPassword,
      required  this.agentName,
      required  this.agentSurname,
      required  this.agentEmail,
      required  this.agentPhone,
      required  this.roles,
      required  this.verification,
      required  this.agentDepartment,
    });

    final int agentId;
    final String agentPassword;
    final String agentName;
    final String agentSurname;
    final String agentEmail;
    final int agentPhone;
    final String roles;
    final String verification;
    final String agentDepartment;

    factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
        agentId: json["Agent_Id"],
        agentPassword: json["Agent_Password"],
        agentName: json["Agent_Name"],
        agentSurname: json["Agent_Surname"],
        agentEmail: json["Agent_Email"],
        agentPhone: json["Agent_Phone"],
        roles: json["Roles"],
        verification: json["Verification"],
        agentDepartment: json["Agent_Department"],
    );

    Map<String, dynamic> toJson() => {
        "Agent_Id": agentId,
        "Agent_Password": agentPassword,
        "Agent_Name": agentName,
        "Agent_Surname": agentSurname,
        "Agent_Email": agentEmail,
        "Agent_Phone": agentPhone,
        "Roles": roles,
        "Verification": verification,
        "Agent_Department": agentDepartment,
    };
}
