import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:public_emergency_system_agents/ActiveReportsPage.dart';
import 'package:public_emergency_system_agents/helpers.dart';
import 'package:public_emergency_system_agents/homePage.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
 String sonuc="";
void fetch(String email, String passcode) async {
  String link ="https://public-emergency-systemapi.azurewebsites.net/getdata/LoginControl?email="+email+"&password="+passcode;
  print(link);
  int counter = 0;
  print("api çalışışıyor");
  final response = await get(Uri.parse(
      link));
  print("api çalıştı");
  if (response.statusCode == 200) {
    print(response.body);
    var result = response.body;
   sonuc = result.toString();
    print("resultun sonucu");
    print(result);

  } else if (response.statusCode != 200) {
    print("status kodu 200 dönmedi!");
    print("dönen kod:" + response.statusCode.toString());
  }
}

class HomePage extends StatelessWidget {
  int gecis = 0;
  final TextEditingController emailCon = new TextEditingController();
  final TextEditingController passwordCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900]!,
          Colors.orange[800]!,
          Colors.orange[400]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Emergency Cyprus Agents",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: emailCon,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  controller: passwordCon,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                            ),
                            Builder(builder: (context) {
                              return Center(
                                child: TextButton(
                                  child: Text("Forgot Password?"),
                                  style: TextButton.styleFrom(
                                      primary: Colors.grey),
                                  onPressed: () {
                                    // ekran açılacak tekrar şifre için OTP ile onaylanacak.
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(60),
                              child: ElevatedButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                HomeScreen())));
                                  if (passwordCon.text.isNotEmpty ||
                                      emailCon.text.isNotEmpty) {
                                    /*      if (gecis == 1) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserScreen()));
                                      } */
                                   // fetch(emailCon.text,passwordCon.text);

                                    if(sonuc == "1"){
                                      APIcaller.email=emailCon.text;
                                      APIcaller.password=passwordCon.text;


                                      print("tamamdir");

                                    }
                                    else{
                                      print("kullanıcı adı veya şifre yalnis");
                                    }

                                  } else {
                                    print("Eksik bilgi var");
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: BorderSide(
                                                color: Colors.orange))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange[900])),
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signin() async {
    if (emailCon.text.isNotEmpty && passwordCon.text.isNotEmpty) {
      /*    AuthService()
          .signInWithEmail(emailCon.text, passwordCon.text)
          .then((value) {
        gecis = 1;
        print("geçiş başarılı");
      }).catchError((Error) {
        if (Error.toString().contains("wrong-password")) {
          print("şifre yalnış");
        }
        print(Error);
      }); */
    }
  }
}
