import 'dart:async';

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


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


  


  static const CameraPosition _kGooglePlex = 

  CameraPosition(
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
    fillColor: Colors.redAccent.withOpacity(0.0)
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

  void _addmarker (LatLng markerpoints) {
 setState(() {

              
              _manyMarker.add(Marker(markerId: MarkerId('Marker ${_manyMarker.length}'),
        position:  LatLng(markerpoints.latitude,markerpoints.longitude),
        infoWindow: InfoWindow(title: 'GOOGLE PLEX ${_manyMarker.length}',snippet: 'Latitude is ${markerpoints.latitude}, longitude iS ${markerpoints.longitude} '),
        draggable: true
              ));
 });

  }

  Future<Position> getCurrentPosition() async{


 bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();



 }
Future<void> _goCurrentPosition(double statLat,double statlng) async{

  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    zoom: 15,
    target: LatLng(statLat,statlng))));
  _addmarker(LatLng( statLat, statlng));
}

Future<LatLng> _goCurrentPosition1() async {
   Position currentPosition = await getCurrentPosition();
    try {
      Position currentPosition = await getCurrentPosition();
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15,
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
          ),
        ),
      );
      _addmarker(LatLng(currentPosition.latitude, currentPosition.longitude));
     // _points.add(LatLng(currentPosition.latitude, currentPosition.longitude));
    } catch (e) {
      print('Error getting current position: $e');
    }
    
    return  LatLng(currentPosition.latitude, currentPosition.longitude);
}

 @override
  void initState() {
    super.initState();
  
  _goCurrentPosition1();
  _getCurrentLocation();
   
  }
   
  void _getCurrentLocation() async {
  try {
    Position currentPosition = await getCurrentPosition();
    setState(() {
      _goCurrentPosition(currentPosition.latitude, currentPosition.longitude);
      _points.add(LatLng(currentPosition.latitude, currentPosition.longitude));
    });
  } catch (e) {
    print('Error getting current location: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    
    // _goCurrentPosition1();
  print(_points);
bool na;
  if(_points.isNotEmpty)
  {
    na = true;
  }else{
    na= false;
  }

   Polyline manypolyline = Polyline(polylineId: PolylineId('polyline 1'),
    points: _points,
  color:Colors.red,
width: 5
  );
  Polygon manypolygon = Polygon(polygonId: PolygonId('Polygon ${_points.length}'),
  points:_points,
  fillColor: Colors.transparent,
  strokeColor: Colors.red,
  strokeWidth: 2,
  );


  Polygon manynotpolygon = Polygon(polygonId: PolygonId('Polygon ${_points.length}'),
  points:[LatLng(37.4219985, -122.0839999)],
  fillColor: Colors.transparent,
  strokeColor: Colors.red,
  strokeWidth: 2,
  );
    return Scaffold(
      body: GoogleMap(
     polygons: na ?{manypolygon} :{manynotpolygon} ,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
           Position CurrentPosition = await getCurrentPosition();
           _goCurrentPosition(CurrentPosition.latitude, CurrentPosition.longitude);
        },
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}