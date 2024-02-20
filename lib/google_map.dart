import 'dart:async';

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
      List<Marker> _manyMarker=[];
      List<Polyline>_polylines=[];
      List<Circle> _manyCircle=[];
      List<LatLng> _points = [];


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Marker _marker = Marker(markerId: MarkerId('Marker 1'),
        
        
        draggable: true
  );

  static final Circle _circle = Circle(
    circleId: CircleId('Circle 1'),
    radius: 250,
    strokeColor: Colors.red,
    strokeWidth: 2,
    center: LatLng(37.43296265331129, -122.08832357078792),
    fillColor: Colors.redAccent.withOpacity(0.1)
  );

  static final Polyline _polyline = Polyline(polylineId: PolylineId('polyline 1'),
    points: const[
LatLng(37.40339238861385, -122.0810816064477),
LatLng(37.427931249680974, -122.081070877),
LatLng(36.427931249680974, -121.081070877)
    ],
color:Colors.red,
width: 5
  );

  static final Polygon _polygon = Polygon(polygonId: PolygonId('Polygon1'),
  points:[
    LatLng(37.427962452423, -122.08574942524),LatLng(37.432966423, -122.088562524),LatLng(37.433, -122.08542524) 
  ],
  fillColor: Colors.transparent,
  strokeColor: Colors.red,
  strokeWidth: 2,
  );

  @override
  Widget build(BuildContext context) {
    print(_manyMarker);

   Polyline manypolyline = Polyline(polylineId: PolylineId('polyline 1'),
    points:_points,
color:Colors.red,
width: 5
  );
  Polygon _manypolygon = Polygon(polygonId: PolygonId('Polygon1'),
  points:_points,
  fillColor: Colors.transparent,
  strokeColor: Colors.red,
  strokeWidth: 2,
  );
    return Scaffold(
      body: GoogleMap(
       // polygons: {_manypolygon},
       // polylines: {manypolyline},
        circles: Set<Circle>.from(_manyCircle),
        markers: Set<Marker>.from(_manyMarker),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        },
        onTap: (position) async{
          setState(() {

            _points.add(LatLng(position.latitude, position.longitude));
              _manyMarker.add(Marker(markerId: MarkerId('Marker ${_manyMarker.length}'),
        position:  LatLng(position.latitude,position.longitude),
        infoWindow: InfoWindow(title: 'GOOGLE PLEX ${_manyMarker.length}',snippet: 'Latitude is ${position.latitude}, longitude iS ${position.longitude} '),
        draggable: true
              ));
        _manyCircle.add(Circle(
    circleId: CircleId('Circle ${_manyCircle.length}'),
    radius: 250,
    strokeColor: Colors.red,
    strokeWidth: 2,
    center: LatLng(position.latitude,position.longitude),
    fillColor: Colors.redAccent.withOpacity(0.1) 
    ));

          });
          
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}