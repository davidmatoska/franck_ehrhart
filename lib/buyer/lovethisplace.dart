import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:path/path.dart';
import'package:franck_ehrhart/camera/preview_lovethisplace.dart';






class Lovethisplace  extends StatefulWidget {




  @override
  _LovethisplaceState createState() => _LovethisplaceState();
}

class _LovethisplaceState extends State<Lovethisplace> {

  // Camera

  CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imgPath;

  // Geolocalisation

  Position _position;
  StreamSubscription<Position> _streamSubscription;
  Address _address;


  @override
  void initState() {
    super.initState();

    // Camera

    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
      } else {
        print('No camera available');
      }
    }).catchError((err) {
      print('Error :${err.code}Error message : ${err.message}');
    });

    // Geolocalisation

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter:10);
    _streamSubscription = Geolocator().getPositionStream(locationOptions).listen((Position position) {
      setState((){    final coordinates = new Coordinates(position.latitude, position.longitude);

      print(position);
      _position = position;

      convertCoordinatesToAddress(coordinates).then((value)=>_address=value);
      });
    });




  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
    if (mounted) {
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,

      appBar: AppBar(
        title: Text("J'AIME CET ENDROIT"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child:
                _cameraPreviewWidget(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  color: Colors.blue.shade900,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _cameraToggleRowWidget(),
                      _cameraControlWidget(context),
                      Spacer()
                    ],
                  ),
                ),
              ),

              Card(
                margin: EdgeInsets.symmetric( horizontal: 10.0, vertical :5.0),
                child: Column (
                    children: <Widget>[
                      Text ("Attendez que les coordonnées soient acquises pour prendre la photo...",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.blue.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text ("Coordonnées: lat:${_position?.latitude?? '-'}, lon:${_position?.longitude?? '-'}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.blue.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text ("Adresse: ${_address?.addressLine?? '-'}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.blue.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _cameraControlWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                _onCapturePressed(context);
              },
            )
          ],
        ),
      ),
    );
  }

  /// Display Camera preview.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }



  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraToggleRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
          onPressed: _onSwitchCamera,
          icon: Icon(
            _getCameraLensIcon(lensDirection),
            color: Colors.white,
            size: 24,
          ),
          label: Text(
            '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),),
        ),
      ),
    );
  }

  // Camera

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error:${e.code}\nError message : ${e.description}';
    print(errorText);
  }

  void _onCapturePressed(context) async {
    if (_address.addressLine != null && _position.latitude != null && _position.longitude != null  )
      try {
        final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
        await controller.takePicture(path);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewLovethisplace(
                imgPath: path,
                positionLatitude: _position.latitude ,
                positionLongitude: _position.longitude ,
                address: _address.addressLine,
              )
          ),
        );
      } catch (e) {
        _showCameraException(e);
      }
  }


  void _onSwitchCamera() {
    selectedCameraIndex =
    selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    _initCameraController(selectedCamera);
  }

  // Geolocalisation

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }



  Future <Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;

  }

}