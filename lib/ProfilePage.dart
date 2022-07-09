import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:public_emergency_system_agents/Models/GetProfileData.dart';

import 'helpers.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  String caseName = "Loading";
  String startedAt = "Loading";
  String caseNote = "Loading";
  int phone = 0;

  Future<String> CaseNoteData() async {
    return Future.delayed(const Duration(seconds: 3), () => caseNote);
  }

  Future<String> CaseNameData() async {
    return Future.delayed(const Duration(seconds: 3), () => caseName);
  }

  Future<String> CaseStartedAtData() async {
    return Future.delayed(const Duration(seconds: 3), () => startedAt);
  }
    Future<String> Agentsurname() async {
    return Future.delayed(const Duration(seconds: 3), () => startedAt);
  }
    Future<String> AgentPhone() async {
    return Future.delayed(const Duration(seconds: 3), () => startedAt);
  }

  void fetch() async {
    int counter = 0;
    print("api çalışışıyor");
    final response = await get(Uri.parse(
        "https://public-emergency-systemapi.azurewebsites.net/GetData/AgentInfo?email=" +
            APIcaller.email+"&password="+APIcaller.password));
    print("api çalıştı");
    if (response.statusCode == 200) {
      var result = getProfileDataFromJson(response.body);
      caseName = result[0].agentEmail;
      startedAt = result[0].agentName;
      caseNote = result[0].agentSurname;
      phone = result[0].agentPhone;
    } else if (response.statusCode != 200) {
      print("status kodu 200 dönmedi!");
      print("dönen kod:" + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Information"),
        elevation: 0,
        backgroundColor: Colors.orange[800],
      ),
      body: FutureBuilder(
        future:
            Future.wait([CaseNameData(), CaseNoteData(), CaseStartedAtData()]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 50),
                  child: Column(
                    children: [
                      Text("$caseName",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 0,
                      ),
                      Text(
                        "$startedAt",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text("$startedAt"),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: <Widget>[
                        Container(
                          width: 0,
                        ),
                        Flexible(child: Text("$caseNote"))
                      ]),
                    ],
                  ),
                )
              ],
            ));
          } else {
            return Center(
                child: Text("loading...",
                    style: TextStyle(fontSize: 25, color: Colors.red)));
          }
        },
      ),
    );
  }
}
