import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';

import './form.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  static final markerId = MarkerId("test");
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  static final aMarker = Marker(
      markerId: markerId,
      position: _center,
      infoWindow: InfoWindow(
          title: "Imagine winning a hackathon",
          snippet: 'Using a framework you started learning two days back'));
  // markers.addAll({markerId: aMarker});

  var markers = <MarkerId, Marker>{markerId: aMarker};
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.lightGreen,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.lightGreen),
              hintStyle: TextStyle(color: Colors.grey),
            )),
        home: Scaffold(
          appBar: AppBar(
            title: Text('HackShare'),
            backgroundColor: Colors.lightGreen,
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('hacks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text("Loading..."),
                  );

                var markers = <MarkerId, Marker>{};

                for (var i = 0; i < snapshot.data.documents.length; i++) {
                  var document = snapshot.data.documents[i];
                  final markerId = MarkerId(document["title"]);
                  final LatLng pos = LatLng(document["Lat"], document["Lon"]);
                  final aMarker = Marker(
                      markerId: markerId,
                      position: pos,
                      infoWindow: InfoWindow(
                          title: document["title"], snippet: document["post"]));
                  markers[markerId] = aMarker;
                }

                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 3.0,
                  ),
                  markers: Set<Marker>.of(markers.values),
                );
              }),
          floatingActionButton: SharePostButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class SharePostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Share your hack!"),
              backgroundColor: Colors.lightGreen,
            ),
            body: Container(child: ShareForm()));
      }));
    }

    return FloatingActionButton(
      onPressed: _pushSaved,
      tooltip: "Share a hack!",
      child: Icon(Icons.add),
      backgroundColor: Colors.lightGreen,
    );
  }
}
