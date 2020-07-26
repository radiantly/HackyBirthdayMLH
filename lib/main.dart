import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

import './form.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

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
      home: Builder(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('HackShare'),
                  backgroundColor: Colors.lightGreen,
                ),
                body: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 3.0,
                  ),
                ),
                floatingActionButton: SharePostButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              )),
    );
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
