import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Placeinfo extends StatefulWidget {
  Placeinfo({Key key}) : super(key: key);

  @override
  _PlaceinfoState createState() => _PlaceinfoState();
}

class _PlaceinfoState extends State<Placeinfo> {
  bool _showMapStyleParc = false;
  bool _showMapStyleSchool = false;
  bool _showMapStyleSport = false;
  bool _showMapStyleTransit = false;

  GoogleMapController _mapController;



  @override
  void initState() {
    super.initState();
  }




  void _toggleMapStyleSchool() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style_school.json');

    if (_showMapStyleSchool) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  void _toggleMapStyleTransit() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style_transit.json');

    if (_showMapStyleTransit) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  void _toggleMapStyleParc() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style_parc.json');

    if (_showMapStyleParc) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }

  void _toggleMapStyleSport() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style_sport.json');

    if (_showMapStyleSport) {
      _mapController.setMapStyle(style);
    } else {
      _mapController.setMapStyle(null);
    }
  }



  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("INFOS QUARTIER"),
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
        ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(49.610757, 6.131305),
              zoom: 16,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

        ],
      ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.blue.shade800,
                onPressed: () {
                  setState(() {
                    _showMapStyleSchool = !_showMapStyleSchool;
                  });

                  _toggleMapStyleSchool();
                },
                child: new IconTheme(
                  data: new IconThemeData(
                      color: Colors.white),
                  child: new Icon(FontAwesome.graduation_cap),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.red,
                onPressed: () {
                  setState(() {
                    _showMapStyleTransit = !_showMapStyleTransit;
                  });

                  _toggleMapStyleTransit();
                },
                child: new IconTheme(
                  data: new IconThemeData(
                      color: Colors.white),
                  child: new Icon(FontAwesome.train),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.green.shade500,
                onPressed: () {
                  setState(() {
                    _showMapStyleParc = !_showMapStyleParc;
                  });

                  _toggleMapStyleParc();
                },
                child: new IconTheme(
                  data: new IconThemeData(
                      color: Colors.white),
                  child: new Icon(FontAwesome.tree),
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.yellow.shade800,
                onPressed: () {
                  setState(() {
                    _showMapStyleSport = !_showMapStyleSport;
                  });

                  _toggleMapStyleSport();
                },
                child: new IconTheme(

                  data: new IconThemeData(

                      color: Colors.white),
                  child: new Icon(FontAwesome.soccer_ball_o),

                ),
              ),
            ],
          ),
        )


    );
  }
}