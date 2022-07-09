import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:public_emergency_system_agents/Models/GetActiveCases.dart';
import 'package:public_emergency_system_agents/helpers.dart';
import 'package:public_emergency_system_agents/reportDetails.dart';
import 'package:shimmer/shimmer.dart';

class activeReports extends StatefulWidget {
  const activeReports({Key? key}) : super(key: key);

  @override
  State<activeReports> createState() => _activeReportsState();
}

ScrollController _scrollController = new ScrollController();
final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

var datas = [];
var caseid = [];
var restorants;
var result;
GetActiveCases? _activeCases;

class _activeReportsState extends State<activeReports> {
  void fetch() async {
    int counter = 0;
    print("api çalışışıyor");
    final response = await get(Uri.parse(
        "https://public-emergency-systemapi.azurewebsites.net/GetData/AgentActiveCase"));
    print("api çalıştı");
    if (response.statusCode == 200) {
      var result = getActiveCasesFromJson(response.body);
      int counter = result.length;
      print(counter); //kaç tane aktif vakanın açık olduğunu gösterir.
      for (int a = 0; a < counter / 2; a++) {
        datas.add(result[a].caseKind);
        caseid.add(result[a].caseId);

        counter++;
      }
    } else if (response.statusCode != 200) {
      print("status kodu 200 dönmedi!");
      print("dönen kod:" + response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("sayfa sonu");
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "Active Reports",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.orange[800],
            ),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              child: delayedlist(),
              key: _refreshIndicatorKey,
              onRefresh: () async {
                fetch();
                print("the screen has refreshed");
              },
            ))
        );
  }
}

class shimmerlayout extends StatelessWidget {
  const shimmerlayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            offset += 5;
            time = 800 + offset;

            print(time);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey,
                child: shimmerList(),
                period: Duration(milliseconds: time),
              ),
            );
          }),
    );
  }
}

class delayedlist extends StatefulWidget {
  const delayedlist({Key? key}) : super(key: key);

  @override
  State<delayedlist> createState() => _delayedlistState();
}

class _delayedlistState extends State<delayedlist> {
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isloading = false;
      });
    });

    return isloading ? shimmerList() : datalist(timer);
  }
}

class datalist extends StatelessWidget {
  final Timer timer;

  datalist(this.timer);

  @override
  Widget build(BuildContext context) {
    timer.cancel();

    return Container(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(datas[index]),
                    onTap: () {
                      APIcaller.caseid = caseid[index].toString();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  reportDetails()));
                    },
                  );
                }))));
  }
}

class shimmerList extends StatelessWidget {
  const shimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 390;
    double height = 50;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 7.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: height,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ));
  }
}
