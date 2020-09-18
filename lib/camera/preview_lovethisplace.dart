import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// packages screenshot
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_icons/flutter_icons.dart';


class PreviewLovethisplace extends StatefulWidget{
  final String imgPath;

  // Geolocalisation

  final double positionLongitude;
  final double positionLatitude;
  final String address;


  PreviewLovethisplace({this.imgPath,this.positionLatitude,this.positionLongitude,this.address});


  @override
  _PreviewLovethisplaceState createState() => _PreviewLovethisplaceState();

}
class _PreviewLovethisplaceState extends State<PreviewLovethisplace>{

  // Screenshot

  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();


  @override
  Widget build(BuildContext context) {
     return Screenshot(
      controller: screenshotController,
      child:
      Scaffold(
        backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("J'AIME CET ENDROIT"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,

      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.file(File(widget.imgPath),fit: BoxFit.cover,),
            ),
            Card(
                margin: EdgeInsets.symmetric( horizontal: 10.0, vertical :5.0),
              child: ListTile (
                  leading: Icon(
                    FontAwesome.compass,
                    color: Colors.blue.shade900,
                  ),
                  title: (
                      Text ("lat:${widget?.positionLatitude?.toString()}---lon:${widget?.positionLongitude?.toString()}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.blue.shade900,
                        ),
                      )
                  ),
              )
            ),
            Card(
                margin: EdgeInsets.symmetric( horizontal: 10.0, vertical :5.0),
                child: ListTile (
                  leading: Icon(
                    FontAwesome.map_signs,
                    color: Colors.blue.shade900,
                  ),
                  title: (
                      Text (widget?.address?.toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.blue.shade900,
                        )
                      )
                  ),
                )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.black,
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.share,color: Colors.white,),
                    onPressed: () async {
                      _takeScreenshotandShare();
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      ),
    );
  }


  // Screenshot

  _takeScreenshotandShare() async {
    _imageFile = null;
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Screenshot', 'screenshot.png', pngBytes, 'image/png');
    })
        .catchError((onError) {
      print(onError);
    });
  }



}

