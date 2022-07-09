import 'package:flutter/material.dart';
import 'package:public_emergency_system_agents/ActiveReportsPage.dart';
import 'package:public_emergency_system_agents/ProfilePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

int currentIndex =0;
final screens= [activeReports()];

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         
          body: IndexedStack(index:currentIndex,children: screens,),    // gets the content from 'screens' list
          bottomNavigationBar: BottomNavigationBar(                       //bottom navigation bar that helps to change pages
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.orange[800],
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
              currentIndex: currentIndex,
              onTap: (index) => setState(()            
              =>currentIndex = index),
              items: [            //navigation bar daki itemlar ve tanımları
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '  Active \n Reports',
                    backgroundColor: Colors.orange[800]),

                 BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '\nProfile',
                    backgroundColor: Colors.orange[400]),
              ] )),
    );

  }
}
