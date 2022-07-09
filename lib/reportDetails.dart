import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:public_emergency_system_agents/Models/GetCaseDetails.dart';
import 'package:public_emergency_system_agents/ReportSummaryPage.dart';
import 'package:public_emergency_system_agents/getDirectionsPage.dart';
import 'package:public_emergency_system_agents/helpers.dart';

class reportDetails extends StatefulWidget {
  const reportDetails({Key? key}) : super(key: key);

  @override
  State<reportDetails> createState() => _reportDetailsState();
}

String caseName = "Loading";
String startedAt = "Loading";
String caseNote = "Loading";
double loc_lon = 0;
double loc_lat = 0;

Future<String> CaseNoteData() async {
  return Future.delayed(const Duration(seconds: 3), () => caseNote);
}

Future<String> CaseNameData() async {
  return Future.delayed(const Duration(seconds: 3), () => caseName);
}

Future<String> CaseStartedAtData() async {
  return Future.delayed(const Duration(seconds: 3), () => startedAt);
}

void fetch() async {
  int counter = 0;
  print("api çalışışıyor");
  final response = await get(Uri.parse(
      "https://public-emergency-systemapi.azurewebsites.net/GetData/caseDetails?caseid=" +
          APIcaller.caseid.toString()));
  print("api çalıştı");
  if (response.statusCode == 200) {
    var result = getCaseDetailsFromJson(response.body);
    caseName = result[0].caseKind;
    startedAt = result[0].caseStartedAt.toString();
    caseNote = result[0].caseTextNote;
    loc_lat = double.parse(result[0].caseLocationLat);
    loc_lon = double. parse(result[0].caseLocationLon);
  } else if (response.statusCode != 200) {
    print("status kodu 200 dönmedi!");
    print("dönen kod:" + response.statusCode.toString());
  }
}

class _reportDetailsState extends State<reportDetails> {
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
        title: Text("Report Detail"),
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
                      Text("by userX"),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Un- Handled",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            "1865465_IMG.JPG",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.download),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "186665_IMG.JPG",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.download),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "1131332.MP",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.download),
                        ],
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Center(
                                child: FloatingActionButton.extended(
                                  onPressed: () {
                                    APIcaller.lat =loc_lat;
                                    APIcaller.lon = loc_lon;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                getDirectionScreen())));
                                  },
                                  icon: Icon(Icons.directions),
                                  label: Text("Get Directions"),
                                  backgroundColor: Colors.orange[800],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => ReportNow())));
                            },
                            child: Text("Accept Case"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange[800],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10)),
                          )
                        ],
                      )
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
