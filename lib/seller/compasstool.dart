import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franck_ehrhart/seller/compass.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import'package:franck_ehrhart/camera/preview_compass.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter/services.dart';

class CompassTool extends StatefulWidget {

  // Screenshot
  CompassTool({Key key}) : super(key: key);

  @override
  _CompassToolState createState() => _CompassToolState();
}

class _CompassToolState extends State<CompassTool> {

  // Screenshot
  static GlobalKey screen = new GlobalKey();

  // Camera

  CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imgPath;
  String compassPath;



  // Textinput name of room

  TextEditingController nameController = TextEditingController();
  String roomName = '';

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

  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

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
        title: Text("ORIENTATION PIECES"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      //   body: Compass()
      body:

          Container(

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
                      color: Colors.blueAccent,
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
                    child:  TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Nom de la pièce',
                        border: OutlineInputBorder(),
                        labelText: 'Nom de la pièce',
                      ),
                      onChanged: (text) {
                        setState(() {
                          roomName = text;
                          //you can access nameController in its scope to get
                          // the value of text entered as shown below
                          //fullName = nameController.text;
                        }
                        );
                      },
                    ),
                  ),
                ]
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
            ),
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
    return
      //screenshot
      RepaintBoundary(
        key: screen,
     child: Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        new Positioned.fill(
          child: new AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: new CameraPreview(controller)),
        ),
        new Positioned.fill(
            child: Compass(
            )
        ),
      ],
    ),
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
    try {
      // Compass
      RenderRepaintBoundary boundary = screen.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final compassPath =
      await ImagePickerSaver.saveFile(
          fileData:byteData.buffer.asUint8List() );
      // Camera
      final path =
      join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await controller.takePicture(path);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreviewCompass(
              imgPath: path,
              compassPath: compassPath,
              roomName: roomName,
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




}

