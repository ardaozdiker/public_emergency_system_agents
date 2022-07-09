import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:public_emergency_system_agents/homePage.dart';

import 'ActiveReportsPage.dart';

class ReportNow extends StatefulWidget {
  const ReportNow({Key? key}) : super(key: key);

  @override
  _ReportNowState createState() => _ReportNowState();
}

class _ReportNowState extends State<ReportNow> {
  String loadeddatatext = "";
  bool switchvalue = false;
  List<PlatformFile> _files = [];
  String dropdownvalue = "Accident";
  String LoadedData = "";
  String LoadedDataPic = "";
  String loadeddatatextPic = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text("REPORT RESULT"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Accident",
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
              "04/04/2022 14:00",
              style: TextStyle(color: Colors.grey),
            ),
            Text("Report by Arda Özdiker"),
            SizedBox(
              height: 15,
            ),
            Text("upload an evidance",style: TextStyle(fontSize: 18,),),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: ElevatedButton(
                  child: Text("upload a Video "),
                  onPressed: () {
                    fileExplorerVideo();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[900]))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: ElevatedButton(
                  child: Text("upload a Photo "),
                  onPressed: () {
                    fileExplorerPic();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[900]))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: ElevatedButton(
                  child: Text("upload a Sound "),
                  onPressed: () {
                    fileExplorersound();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[900]))),
            ),
            Row(
              children: [
                SizedBox(),
                Center(child: Text(loadeddatatext)),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(loadeddatatextPic),
                ) //shows te uploaded files name
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CupertinoSwitch(
                  value: switchvalue,
                  onChanged: (value) {
                    setState(() {
                      switchvalue = value;
                    });
                  },
                ),

                Text("  Is someone got hurt?  (Green is yes!)")
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "  Bring summary (Why is it happened?)",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
                //   controller:
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(60),
                        child: ElevatedButton(
                          child: Text(
                            "SEND RESULT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                         Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                activeReports())));
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.orange))),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orange[900])),
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }

  void fileExplorerVideo() async {
    //helps to take video file from users device
    _files = (await FilePicker.platform.pickFiles(
            type: FileType.video,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    LoadedData = _files[0].toString();
    LoadedData = LoadedData.trim();
    LoadedData = LoadedData.substring(0, LoadedData.indexOf("name"));
    print(LoadedData);
    LoadedData = LoadedData.substring(LoadedData.lastIndexOf("/") + 1);
    //  LoadedData= LoadedData.substring(LoadedData.lastIndexOf("bytes"));
    print(LoadedData);
    print("file uploaded successfully");

    setState(() {
      loadeddatatext = LoadedData;
    });
  }

  void fileExplorerPic() async {
    //helps to take Picture file from users device
    _files = (await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    LoadedDataPic = _files[0].toString();
    LoadedDataPic = LoadedDataPic.trim();
    LoadedDataPic = LoadedDataPic.substring(0, LoadedDataPic.indexOf("name"));
    print(LoadedDataPic);
    LoadedDataPic = LoadedDataPic.substring(LoadedDataPic.lastIndexOf("/") + 1);
    //  LoadedData= LoadedData.substring(LoadedData.lastIndexOf("bytes"));
    print(LoadedDataPic);
    print("file uploaded successfully");

    setState(() {
      loadeddatatextPic = LoadedDataPic;
    });
  }

  void fileExplorersound() async {
    //helps to take Picture file from users device
    _files = (await FilePicker.platform.pickFiles(
            type: FileType.audio,
            allowMultiple: false,
            allowedExtensions: null))!
        .files;
    LoadedData = _files[0].toString();
    LoadedData = LoadedData.trim();
    LoadedData = LoadedData.substring(0, LoadedData.indexOf("name"));
    print(LoadedData);
    LoadedData = LoadedData.substring(LoadedData.lastIndexOf("/") + 1);
    //  LoadedData= LoadedData.substring(LoadedData.lastIndexOf("bytes"));
    print(LoadedData);
    print("file uploaded successfully");

    setState(() {
      loadeddatatext = LoadedData;
    });
  }
}
