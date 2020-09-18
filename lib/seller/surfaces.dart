import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class Surfaces extends StatefulWidget {
  @override
  State<Surfaces> createState() => SurfacesState();
}

class SurfacesState extends State<Surfaces> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  List<LatLng> polyPoints = [];
  Location myLocation;


  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  _onTapMarkerAdd(LatLng latLng) {
    setState(() {
      polyPoints.add(latLng);
      _drawPolygon(polyPoints);
      _markers.add(
        Marker(
          draggable: true,
          markerId: MarkerId(latLng.toString()),
          position: latLng,
          infoWindow: InfoWindow(title: 'Point repère', snippet: 'Ceci est une balise'),
          icon: BitmapDescriptor.defaultMarker,
          onDragEnd: (LatLng latLng) {
            print(latLng);
            print(latLng.toString());
          },
        ),
      );
    });
  }

  _clearAllMarkers() {
    setState(() {
      _markers.clear();
      _polygons.clear();
      polyPoints.clear();
    });
  }

  _drawPolygon(List<LatLng> listLatLng) {
    setState(() {
      _polygons.add(Polygon(
          polygonId: PolygonId('123'),
          points: listLatLng,
          fillColor: Colors.transparent,
          strokeColor: Colors.lightBlueAccent));
    });
  }

  _calculateArea() {
    polyPoints.add(polyPoints[0]);
    print(calculatePolygonArea(polyPoints));
    Fluttertoast.showToast(
        msg: calculatePolygonArea(polyPoints).toString() +
            " m²",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static double calculatePolygonArea(List coordinates) {
    double area = 0;

    if (coordinates.length > 2) {
      for (var i = 0; i < coordinates.length - 1; i++) {
        var p1 = coordinates[i];
        var p2 = coordinates[i + 1];
        area += convertToRadian(p2.longitude - p1.longitude) *
            (2 +
                Math.sin(convertToRadian(p1.latitude)) +
                Math.sin(convertToRadian(p2.latitude)));
      }

      area = area * 6378137 * 6378137 / 2;
    }
    return area.abs();
    // return area.abs() * 0.000247105;  //sq meters to Acres
  }

  static double convertToRadian(double input) {
    return input * Math.pi / 180;
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(icon, size: 36.0),
      heroTag:icon.toString(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("CALCUL SURFACES"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body:
      Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
            CameraPosition(
                target: LatLng(49.610757, 6.131305),
                zoom: 12.0
            ),
            mapType: _currentMapType,
            markers: _markers,
            polygons: _polygons,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            onTap: (LatLng latLng) {
              _onTapMarkerAdd(latLng);
            },
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  button(_clearAllMarkers, Icons.location_off),

                  button(_calculateArea, Icons.av_timer),

                  button(_onMapTypeButtonPressed, Icons.map),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}