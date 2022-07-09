import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:public_emergency_system_agents/ReportSummaryPage.dart';
import 'package:public_emergency_system_agents/helpers.dart';

class getDirectionScreen extends StatefulWidget {
  const getDirectionScreen({Key? key}) : super(key: key);
  @override
  State<getDirectionScreen> createState() => _getDirectionScreenState();
}

class _getDirectionScreenState extends State<getDirectionScreen> {
  GoogleMapController? _ccontroller;
  static double lat =APIcaller.lat;
  static double long = APIcaller.lon;

  Location currentLocation = Location();
  Set<Marker> _markers = {};



  static final CameraPosition camerapos =
      CameraPosition(target: LatLng(lat, long), zoom: 15);

  static final Marker _googlemarker = Marker(
      markerId: MarkerId("Location"),
      infoWindow: InfoWindow(title: "Case Here!"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat, long));




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text("Where Is Location?"),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        markers: {_googlemarker},

        onTap: (pos) {
          print(pos);
          Marker f = Marker(
              markerId: MarkerId('1'),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(
                  pos.latitude, pos.longitude 
                  ));

          setState(() {
            _markers.add(f);
            lat = pos.latitude;
            long = pos.longitude;
          });
        },
        initialCameraPosition: camerapos, //Starting point of map
        onMapCreated: (GoogleMapController controller) {
          _ccontroller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GetLoc(lat, long);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReportNow()));
        },

        icon: Icon(Icons.description),
        label: Text("Accept Case!"),

        backgroundColor: Colors.orange[800],
      ),
    );
  }

  GetLoc(double lat, double long) {
    print(lat);
    print(long);

    print("location got successfully");
  }
}
